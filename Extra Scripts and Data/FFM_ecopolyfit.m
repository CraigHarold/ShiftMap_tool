% close all; clc;

data.TCU.upshift.veh_spd=...
[5.3,5.3,5.3,5.5,5.6,5.8,6,6.2,6.5,6.8,7.1,8,8.85,10,11.75,12.32;
7.3,7.3,7.4,7.4,7.45,7.52,7.75,8.1,8.6,9.2,10,12.5,15.5,19,23,28;
11.5,12,12,12.2,12.8,13.2,13.6,14.2,14.8,15.9,17.3,20,26,35,40,43;
16.4115,16.5,17,18,20,21,22,24,25,27.5,34,42,48,54,70,80;
22.7,23,25,27,29.5,31,32.5,34,36,39.5,42,48,60,75,88,95;
31.6,32,33,35,37.5,40,43,47,50,53.5,58,68,80,94,108,115;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500]';

 data.TCU.downshift.veh_spd=...
[ max(5.312,min(26,[5.3,5.3,5.3,5.5,5.6,5.8,6,6.2,6.5,6.8,7.1,8,8.85,10,11.75,12.32]-dist));
max(7.34,min(38,[7.3,7.3,7.4,7.4,7.45,7.52,7.75,8.1,8.6,9.2,10,12.5,15.5,19,23,28]-dist));
max(11,min(55,[11.5,12,12,12.2,12.8,13.2,13.6,14.2,14.8,15.9,17.3,20,26,35,40,43]-dist));
max(16.412,min(80,[17,18,19,20,21,22,23,24,25,27.5,34,42,48,54,70,80]-dist));
max(22.7,min(110,[24,25,26,27,29.5,31,32.5,34,36,39.5,42,48,60,75,88,95]-dist));
max(31.54,min(160, [33,34,35,36,37.5,40,43,47,50,53.5,58,68,80,94,108,115] -dist));
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500]';

throttle_points = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.6,0.7,0.8,0.9,0.95];


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

title('Gear ShiftMap Eco-mode');
xlabel('Velocity [km/h]');
ylabel('Throttle')
axis([0 150 0 1])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%