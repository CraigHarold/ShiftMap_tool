figure
axis([0 150 0 1])
hold on
grid minor
xlabel('Velocity [km/h]')
ylabel('Throttle')
title('Balanced Shiftmap linearfit')



%% 
% close all; clc;
throttle_points = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.6,0.7,0.8,0.9,0.95];

data.TCU.upshift.veh_spd=...
[8,8.5,9,9.5,10,10.5,11,11.5,12.5,13.5,17,21,24.5,27.5,31.5,33;
12,12.5,13.5,14,15,15.5,16,17.5,21.5,23,26,34.5,39.5,42.5,45,46;
25,26,27.5,28.5,30,31,32.25,33.25,36,38.5,41,48,54,60,66,68.5;
40,41,42,43,44.5,45.5,46.5,48.5,51,52.5,56.5,65.5,74,84.5,96,104.5;
68,68.5,69.25,70,70.75,71.5,72,72.75,75,82,90,103.5,113.5,125,136.5,142.5;
100,105,110,115,120,125,130,135,140,145,150,160,170,180,190,195;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500]';



figure
hold on
grid minor

plot(data.TCU.upshift.veh_spd(:,1),throttle_points,'c-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,2),throttle_points,'k-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,3),throttle_points,'b-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,4),throttle_points,'r-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,5),throttle_points,'g-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,6),throttle_points,'m-','Linewidth',2)


title('Gear ShiftMap Balanced');
xlabel('Velocity [km/h]');
ylabel('Throttle')
axis([0 150 0 1])

data.TCU.downshift.veh_spd =  ...
[1,7.7,16.25,28.600,43.400,50.800,500,500;
1,7.7,16.25,28.600,43.400,51.800,500,500;
1,8,16.25,28.600,43.400,51.800,500,500;
1,8,16.25,28.600,43.400,54.900,500,500;
2,10,16.25,28.600,43.400,59.100,500,500;
2,10,18.25,28.600,45.500,63.200,500,500;
2,10,18.25,32.600,47.600,66.300,500,500;
2,10,23.500,32.600,47.600,68.400,500,500;
4,11,23.500,33.700,48.600,70.500,500,500;
6,11,23.500,35.700,48.600,70.500,500,500;
7.1000,12,27.500,35.700,49.600,72.600,500,500;
8,12,30.600,41.800,50.700,74.600,500,500;
11.200,16,37.700,46.900,65.100,89.100,500,500;
13.200,20,37.700,54.100,88.900,104,500,500;
15,24,37.7000,70,105.50,115,500,500;
15,30,40,70,105.5,120,500,500];

plot(data.TCU.downshift.veh_spd(:,1),throttle_points,'c--')
plot(data.TCU.downshift.veh_spd(:,2),throttle_points,'k--')
plot(data.TCU.downshift.veh_spd(:,3),throttle_points,'b--')
plot(data.TCU.downshift.veh_spd(:,4),throttle_points,'r--')
plot(data.TCU.downshift.veh_spd(:,5),throttle_points,'g--')
plot(data.TCU.downshift.veh_spd(:,6),throttle_points,'m--')
