function [ DC ] = Init_drivecycle_dpm( drive_cycle_string )
%Initpar creates a parameter struct which can be used with the dpm function.
% 
%
%
%% Driving cycle
DC.cycle= drive_cycle_string;                                               % Driving cycle string
DC.s    = load(drive_cycle_string);

if  strcmp('DriveCycle_combined',drive_cycle_string)

DC.a    = DC.s.Dc.D_z';                                                    % Acceleration [m/s^2]
DC.v    = DC.s.Dc.V_z';                                                    % Speed [m/s]
DC.T    = DC.s.Dc.T_z';                                                    % Timevector [s]
DC.Ts   = mean(diff(DC.T));                                                % Sample time [s]


elseif  strcmp('DriveCycle_combined2',drive_cycle_string)

DC.a    = DC.s.Dc.D_z';                                                    % Acceleration [m/s^2]
DC.v    = DC.s.Dc.V_z';                                                    % Speed [m/s]
DC.T    = DC.s.Dc.T_z';                                                    % Timevector [s]
DC.Ts   = mean(diff(DC.T));                                                % Sample time [s]

elseif  strcmp('DriveCycle_standardcombined',drive_cycle_string)

DC.a    = DC.s.Dc.D_z';                                                    % Acceleration [m/s^2]
DC.v    = DC.s.Dc.V_z';                                                    % Speed [m/s]
DC.T    = DC.s.Dc.T_z';                                                    % Timevector [s]
DC.Ts   = mean(diff(DC.T));                                                % Sample time [s]

else
    
DC.a    = DC.s.D_z';                                                       % Acceleration [m/s^2]
DC.v    = DC.s.V_z';                                                       % Speed [m/s]
DC.T    = DC.s.T_z';                                                       % Timevector [s]
DC.Ts   = mean(diff(DC.T)); 
end

