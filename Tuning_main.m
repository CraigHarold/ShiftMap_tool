clear all;clc; close all;

%% Drive Cycle

cycles = {'Combined_sevenstd'};


%Choose a drive cycle from the options below:
    % 'NEDC'                    %-- European: Urban and Extra urban
    % 'FTP'                     %-- USA: Highway
    % '10_15'                   %-- Japanese: Extra Urban
    % 'Combined_five'           %-- Urban 
    % 'Combined_sevenstd'       %-- Extra Urban and Urban
    % 'Combined_twelvestd'      %-- Extra Urban, Urban and Aggressive
    
    %!!! For the Extra urban and aggressive drive cycles, higher vehicle mass would result
    %    in infeaible torque and power operating points !!!

%% Tuning Parameters


% Vehicle Mass
    
    Mass = 1300;
    
    
% Drivability for various driving modes

% 1- Fuel economy
% 2- Max.Torque reserve
% 3- Normal (Torque reserve vs Fuel economy)
% 4- Constant Torque reserve 
    
    Drivability_mode = 3;
    Switching_losses = 0;      % Shifting losses [percentage of fuel consumed]
    
    %For mode 3, set balance ratio relative to 1, with 1 being maximum fuel economy
    
    FCvsTR_ratio = 0.5;
    
    
    %For mode 4, set required constant torque reserve value
    
    constant_Torque_reserve  = 10;  %[percentage of torque reserve]
                                   
    % If constant torque reserve is too low, the drive will be infeasible
    % Restricted by engine acceleration capabilities
    
 
 %Up-shift line if upshifts are unavailable (distance from the previous upshift line [km/h])
    
    Distance_to_upshift = 30;
    
 %Down-shift line (difference b/w upshift & downshift line[km/h])
 
    Distance_between_shiftlines = 6;                   
 
 %Run simulation in FFM, with optimized shiftmap
 
    Simulation_required = 0;    %0 for No, 1 for Yes
    
 
 %________________________________________________________________________% 
 
 
%%Assigning tuned parameters to model function (ModelFuntion_convpwt)
 par.VEH.Mv = abs(Mass);
 par.Tuning.mode = Drivability_mode;
 par.Tuning.switching_loss = Switching_losses;
 par.Tuning.gamma = FCvsTR_ratio;
 par.Tuning.const_Tres = constant_Torque_reserve;
 dist = abs(Distance_between_shiftlines);
 dist_up = abs(Distance_to_upshift);
 Simulation_required = floor(min(1,max(0,Simulation_required)));
 
  
  
     DPM_main
     Shiftmap_upshift
     Kmeans_clustering
     close(4:20)
     
 %Polyfit               % Default, is linear fit
    Polyfit = 0;        % 0 for polyfit, 1 for linear plotting !!No data recorded for FFM.
    DoP = 3;            % If you choose to polyfit, also choose the degree of polynomial upto 3
    	if Polyfit == 1
            Polyfit_kmeanscentroid
        else
            Fit_centroid
     end
     
%Run simulation on forward facing model
     if Simulation_required == 1
        Simulation_results
     end
        
     
     

%Clear variables     
 clear t_max Te_max Te_vector R X x1 x2 i y z timesteps vel_i th_i i R QW QWZ qq...
       shift_up p12_1 minx12 miny12 min_vel max_vel ii I gn engspeed_pt eng_speed...
       sumdist th th_i th_m th_f vel_i vel_m vel_f veh_vel_pt vel_dwnpts vel_pts...
       velocity_pts X_i Y_i X_m Y_m X_f Y_f;