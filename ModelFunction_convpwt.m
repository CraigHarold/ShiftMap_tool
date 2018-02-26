     function [X, C, I, out] = ModelFunction_convpwt(inp,par)

%%%%Initial assigning based on user input

     Drivability_mode = par.Tuning.mode;
     Switching_loss = par.Tuning.switching_loss;                            % Shifting losses [percentage of fuel consumed]
     gamma = par.Tuning.gamma;
     constant_Torque_reserve  = par.Tuning.const_Tres;                      %[percentage of torque reserve]

    Drivability_mode = round(min(max(1,Drivability_mode),4));
    
    gamma = min(max(0,gamma),1);
    
    alpha = (Drivability_mode==1).*(1) + (Drivability_mode==2).*(0) +...  
            (Drivability_mode==3).*(gamma) + (Drivability_mode==4).*(1);    % Fuel economy vs Drivability
        
    beta = min(max(0,Switching_loss),100);                                  % Shifting losses [% gms of fuel]
    
    const_Tres = (Drivability_mode==4).*((100-abs(constant_Torque_reserve))/100) +...
                    (Drivability_mode<4).*(0);                              %Make constant only for option 4



%% Model Function

% First make sure Gear selection is integer to prevent errors!
inp.U{1} = round(inp.U{1});
inp.X{1} = floor(inp.X{1});
X{1} = inp.X{1} + inp.U{1};


%__________________________________________________________________________

%%%%VEHICLE

% Wheel speed (rad/s)
wv  = inp.W{1} ./ par.VEH.re;
% Wheel acceleration (rad/s^2)
dwv = inp.W{2} ./ par.VEH.re;

% Wheel torque (Nm)

F_roll = (inp.W{1}>0).*(par.VEH.Mv.*par.VEH.g.*par.VEH.mu);

Tv = (0.5.*par.VEH.rho.*par.VEH.Cd.*par.VEH.S_eff.*inp.W{1}.^2 + ...
        par.VEH.Mv.*(1+par.VEH.Mf).*inp.W{2} + F_roll) .* par.VEH.re;
    

%__________________________________________________________________________

%%%%TRANSMISSION

% Crankshaft speed (rad/s)
wg  = (inp.X{1}>0) .* par.GB.rg(inp.X{1} + (inp.X{1}==0)) .* wv;
% Crankshaft acceleration (rad/s^2)
dwg = (inp.X{1}>0) .* par.GB.rg(inp.X{1} + (inp.X{1}==0)) .* dwv;


%__________________________________________________________________________

%%%%Engine Speed and Friction losses

% Limit engine speed
we= min(max(wg,par.ENG.w_idle),par.ENG.we_max(end));

% Engine drag torque (Nm)
Te0  = (abs(dwg) .* par.ENG.J) + interp1(par.ENG.we_list,par.ENG.Te0_list,...
            min(max(we,par.ENG.we_list(1)),par.ENG.we_list(end)));
 
% Engine Torque approximation
T_prev = abs((Tv>=0).*inp.X{2});
        
% Gearbox efficiency
eta = (inp.X{1}==1).*interp1(par.GB.M_inp,par.GB.eff_LDS012345.table,T_prev)...
+ (inp.X{1}==2).*interp1(par.GB.M_inp,par.GB.eff_LDS012345.table,T_prev)...
+ (inp.X{1}==3).*interp1(par.GB.M_inp,par.GB.eff_LDS012345.table,T_prev)...
+ (inp.X{1}==4).*interp1(par.GB.M_inp,par.GB.eff_LDS9_brake.table,T_prev)...
+ (inp.X{1}==5).*interp1(par.GB.M_inp,par.GB.eff_LDS11.table,T_prev)...
+ (inp.X{1}==6).*interp1(par.GB.M_inp,par.GB.eff_LDS11.table,T_prev)...
+ (inp.X{1}==7).*interp1(par.GB.M_inp,par.GB.eff_LDS13.table,T_prev); 
%eta=max(eta,1);



%__________________________________________________________________________

%%%%Torque Transmission

% Crankshaft torque (Nm)
Tg  = (inp.X{1}>0) .* (Tv>=0)  .* Tv ./ par.GB.rg(inp.X{1} + (inp.X{1}==0))...
        ./ eta + (inp.X{1}>0) .* (Tv<0) .* (-Te0);
 
%__________________________________________________________________________

%%%%ENGINE


%Deceleration check
dec =((dwv < 0)&(wv > 0)&(we > par.ENG.w_idle))&(Tv<0);

% Total torque required (Nm)
T_CE = Te0 + abs(Tg);   %(!!!Only included when engine torque is positive, hence the abs(Tg)!!!)

% Torque provided by engine (Nm)
Te  = (((Tv >= 0).*(T_CE) + (Tv < 0).*(-Te0)));

X{2} = abs(Te);    %Storing Torque of engine for eta in next stage


% Maximum engine torque at current RPM [Nm]
Te_max1 = interp1(par.ENG.we_max,par.ENG.Tmax,we,'linear','extrap');

%Limiting maximum achievable torque at user-specified constant torque reserve
Te_max = (Drivability_mode==4).*(const_Tres*Te_max1) + (Drivability_mode~=4).*(Te_max1);

%Throttle
Throttle = (Te./max(par.ENG.Tmax)).*(dec~=1).*(Te>0);                       %Normalized Throttle

Throttle_ac = (Te./Te_max).*(dec~=1).*(Te>0);

% Max Power at engine speed
Pe_max = Te_max.*we;

% Power at current engine speed
P_eng = Te.*we;

% Probable acceleration at current vehicle velocity
 w_kmph = inp.W{1}.*3.6;
 Acc_p = par.acc.a1.*sin(par.acc.b1.*w_kmph+par.acc.c1) + par.acc.a2.*...
            sin(par.acc.b2.*w_kmph+par.acc.c2) + par.acc.a3.*...
            sin(par.acc.b3.*w_kmph+par.acc.c3);

%Power reserve required to achive acceleration
P_res_req = Acc_p.*w_kmph.*par.VEH.Mv.*0.0000001;


%Power reserve
P_res = (Pe_max - P_eng);

%Normalized Power reserve
P_res_N = 500.*(((Tg>=0).*(P_res) +...                                     % 500-factor to equate m_fuel and P_res
          (Tg<0).*(Te_max.*we)))./(max(par.ENG.Tmax).*max(par.ENG.we_max));   

%Normalized Torque reserve
T_res = (Te_max - Te);
T_res_N = 70.*((Tg>=0).*(T_res) + (Tg<0).*(Te_max))./(max(par.ENG.Tmax));  % 70 - Weighting factor for T_res
%__________________________________________________________________________

%%%%COST FUNCTION



% BSFC(Throttle percentage,Omega) [g/kwh]plot
BSFC = interp2(par.ENG.BSFC.Throttle,par.ENG.BSFC.we,par.ENG.BSFC.map,...
            Throttle,we.*ones(size(Te)),'spline');
       

%Normalized BSFC
BSFC_N = BSFC./max(par.ENG.BSFC.map(:));

% Fuel consumption [g/s]
m_dot_fuel = (Te>0).*Te.*we.*BSFC.*(1/3600).*0.001;

%Max fuel consumption
m_dot_fuel_max =(max(par.ENG.Tmax) .*max(par.ENG.we_max).*max(par.ENG.BSFC.map(:)).*(1/3600).*0.001);  %To normalize (impossible operation points)

%Normalized Fuel consumption
m_dot_fuel_N = ((m_dot_fuel)./(m_dot_fuel_max));
 
% Fuel power consumption [W]
Pe = m_dot_fuel .* par.ENG.lhv;

% Calculate infeasible
  ine = (Te > Te_max);                                  %infeasible Torque
  inpo = (P_eng > Pe_max);                              %infeasible Power
  inGB = (wg > par.ENG.we_max(end));                    %infeasible gearbox speed
  inup = (wg < min(par.ENG.w_idle)).*(inp.U{1} == 1);   %infeasible upshift while clutch is slipping
  indwn = (wg < min(par.ENG.w_idle)).*(inp.U{1} == -1); %infeasible downshift at speeds lower than idling
  inshift = (dec==1).*(inp.U{1}==1);                    %Infeasible upshift while decelerating
  
% Summarize infeasible matrix
I = (ine+inpo+inGB+inup+indwn+inshift~=0);


% Switching Costs
SwC = (inp.X{1} - (inp.X{1} + inp.U{1}) == 1).*((beta/400)) +...
      ((inp.X{1} + inp.U{1}) - inp.X{1} == 1).*((beta/400)) ;


%Total fuel consumption
Total_fc = (m_dot_fuel_N + SwC); 

% Calculate cost matrix (fuel mass flow) and having engine on 
C{1}  = (alpha).*Total_fc + (1-alpha)./T_res_N;
%__________________________________________________________________________

%%%%SIGNALS

%   store relevant signals in out
out.Te = Te;
out.Tg = Tg;
out.T_CE = T_CE;
out.wg = wg;
out.Te_max = Te_max;
out.m_fuel = m_dot_fuel;
out.Tv = Tv;
out.wv = wv;
out.dwv = dwv;
out.dwg = dwg;
out.Te0 = Te0;
out.BSFC = BSFC;
out.we = we;
out.Throttle = Throttle;
out.Te_max = Te_max;
out.dec = dec;
out.P_eng = P_eng;
out.Pe_max = Pe_max;
out.w_kmph = w_kmph;
out.Acc_p = Acc_p;
out.P_res = P_res;
out.GearboxEff = eta;
out.T_previous = T_prev;
out.time = (inp.U{1});
out.SwC = SwC;
out.m_fuel_N = m_dot_fuel_N;
out.BSFC_N = BSFC_N;
out.m_fuel_max = m_dot_fuel_max;
out.P_res_N = P_res_N;
out.T_res_N = T_res_N;
out.Total_FC = Total_fc;
out.Veh_acc = inp.W{2};
out.Veh_vel = inp.W{1};
out.Clutchslip = inup;
out.Drivability = Drivability_mode;
out.alpha = alpha;
out.beta = beta;
out.gamma = gamma;
out.Constant_Tres = const_Tres;
out.Te_max1 = Te_max1;
out.Throttle_actual = Throttle_ac;
out.T_res = T_res;
