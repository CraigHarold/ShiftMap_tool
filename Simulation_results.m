%Check for optimized map or else set to default
if Drivability_mode > 0
    upshift_map = data.TCU.upshift.veh_spd_optimized;
    downshift_map = data.TCU.downshift.veh_spd_optimized;
else
    upshift_map = data.TCU.upshift.veh_spd_default;
    downshift_map = data.TCU.upshift.veh_spd_default;
end

data.VEH.Mv = par.VEH.Mv;

%Assign the drive cycle data compatible with FFM
if strcmp('NEDC',cycles) == 1
    timesteps = 1220;
    data.SIM.drivecycle = 1;
elseif strcmp('FTP',cycles) == 1
    timesteps = 1877;
    data.SIM.drivecycle = 2;
elseif strcmp('10_15',cycles) == 1
    timesteps = 660;
    data.SIM.drivecycle = 3;
elseif strcmp('Combined_five',cycles) == 1
    timesteps = 11529;
    data.SIM.drivecycle = 4;
elseif strcmp('Combined_sevenstd',cycles) == 1
    timesteps = 11417;
    data.SIM.drivecycle = 5;
elseif strcmp('Combined_twelvestd',cycles) == 1
    timesteps = 18826;
    data.SIM.drivecycle = 6;
else
    timesteps = 1190;
    data.SIM.drivecycle = 7;
end
sim('FFM_Punch')


%TORQUE and ENGINE speed

T_res_check = zeros(size(T_eng_check));
for i = 1:(numel(T_eng_check))
    T_res_check(i) = (T_max_check(i) - T_eng_check(i));
end

T_res_cum = sum(T_res_check);

T_res_avg = T_res_cum/(numel(T_eng_check));

W_eng_avg = mean(w_eng_check);


fprintf('\nFuel Consumption in simulation= %.3f [litre/100km] \n \n', Fuel_consumption_100km(end))
fprintf('Average Torque Reserve at up-shift = %.2f [Nm] \n' ,T_res_avg)
fprintf('Average Engine Speed at up-shift= %.2f [rpm] \n', W_eng_avg)


%GEARSHIFT check
y=0;
z=0;
for i = 1:numel(gearshift_check)-1
    if gearshift_check(i+1)- gearshift_check(i) == 1
        y=y+1;
    elseif gearshift_check(i)- gearshift_check(i+1) == 1
            z=z+1;
    end
end
fprintf('Number of Upshifts in simulation = %i \n',y)
fprintf('Number of Downshifts in simulation = %i \n',z);