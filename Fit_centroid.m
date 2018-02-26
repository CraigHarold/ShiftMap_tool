clear velocity_points velocity_pts vel_pts vel_dwnpts

%Define shiftmap properties

figure;
grid minor
axis([0 150 0 1])
xlabel('Velocity [km/h]')
ylabel('Throttle [-]')
if Drivability_mode==1
title('Gearshift Map for Eco-mode')
elseif Drivability_mode==2
title('Gearshift Map for Sport-mode')
elseif Drivability_mode==4
title('Gearshift Map for Constant Torque mode')
else
    title('Gearshift Map for Normal-mode')
end
    
hold on
%||||||%    


throttle_points = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,...
                    0.45,0.5,0.6,0.7,0.8,0.9,0.95];            %Suited for FFM model

for i=2
    
if (C{1,i})>0                                                   %To avoide empty cells
    
y=1;                                                            %reset the dimension for the loop

%1st to 2nd point
  
minx = min(((par.ENG.w_idle/par.GB.rg(i))*3.6*par.VEH.re),(C{i}(1,1)));
miny = 0;                                                     %Upshift from 0 throttle

Y_i = [miny;C{i}(1,2)];                                         
X_i = [minx;C{i}(1,1)];

                                                     

if minx == C{i}(1,1)
    vel_i = minx;
     N_i = numel(throttle_points(throttle_points < C{i}(1,2))); 
         for l = 1:N_i
             velocity_points{i}(l) = minx;
         end
else
    p_i = polyfit(X_i,Y_i,1);                                           %Find co-efficients for polyift
    vel_i = linspace(minx,C{i}(y,1),1000);                          %Velocity range
    th_i = p_i(1)*(vel_i) + p_i(2);
    
    N_i = numel(throttle_points(throttle_points < C{i}(1,2)));
    for l=1:N_i
        velocity_points{i}(l) = (throttle_points(l) - p_i(2))/p_i(1);
    end
end
N_m(y)=N_i;


%% Middle points
if numel(C{i}(:,1)) > 2         % condition for intermediate fitting of points
for y = 2 : numel(C{i}(:,1)) - 1
    
N_m(y) = 0;

   
X_m = [C{i}(y-1,1);C{i}(y,1)];
 
Y_m = [max(C{i}(1:y-1,2));max(C{i}(1:(y),2))];

 
p_m = polyfit(X_m,Y_m,1);                                                                   %Find co-efficients for polyift

vel_m = linspace(C{i}(y-1,1),C{i}(y,1),1000);                                              %Velocity range

th_m = p_m(1)*(vel_m) + p_m(2);

    N_m(y) = numel(throttle_points(throttle_points < C{i}(y,2)));
    
    if N_m(y) ~= N_m(y-1) 
            for l=N_m(y-1)+1:N_m(y)
            velocity_points{i}(l) = (throttle_points(l) - p_m(2))/p_m(1);
            end
    end

end
end

%% Final point
y_f = numel(C{i}(:,1));

if y_f == 1                  %For a single point
    for l=N_i+1:numel(throttle_points)
        if minx == C{i}(1,1)
            velocity_points{i}(l) = minx;
        else
            velocity_points{i}(l) = (throttle_points(l) - p_i(2))/p_i(1);
        end
    end
    
    
else             %For multiple points
        
X_f = [C{i}(y_f-1,1) , C{i}(y_f,1)];
Y_f = [max(C{i}(1:y_f-1,2)),max(C{i}(1:(y_f),2))];

p_f = polyfit(X_f,Y_f,1);

vel_f = linspace(C{i}(y_f-1,1),(max(par.ENG.we_max)/par.GB.rg(i))*3.6*par.VEH.re,1000);

th_f = p_f(1)*(vel_f) + p_f(2);


    for l=N_m(y)+1:numel(throttle_points)
        velocity_points{i}(l) = [(throttle_points(l) - p_f(2))/p_f(1)];
    end

end


%%SORTING Values

for ii = 1:numel(throttle_points)-1

     velocity_points{i}(1,ii+1) = [(velocity_points{i}(1,ii)) > (velocity_points{i}(1,ii+1))].* (velocity_points{i}(1,ii)) + [(velocity_points{i}(1,ii)) <= (velocity_points{i}(1,ii+1))].*(velocity_points{i}(1,ii+1));
   
end
 
end

end




%%Plotting within limits
vel_pts = cell2mat(velocity_points);
velocity_pts = zeros(numel(throttle_points),numel(C));

for qq=1:numel(C)               %Assorting them into arrays respective to gear numbers
    
   if C{1}(:,1) == 0            %Omit emptyh cells
        fprintf('\n No shiftpoints available\n')
   elseif C{qq}(:,1) > 0 
        velocity_pts(:,qq) = vel_pts((qq-1)*numel(throttle_points)+1:(qq*numel(throttle_points)));
   else 
        velocity_pts(:,qq) = velocity_pts(:,qq-1) + dist_up;
   end

end


    %Checking maximum velocity
    
for gn = 1:numel(C)                 
min_vel=(par.ENG.w_idle/par.GB.rg(gn))*3.6*par.VEH.re;              %minimum vehicle velocity at respective gear
max_vel=(max(par.ENG.we_max)/par.GB.rg(gn))*3.6*par.VEH.re;         %maximum vehicle velocity at respective gear

    for th = 1 : numel(throttle_points)
    velocity_pts(th,gn) = max(min_vel,min(max_vel,velocity_pts(th,gn)));
    end

end


    %Checking cross-overs

for th = 1 : numel(throttle_points)     
        
    for gn = 1:numel(C)-1               %Gear numbers
        
        if(velocity_pts(th,gn) > velocity_pts(th,gn+1))
            velocity_pts(th,gn+1) = velocity_pts(th,gn);
        end
    end
end
        

%%Downshift lines

engspeed_pt = max(par.ENG.we_max(par.ENG.Tmax==max(par.ENG.Tmax)));        %Engine speed at peak engine torque
vel_dwnpts = velocity_pts - dist;

 %Checking for minimum velocity%
for gn = 1:numel(C)        
min_vel = (par.ENG.w_idle/par.GB.rg(gn))*3.6*par.VEH.re;
veh_vel_pt = (engspeed_pt/par.GB.rg(gn))*3.6*par.VEH.re;                 %Vehicle velocity at peak engine torque for respective gear              

    for th = 1 : numel(throttle_points)
    vel_dwnpts(th,gn) = min(veh_vel_pt,max(min_vel,vel_dwnpts(th,gn)));
    end

end



plot(velocity_pts(:,1),throttle_points,'c-','Linewidth',2)
plot(velocity_pts(:,2),throttle_points,'k-','Linewidth',2)
plot(velocity_pts(:,3),throttle_points,'b-','Linewidth',2)
plot(velocity_pts(:,4),throttle_points,'r-','Linewidth',2)
plot(velocity_pts(:,5),throttle_points,'g-','Linewidth',2)
plot(velocity_pts(:,6),throttle_points,'m-','Linewidth',2)

plot(vel_dwnpts(:,1),throttle_points,'c--')
plot(vel_dwnpts(:,2),throttle_points,'k--')
plot(vel_dwnpts(:,3),throttle_points,'b--')
plot(vel_dwnpts(:,4),throttle_points,'r--')
plot(vel_dwnpts(:,5),throttle_points,'g--')
plot(vel_dwnpts(:,6),throttle_points,'m--')


%SHIFT MAP for FFM

%7th and 8th
extra_pts = 500.*ones((numel(throttle_points)),2);

data.TCU.upshift.veh_spd_optimized(:,1:numel(C)) = velocity_pts(:,1:6);
data.TCU.upshift.veh_spd_optimized(:,(numel(C)+1):8) = extra_pts;

data.TCU.downshift.veh_spd_optimized(:,1:numel(C)) = vel_dwnpts(:,1:6);
data.TCU.downshift.veh_spd_optimized(:,(numel(C)+1):8) = extra_pts;


%_________________________________________________________________________________%
