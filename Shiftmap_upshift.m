
%% ASSIGNING RESULTS FROM DPM

gear=res.X{1};
Velocity.vel=res.w_kmph;
Throttle.throttle=res.Throttle;
Acceleration.acc = par.DC.a;
cost=res.C{1};


%% GEARSHIFTS

 shift_up=zeros(size(Velocity.vel));
 cost_shiftup = zeros(size(cost));
 %Sorting to find velocity at each gear up-shift
 Velocity.vel_12=shift_up;
 Velocity.vel_23=shift_up;
 Velocity.vel_34=shift_up;
 Velocity.vel_45=shift_up;
 Velocity.vel_56=shift_up;
 Velocity.vel_67=shift_up;
 
 
 %Sorting to find throttle at gear up-shift
 Throttle.th_12=shift_up;
 Throttle.th_23=shift_up;
 Throttle.th_34=shift_up;
 Throttle.th_45=shift_up;
 Throttle.th_56=shift_up;
 Throttle.th_67=shift_up;
 
 %Sorting to find acceleration at each gear up-shift
 Acceleration.acc_12=shift_up;
 Acceleration.acc_23=shift_up;
 Acceleration.acc_34=shift_up;
 Acceleration.acc_45=shift_up;
 Acceleration.acc_56=shift_up;
 Acceleration.acc_67=shift_up;
%costdiff=zeros(numel(par.GB.rg),length(Velocity.vel));
 
 %Finding and storing gearshift timepoints
for i=1:length(gear)-1
    if gear(i+1)==2 && gear(i)==1
        shift_up(i) = 12;
        Velocity.vel_12(i) = Velocity.vel(i);
        Throttle.th_12(i) = Throttle.throttle(i);
        Acceleration.acc_12(i) = Acceleration.acc(i);
        cost_shiftup(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    elseif gear(i+1)==3 && gear(i)==2
        shift_up(i) = 23;
        Velocity.vel_23(i) = Velocity.vel(i);
        Throttle.th_23(i) = Throttle.throttle(i);
        Acceleration.acc_23(i) = Acceleration.acc(i);
        cost_shiftup(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    elseif gear(i+1)==4 && gear(i)==3
        shift_up(i) = 34;
        Velocity.vel_34(i) = Velocity.vel(i);
        Throttle.th_34(i) = Throttle.throttle(i);
        Acceleration.acc_34(i) = Acceleration.acc(i);
        cost_shiftup(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    elseif gear(i+1)==5 && gear(i)==4
        shift_up(i) = 45;
        Velocity.vel_45(i) = Velocity.vel(i);
        Throttle.th_45(i) = Throttle.throttle(i);
        Acceleration.acc_45(i) = Acceleration.acc(i);
        cost_shiftup(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    elseif gear(i+1)==6 && gear(i)==5
        shift_up(i) = 56;
        Velocity.vel_56(i) = Velocity.vel(i);
        Throttle.th_56(i) = Throttle.throttle(i);
        Acceleration.acc_56(i) = Acceleration.acc(i);
        cost_shiftup(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i});
    elseif gear (i+1)==7 && gear(i)==6
        shift_up(i) = 67;
        Velocity.vel_67(i) = Velocity.vel(i);
        Throttle.th_67(i) = Throttle.throttle(i);
        Acceleration.acc_67(i) = Acceleration.acc(i);
        cost_shiftup(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    end
    
end

%% Assigning zero values as NaN for plotting
 shift_up(shift_up==0)=NaN;
 cost_shiftup(cost_shiftup==0) = NaN;
%  costdiff(costdiff==0) = NaN;
 
 Velocity.vel_12(Velocity.vel_12==0)=NaN;
 Velocity.vel_23(Velocity.vel_23==0)=NaN;
 Velocity.vel_34(Velocity.vel_34==0)=NaN;
 Velocity.vel_45(Velocity.vel_45==0)=NaN;
 Velocity.vel_56(Velocity.vel_56==0)=NaN;
 Velocity.vel_67(Velocity.vel_67==0)=NaN;
 
 Throttle.th_12(Throttle.th_12==0)=NaN;
 Throttle.th_23(Throttle.th_23==0)=NaN;
 Throttle.th_34(Throttle.th_34==0)=NaN;
 Throttle.th_45(Throttle.th_45==0)=NaN;
 Throttle.th_56(Throttle.th_56==0)=NaN;
 Throttle.th_67(Throttle.th_67==0)=NaN;
 
 Acceleration.acc_12(Acceleration.acc_12==0)=NaN;
 Acceleration.acc_23(Acceleration.acc_23==0)=NaN;
 Acceleration.acc_34(Acceleration.acc_34==0)=NaN;
 Acceleration.acc_45(Acceleration.acc_45==0)=NaN;
 Acceleration.acc_56(Acceleration.acc_56==0)=NaN;
 Acceleration.acc_67(Acceleration.acc_67==0)=NaN;


%% PLOT SHIFT POINTS in ONE MAP

figure;
hold on
grid minor

title('Gear Upshift Points')
xlabel('Velocity [km/h]');
ylabel('Throttle [-]');
zlabel('Instantaneous Cost');
axis([0 150 0 1]);
legend('show');

plot3(Velocity.vel_12,Throttle.th_12,cost_shiftup,'c.','MarkerSize',18)

plot3(Velocity.vel_23,Throttle.th_23,cost_shiftup,'b.','MarkerSize',18)

plot3(Velocity.vel_34,Throttle.th_34,cost_shiftup,'k.','MarkerSize',18)

plot3(Velocity.vel_45,Throttle.th_45,cost_shiftup,'r.','MarkerSize',18)

plot3(Velocity.vel_56,Throttle.th_56,cost_shiftup,'g.','MarkerSize',18)

plot3(Velocity.vel_67,Throttle.th_67,cost_shiftup,'m.','MarkerSize',18)




%% PLOT VEHICLE VELOCITY LIMITS at EACH GEAR

hold on

plot([(par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re],[0,1],'c-.', 'LineWidth',1.3);
plot([(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re],[0,1],'c-', 'LineWidth',1.3);


plot([(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'b-.', 'LineWidth',1.3);
plot([(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'b-', 'LineWidth',1.3);


plot([(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'k-.', 'LineWidth',1.3);
plot([(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'k-', 'LineWidth',1.3);


plot([(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re],[0,1],'r-.', 'LineWidth',1.3);
plot([(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re],[0,1],'r-', 'LineWidth',1.3);


plot([(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re],[0,1],'g-.', 'LineWidth',1.3);
% plot([(max(par.ENG.we_max)/par.GB.rg(5))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(5))*3.6*par.VEH.re],[0,1],'g--', 'LineWidth',1.3);


plot([(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re],[0,1],'m-.', 'LineWidth',1.3);
% plot([(max(par.ENG.we_max)/par.GB.rg(6))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(6))*3.6*par.VEH.re],[0,1],'m--', 'LineWidth',1.3);


plot([(par.ENG.w_idle/par.GB.rg(7))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(7))*3.6*par.VEH.re],[0,1],'y-.', 'LineWidth',1.3);
% plot([(max(par.ENG.we_max)/par.GB.rg(7))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(7))*3.6*par.VEH.re],[0,1],'b-', 'LineWidth',1.3);

legend('1^{st} gear to 2^{nd}','2^{nd} gear to 3^{rd}',...
        '3^{rd} gear to 4^{th}','4^{th} gear to 5^{th}',...
        '5^{th} gear to 6^{th}','6^{th} gear to 7^{th}',...
        'Min velocity at 1^{st}','Max velocity at 1^{st}',...
        'Min velocity at 2^{nd}','Max velocity at 2^{nd}',...
        'Min velocity at 3^{rd}','Max velocity at 3^{rd}',...
        'Min velocity at 4^{th}','Max velocity at 4^{th}',...
        'Min velocity at 5^{th}','Min velocity at 6^{th}',...
        'Min velocity at 7^{th}','Location','northeast');
    
    
%% PLOT INDIVIDUAL GEAR SHIFT POINTS

%MAX TORQUE LINE
eng_speed = par.ENG.w_idle:1:max(par.ENG.we_max);
t_max = interp1(par.ENG.we_max,par.ENG.Tmax,eng_speed);



%Upshift 1-2
figure;
hold on
grid minor

plot(Velocity.vel_12,Throttle.th_12,'c.','MarkerSize',18)
xlabel('Velocity [km/h]');
ylabel('Throttle [-]');
title('Shift points 1^{st} to 2^{nd}')
axis([0 150 0 1]);
plot([(par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re],[0,1],'c-.');
plot([(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re],[0,1],'c--');

%Plot max torque line
Velocity.vel12_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re,numel(t_max));
yyaxis right
ylabel('Torque [Nm]')
axis([0 150 0 max(t_max)]);
plot(Velocity.vel12_wrt_tmax,t_max, 'c-')





%Upshift 2-3
figure;
hold on
grid minor

plot(Velocity.vel_23,Throttle.th_23,'b.','MarkerSize',18)
xlabel('Velocity [km/h]');
ylabel('Throttle [-]');
title('Shift points 2^{nd} to 3^{rd}')
axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'b-.');
plot([(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'b--');

%Plot max torque line
Velocity.vel23_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re,numel(t_max));
yyaxis right
ylabel('Torque [Nm]')
axis([0 150 0 max(t_max)]);
plot(Velocity.vel23_wrt_tmax,t_max, 'b-')


%Upshift 3-4
figure;
hold on
grid minor

plot(Velocity.vel_34,Throttle.th_34,'k.','MarkerSize',18)
xlabel('Velocity [km/h]');
ylabel('Throttle [-]');
title('Shift points 3^{rd} to 4^{th}')
axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'k-.');
plot([(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'k--');

%Plot max torque line
Velocity.vel34_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re,numel(t_max));
yyaxis right
ylabel('Torque [Nm]')
axis([0 150 0 max(t_max)]);
plot(Velocity.vel34_wrt_tmax,t_max, 'k-')



%Upshift 4-5
figure;
hold on
grid minor

plot(Velocity.vel_45,Throttle.th_45,'r.','MarkerSize',18)
xlabel('Velocity [km/h]');
ylabel('Throttle [-]');
title('Shift points 4^{th} to 5^{th}')
axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re],[0,1],'r-.');
plot([(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re],[0,1],'r--');

%Plot max torque line
Velocity.vel45_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re,numel(t_max));
yyaxis right
ylabel('Torque [Nm]')
axis([0 150 0 max(t_max)]);
plot(Velocity.vel45_wrt_tmax,t_max, 'r-')




%Upshift 5-6
figure;
hold on
grid minor

plot(Velocity.vel_56,Throttle.th_56,'g.','MarkerSize',18)
grid on
xlabel('Velocity [km/h]');
ylabel('Throttle [-]');
title('Shift points 5^{th} to 6^{th}')

axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re],[0,1],'g-.');

%Plot max torque line
Velocity.vel56_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(5))*3.6*par.VEH.re,numel(t_max));
yyaxis right
ylabel('Torque [Nm]')
axis([0 150 0 max(t_max)]);
plot(Velocity.vel56_wrt_tmax,t_max, 'g-')





%Upshift 6-7
figure;
hold on
grid minor

plot(Velocity.vel_67,Throttle.th_67,'m.','MarkerSize',18)
xlabel('Velocity [km/h]');
ylabel('Throttle [-]');
title('Shift points 6^{th} to 7^{th}')
axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re],[0,1],'m-.');

%Plot max torque line
Velocity.vel67_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(6))*3.6*par.VEH.re,numel(t_max));
yyaxis right
ylabel('Torque [Nm]')
axis([0 150 0 max(t_max)]);
plot(Velocity.vel67_wrt_tmax,t_max, 'm-')



%Number of Shifts
Num_UpShift_DP = numel(shift_up(shift_up > 0));
fprintf('Number of Upshifts in DP = %i \n',Num_UpShift_DP);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%