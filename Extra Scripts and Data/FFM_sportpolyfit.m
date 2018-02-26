% close all; clc;

throttle_points = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.6,0.7,0.8,0.9,0.95];


data.TCU.upshift.veh_spd=...
[23.6,24.6,25.6,26.55,27.5,28.48,29.43,30.38,31.33,32.29,33.24,35.15,37.11,39,39.8,39.8;
35.62,37,38.43,39.73,41.15,42.47,43.78,45.19,46.59,47.19,49.31,52.04,54.73,55.11,55.11,55.11;
49.4,52.2,55.19,58.08,61.1,64,67.02,69.78,72.7,75.6,78.5,82.54,82.54,82.54,82.54,82.54;
73,76.25,79.7,83.05,86.42,89.76,93.06,96.42,99.76,103.3,106.5,113.3,120,123.1,123.1,123.1;
[73,76.25,79.7,83.05,86.42,89.76,93.06,96.42,99.76,103.3,106.5,113.3,120,123.1,123.1,123.1]+50;
[73,76.25,79.7,83.05,86.42,89.76,93.06,96.42,99.76,103.3,106.5,113.3,120,123.1,123.1,123.1]+120;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500]';



data.TCU.downshift.veh_spd = ...
   [linspace(16,26.51,16)-8;
    linspace(20,36.93,16)-8;
    linspace(35,55.19,16)-3;
    linspace(55,82.11,16)-2;
linspace(55,82.11,16)+35;
linspace(55,82.11,16)+90;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500]';



figure
hold on
grid minor

plot(data.TCU.upshift.veh_spd(:,1),throttle_points,'c-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,2),throttle_points,'b-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,3),throttle_points,'k-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,4),throttle_points,'r-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,5),throttle_points,'g-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,6),throttle_points,'m-','Linewidth',2)

plot(data.TCU.downshift.veh_spd(:,1),throttle_points,'c--')
plot(data.TCU.downshift.veh_spd(:,2),throttle_points,'b--')
plot(data.TCU.downshift.veh_spd(:,3),throttle_points,'k--')
plot(data.TCU.downshift.veh_spd(:,4),throttle_points,'r--')
plot(data.TCU.downshift.veh_spd(:,5),throttle_points,'g--')
plot(data.TCU.downshift.veh_spd(:,6),throttle_points,'m--')

title('Gear ShiftMap Sport-Mode');
xlabel('Velocity [km/h]');
ylabel('Throttle')
axis([0 150 0 1])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%