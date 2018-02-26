% clear all; clc; close all;

load dakota_config
init_par();

%% Throttle based BSFC --> Torque based
Te_max = interp1(par.ENG.we_max,par.ENG.Tmax,par.ENG.BSFC.we,'linear');

Te_vector = linspace(0,max(Te_max),length(par.ENG.BSFC.Throttle));
BSFC_T=zeros(size(par.ENG.BSFC.map));
for i = 1 : length(Te_max)
    t_max = Te_max(i);
    BSFC_T(i,:)=interp2(par.ENG.BSFC.Throttle,par.ENG.BSFC.we,...
                    par.ENG.BSFC.map,Te_vector/t_max,par.ENG.BSFC.we(i));
end

%% Create Grid

grd.Nx{1}    = 7;  % Gear number
grd.Xn{1}.hi = 7; 
grd.Xn{1}.lo = 1;

grd.Nx{2} = 151;    %Previous Torque state
grd.Xn{2}.hi = 150;
grd.Xn{2}.lo = 0;

grd.Nu{1}    = 3;  % Gear selector 
grd.Un{1}.hi = +1; 
grd.Un{1}.lo = -1;

%Initial state
grd.X0{1} = 1;
grd.X0{2} = 0;

% final state constraints
grd.XN{1}.hi = 1;
grd.XN{1}.lo = 1;

grd.XN{2}.hi = 150;
grd.XN{2}.lo = 0;

%% Set options
options = dpm();
options.Waitbar = 'off';
options.MyInf = 10000000;
options.Verbose = 'on';
options.BoundaryMethod = 'none'; % also possible: 'none' or 'LevelSet';
% if strcmp(options.BoundaryMethod,'Line') 
%     %these options are only needed if 'Line' is used
%     options.Iter = 7;
%     options.Tol = 1e-8;
%     options.FixedGrid = 0;
% end

%% Drive Cycle
for i = 1 : length(cycles)
    % load drivecycle parameters
    cycle = cycles{i};
    % Map inputs to correct .mat files.
    if  strcmp('NEDC',cycle)
        par.DC = Init_drivecycle_dpm('NEDC_MAN');
    elseif strcmp('FTP',cycle)
        par.DC = Init_drivecycle_dpm('FTP_75');
    elseif strcmp('10_15',cycle)
        par.DC = Init_drivecycle_dpm('10_15_MODE');
     elseif strcmp('Combined_five',cycle)                %7 drive cycles with full throttle simulation
         par.DC = Init_drivecycle_dpm('DriveCycle_combined');
     elseif strcmp('Combined_sevenstd',cycle)         %7 Combined standard cycles
         par.DC = Init_drivecycle_dpm('DriveCycle_combined2');
     elseif strcmp('Combined_twelvestd',cycle)            %12 Combined standard cycles
         par.DC = Init_drivecycle_dpm('DriveCycle_standardcombined');    
    else
        break
    end
    % Print total distance for drivecycle.
    fprintf('%s: %d of %d \n',cycle,i,length(cycles));
    distance = cumtrapz(par.DC.T,par.DC.v);
    fprintf('Total distance = %.2f [m] \n',distance(end));

    % define problem
    prb.W{1}    = par.DC.v; % Speed
    prb.W{2}    = par.DC.a; % Acceleration
    prb.T       = par.DC.T;
    prb.Ts      = par.DC.Ts;
    prb.N       = length(prb.W{1});
    
    
    %% DPM
    try
        tic
        [res, dyn] = dpm(@ModelFunction_convpwt,par,grd,prb,options);
        toc
    catch
        break
    end
    
end
    
Litre_100km = sum(res.m_fuel)/745*100/(distance(end)/1000);
%% %Plot figures
    

       figure;
        
        ax1=subplot(2,1,1);
                title('GearShift and Velocity Profile')
%                 yyaxis left
                plot(prb.T,prb.W{1}.*3.6);
                ylabel('Speed [km/h]')
                yyaxis right
                stairs([prb.T prb.T(end)+prb.Ts],res.X{1});
                axis([0 numel(res.time) 0 7])
                ylabel('Gear Number [-]'); 
            grid minor
            
            ax2=subplot(2,1,2);
                title('Fuel Consumption')
                yyaxis left
                plot(prb.T,res.m_fuel)
                ylabel('Fuel [g/s]')
                yyaxis right
                plot(prb.T,cumsum(res.m_fuel))
                ylabel('Total fuel consumed [g]')
                xlabel('Timesteps')
           grid minor
        linkaxes([ax1 ax2],'x');
        

        figure;
    
        hold on
        contour(par.ENG.BSFC.we.*(60/(2*pi)),Te_vector,BSFC_T',[100 243 250 275 260 ...
                    300 400 500],'ShowText','on');
         plot(par.ENG.we_max.*(60/(2*pi)),par.ENG.Tmax);

        title ('Operating point ENG [g/kwh]')
        % Engine torque which has fuel consumption
        h1 = plot( res.we(res.we > par.ENG.w_idle & res.Te~=0).*(60/(2*pi)), ...
                   res.Te(res.we > par.ENG.w_idle & res.Te~=0),'ro');
        
        xlabel('Rotation speed [rpm]')
        ylabel('Torque [Nm]')
        legend([h1],{'Engine Operating Point'})
        grid minor
        

        figure;
        hold on
        subplot(2,3,1)
        plot((1:numel(res.time)),res.Te)
        hold
        plot((1:numel(res.time)),res.Te_max)
        ylabel('Engine Torque [Nm]')
        
        subplot(2,3,2)
        plot((1:numel(res.time)),res.we)
        ylabel('Engine Speed [rad/s]')
        
        subplot(2,3,3)
        plot((1:numel(res.time)),res.Tg)
        ylabel('Gearbox Torque [Nm]')
        
        subplot(2,3,4)
        plot((1:numel(res.time)),res.Throttle)
        ylabel('Throttle')
        
        subplot(2,3,5)
        plot((1:numel(res.time)),res.w_kmph)
        ylabel('Vehicle Speed [km/h]')
        
        subplot(2,3,6)
        plot((1:numel(res.time)),res.Te0)
        ylabel('Engine drag losses [Nm]')
        
        
        
    % make sure all graphs are done
    drawnow update;
    
    
 

%PRINT results

%Driving mode

if Drivability_mode == 1
    fprintf('\nDriving mode = Eco \n');
elseif Drivability_mode == 2
    fprintf('\nDriving mode = Sport \n');
elseif Drivability_mode == 3
    fprintf('\nDriving mode = Normal with balance ratio %0.1f \n',par.Tuning.gamma);
elseif Drivability_mode == 4
    fprintf('\nDriving mode = Constant Torque reserve \n');
end

%Fuel consumption

fprintf('Fuel consumption in DP = %0.3f \n', Litre_100km)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   