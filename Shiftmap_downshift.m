
%% ASSIGNING RESULTS FROM DPM

gear=res.X{1};
vel=res.w_kmph;
acc = par.DC.a;
cost=res.C{1};
Torque_eng = res.Te;
Torque_max = max(par.ENG.Tmax);


%% GEARSHIFTS

 shift_down=zeros(size(vel));
 cost_shiftdown = zeros(size(cost));
 %Sorting to find velocity at each gear up-shift
 vel_21=shift_down;
 vel_32=shift_down;
 vel_43=shift_down;
 vel_54=shift_down;
 vel_65=shift_down;
 vel_76=shift_down;
 
 
 %Sorting to find throttle at gear up-shift
 th_21=shift_down;
 th_32=shift_down;
 th_43=shift_down;
 th_54=shift_down;
 th_65=shift_down;
 th_76=shift_down;
 
 %Sorting to find acceleration at each gear up-shift
 acc_21=shift_down;
 acc_32=shift_down;
 acc_43=shift_down;
 acc_54=shift_down;
 acc_65=shift_down;
 acc_76=shift_down;
costdiff=zeros(numel(par.GB.rg),length(vel));
 
 %Finding and storing gearshift timepoints
for i=1:length(gear)-1
    if gear(i+1)==1 && gear(i)==2
        shift_down(i) = 21;
        vel_21(i) = vel(i);
        th_21(i) = Torque_eng(i)/Torque_max;
        acc_21(i) = acc(i);
        cost_shiftdown(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    elseif gear(i+1)==2 && gear(i)==3
        shift_down(i) = 32;
        vel_32(i) = vel(i);
        th_32(i) = throttle(i);
        acc_32(i) = acc(i);
        cost_shiftdown(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    elseif gear(i+1)==3 && gear(i)==4
        shift_down(i) = 43;
        vel_43(i) = vel(i);
        th_43(i) = throttle(i);
        acc_43(i) = acc(i);
        cost_shiftdown(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    elseif gear(i+1)==4 && gear(i)==5
        shift_down(i) = 54;
        vel_54(i) = vel(i);
        th_54(i) = throttle(i);
        acc_54(i) = acc(i);
        cost_shiftdown(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    elseif gear(i+1)==5 && gear(i)==6
        shift_down(i) = 65;
        vel_65(i) = vel(i);
        th_65(i) = throttle(i);
        acc_65(i) = acc(i);
        cost_shiftdown(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i});
    elseif gear (i+1)==6 && gear(i)==7
        shift_down(i) = 76;
        vel_76(i) = vel(i);
        th_76(i) = throttle(i);
        acc_76(i) = acc(i);
        cost_shiftdown(i) = cost(i);
%         costdiff(:,i) = (dyn.Jo{i}(1));
    end
    
end



%Number of DownShifts
Num_DownShift = numel(shift_down(shift_down > 0));
fprintf('Number of Down-shifts = %i \n',Num_DownShift);



% %% Assigning zero values as NaN
%  shift_down(shift_down==0)=NaN;
%  cost_shiftdown(cost_shiftdown==0) = NaN;
% %  costdiff(costdiff==0) = NaN;
%  
%  vel_21(vel_21==0)=NaN;
%  vel_32(vel_32==0)=NaN;
%  vel_43(vel_43==0)=NaN;
%  vel_54(vel_54==0)=NaN;
%  vel_65(vel_65==0)=NaN;
%  vel_76(vel_76==0)=NaN;
%  
%  th_21(th_21==0)=NaN;
%  th_32(th_32==0)=NaN;
%  th_43(th_43==0)=NaN;
%  th_54(th_54==0)=NaN;
%  th_65(th_65==0)=NaN;
%  th_76(th_76==0)=NaN;
%  
%  acc_21(acc_21==0)=NaN;
%  acc_32(acc_32==0)=NaN;
%  acc_43(acc_43==0)=NaN;
%  acc_54(acc_54==0)=NaN;
%  acc_65(acc_65==0)=NaN;
%  acc_76(acc_76==0)=NaN;
% 
% 
% %% PLOT SHIFT POINTS in ONE MAP
% 
% figure;
% hold on
% grid on
%
% title('Gear Downshift Points')
% xlabel('Velocity [km/h]');
% ylabel('Throttle');
% zlabel('Instantaneous Cost');
% axis([0 150 0 1]);
% legend('show');

% 
% 
% plot3(vel_21,th_21,cost_shiftdown,'co')
%
% plot3(vel_32,th_32,cost_shiftdown,'bo')
% 
% plot3(vel_43,th_43,cost_shiftdown,'ko')
% 
% plot3(vel_54,th_54,cost_shiftdown,'ro')
%
% plot3(vel_65,th_65,cost_shiftdown,'go')
% 
% plot3(vel_76,th_76,cost_shiftdown,'mo')
% 
% legend('2^{nd} gear to 1^{st}','3^{rd} gear to 2^{nd}',...
%         '4^{th} gear to 3^{rd}','5^{th} gear to 4^{th}',...
%         '6^{th} gear to 5^{th}','7^{th} gear to 6^{th}')
% 
% 
% %% PLOT VEHICLE VELOCITY LIMITS at EACH GEAR
% 
% hold on
% 
% % plot([(par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(1))*3.6*par.VEH.re],[0,1],'c--');
% % plot([(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(1))*3.6*par.VEH.re],[0,1],'c-');
% 
% 
% plot([(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'c--');
% plot([(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'c-');
% 
% 
% plot([(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'b--');
% plot([(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'b-');
% 
% 
% plot([(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re],[0,1],'k--');
% %plot([(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(4))*3.6*par.VEH.re],[0,1],'c-');
% 
% 
% plot([(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re],[0,1],'r--');
% % plot([(max(par.ENG.we_max)/par.GB.rg(5))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(5))*3.6*par.VEH.re],[0,1],'g-');
% 
% 
% plot([(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re],[0,1],'g--');
% % plot([(max(par.ENG.we_max)/par.GB.rg(6))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(6))*3.6*par.VEH.re],[0,1],'m-');
% 
% 
% plot([(par.ENG.w_idle/par.GB.rg(7))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(7))*3.6*par.VEH.re],[0,1],'m--');
% % plot([(max(par.ENG.we_max)/par.GB.rg(7))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(7))*3.6*par.VEH.re],[0,1],'b-');
% 
% 
% %% PLOT INDIVIDUAL GEAR SHIFT POINTS
% 
% 
% %Downshift 2-1
% figure;
% hold on
% grid minor
% 
% plot3(vel_21,th_21,cost_shiftdown,'co')
% xlabel('Velocity');
% ylabel('Throttle');
% zlabel('Instantaneous Cost');
% axis([0 150 0 1]);
% 
% plot([(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'c--');
% plot([(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(2))*3.6*par.VEH.re],[0,1],'c-');
% 
% 
% %Downshift 3-2
% figure;
% hold on
% grid minor
% 
% plot3(vel_32,th_32,cost_shiftdown,'bo')
% xlabel('Velocity');
% ylabel('Throttle');
% zlabel('Instantaneous Cost');
% axis([0 150 0 1]);
% 
% plot([(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'b--');
% plot([(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re,(max(par.ENG.we_max)/par.GB.rg(3))*3.6*par.VEH.re],[0,1],'b-');
% 
% 
% %Downshift 4-3
% figure;
% hold on
% grid minor
% 
% plot3(vel_43,th_43,cost_shiftdown,'ko')
% xlabel('Velocity');
% ylabel('Throttle');
% zlabel('Instantaneous Cost');
% axis([0 150 0 1]);
% 
% plot([(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(4))*3.6*par.VEH.re],[0,1],'k--');
% 
% 
% %Downshift 5-4
% figure;
% hold on
% grid minor
% 
% plot3(vel_54,th_54,cost_shiftdown,'ro')
% xlabel('Velocity');
% ylabel('Throttle');
% zlabel('Instantaneous Cost');
% axis([0 150 0 1]);
% 
% plot([(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(5))*3.6*par.VEH.re],[0,1],'r--');
% 
% %Downshift 6-5
% figure;
% hold on
% grid minor
% 
% plot3(vel_65,th_65,cost_shiftdown,'go')
% xlabel('Velocity');
% ylabel('Throttle');
% zlabel('Instantaneous Cost');
% axis([0 150 0 1]);
% plot([(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(6))*3.6*par.VEH.re],[0,1],'g--');
% 
% %Downshift 7-6
% figure;
% hold on
% grid minor
% 
% plot3(vel_76,th_76,cost_shiftdown,'mo')
% xlabel('Velocity');
% ylabel('Throttle');
% zlabel('Instantaneous Cost');
% axis([0 150 0 1]);
% 
% plot([(par.ENG.w_idle/par.GB.rg(7))*3.6*par.VEH.re,(par.ENG.w_idle/par.GB.rg(7))*3.6*par.VEH.re],[0,1],'m--');
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        