close all; clc;

%% 1-2

CoSL=1;   % centroids for 1st shift line(i=1) to 6th shift line(i=6)
%DoP= 1;  % degree of polynomial fit, could be changed indivdually within sections
    
p12=polyfit((C{CoSL}(:,1)),(C{CoSL}(:,2)),DoP);
    
    
%     figure;
hold on
grid minor
%     plot3(vel_12,th_12,cost_shiftup,'c.')
title('Shift lines')
xlabel('Velocity [km/h]');
ylabel('Throttle');
zlabel('Instantaneous Cost');

axis([0 150 0 1]);
plot([(par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re],[0,1],'c--');
plot([(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re],[0,1],'c-');

%Plot max torque line
vel12_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re,numel(t_max));
yyaxis right
ylabel('Torque [Nm]')
axis([0 150 0 143]);
plot(vel12_wrt_tmax,t_max, 'c-')

if DoP==3
pp12 = p12(1)*(vel12_wrt_tmax.^3)+p12(2)*(vel12_wrt_tmax.^2)+p12(3)*(vel12_wrt_tmax)+p12(4);
elseif DoP==2
pp12 = p12(1)*(vel12_wrt_tmax.^2)+p12(2)*(vel12_wrt_tmax)+p12(3);
elseif DoP==1
pp12 = p12(1)*(vel12_wrt_tmax)+p12(2);
end
yyaxis left
plot(vel12_wrt_tmax,pp12,'c-','LineWidth',2)



%% 2-3
CoSL=2;
    p23=polyfit((C{CoSL}(:,1)),(C{CoSL}(:,2)),DoP);
    
    
%     figure;
hold on
grid minor

%  plot3(vel_23,th_23,cost_shiftup,'b.')
xlabel('Velocity');
ylabel('Throttle');
zlabel('Instantaneous Cost');
axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'b--');
plot([(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'b-');

%Plot max torque line
vel23_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re,numel(t_max));
yyaxis right
axis([0 150 0 143]);
plot(vel23_wrt_tmax,t_max, 'b-')

if DoP==3
   pp23 = p23(1)*(vel23_wrt_tmax.^3)+p23(2)*(vel23_wrt_tmax.^2)+p23(3)*(vel23_wrt_tmax)+p23(4);
elseif DoP==2
   pp23 = p23(1)*(vel23_wrt_tmax.^2)+p23(2)*(vel23_wrt_tmax.^1)+p23(3);
elseif DoP==1
   pp23 = p23(1)*(vel23_wrt_tmax.^1)+p23(2);
end
yyaxis left
plot(vel23_wrt_tmax,pp23,'b-','LineWidth',2)


%% 3-4
if min(isnan(Velocity.vel_34))==1
    print('No upshifts available for 3 to 4')
else
CoSL=3;
    p34=polyfit((C{CoSL}(:,1)),(C{CoSL}(:,2)),DoP);
    
%     figure;
hold on
grid minor

% plot3(vel_34,th_34,cost_shiftup,'k.')
xlabel('Velocity [km/h]');
ylabel('Throttle');
zlabel('Instantaneous Cost');
axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'k--');
plot([(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'k-');

%Plot max torque line
vel34_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re,numel(t_max)); %Spacing out min and max velocity equally with number of torque max elements therefore interpolating it to correct bounds
yyaxis right
axis([0 150 0 143]);
plot(vel34_wrt_tmax,t_max,'k-')

if DoP==3
    pp34 = p34(1)*(vel34_wrt_tmax.^3) + p34(2)*(vel34_wrt_tmax.^2) + p34(3)*(vel34_wrt_tmax) + p34(4);
elseif DoP==2
    pp34 =  p34(1)*(vel34_wrt_tmax.^2) + p34(2)*(vel34_wrt_tmax) + p34(3);
elseif DoP==1
    pp34 =  p34(1)*(vel34_wrt_tmax) + p34(2);
end
yyaxis left
plot(vel34_wrt_tmax,pp34, 'k-','LineWidth',2)

end

%% 4-5

if min(isnan(Velocity.vel_45))==1
    print('No upshifts available for 4 to 5')

else
CoSL=4;

    p45=polyfit((C{CoSL}(:,1)),(C{CoSL}(:,2)),DoP);
    
%     figure;
hold on
grid minor

% plot3(vel_45,th_45,cost_shiftup,'r.')
xlabel('Velocity [km/h]');
ylabel('Throttle');
zlabel('Instantaneous Cost');
axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re],[0,1],'r--');
plot([(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re],[0,1],'r-');

%Plot max torque line
vel45_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re,numel(t_max));
yyaxis right
axis([0 150 0 143]);
plot(vel45_wrt_tmax,t_max, 'r-')

if DoP==3
    pp45 = p45(1)*(vel45_wrt_tmax.^3) + p45(2)*(vel45_wrt_tmax.^2) + p45(3)*(vel45_wrt_tmax) + p45(4);
elseif DoP==2
    pp45 = p45(1)*(vel45_wrt_tmax.^2) + p45(2)*(vel45_wrt_tmax) + p45(3);
elseif DoP==1
    pp45 = p45(1)*(vel45_wrt_tmax) + p45(2);
end
    
yyaxis left
plot(vel45_wrt_tmax,pp45,'r-','LineWidth',2);
end

%% 5-6

if min(isnan(Velocity.vel_56))==1
    print('No upshifts available for 5 to 6')
 
else
CoSL=5;

    p56=polyfit((C{CoSL}(:,1)),(C{CoSL}(:,2)),DoP);

%     figure;
hold on
grid minor

% plot3(vel_56,th_56,cost_shiftup,'g.')
grid on
xlabel('Velocity [km/h]');
ylabel('Throttle');
zlabel('Instantaneous Cost');
axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re],[0,1],'g--');

%Plot max torque line
vel56_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(5))*3.6*par.VEH.re,numel(t_max));
yyaxis right
axis([0 150 0 143]);
plot(vel56_wrt_tmax,t_max, 'g-')

if DoP==3
    pp56 = p56(1)*(vel56_wrt_tmax.^3) + p56(2)*(vel56_wrt_tmax.^2) + p56(3)*(vel56_wrt_tmax) + p56(4);
elseif DoP==2
    pp56 = p56(1)*(vel56_wrt_tmax.^2) + p56(2)*(vel56_wrt_tmax) + p56(3);
elseif DoP==1
    pp56 = p56(1)*(vel56_wrt_tmax) + p56(2);
end
yyaxis left
plot(vel56_wrt_tmax,pp56,'g-','LineWidth',2);
end

%% 6-7

if min(isnan(Velocity.vel_67))==1
    print('No upshifts available for 6 to 7')
else

CoSL=6;

    p67=polyfit((C{CoSL}(:,1)),(C{CoSL}(:,2)),DoP);
    
    
hold on
grid minor

xlabel('Velocity [km/h]');
ylabel('Throttle');
zlabel('Instantaneous Cost');
axis([0 150 0 1]);

plot([(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re],[0,1],'m--');

%Plot max torque line
vel67_wrt_tmax = linspace((par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(6))*3.6*par.VEH.re,numel(t_max));
yyaxis right
axis([0 150 0 max(t_max)]);
plot(vel67_wrt_tmax,t_max, 'm-')


if DoP==3
    pp67 = p67(1)*(vel67_wrt_tmax.^3) + p67(2)*(vel67_wrt_tmax.^2) + p67(3)*(vel56_wrt_tmax) + p67(4);
elseif DoP==2
    pp67 = p67(1)*(vel67_wrt_tmax.^2) + p67(2)*(vel67_wrt_tmax) + p67(3);
elseif DoP==1
    pp67 = p67(1)*(vel67_wrt_tmax) + p67(2);
end

yyaxis left
plot(vel67_wrt_tmax,pp67,'m-','LineWidth',2);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%