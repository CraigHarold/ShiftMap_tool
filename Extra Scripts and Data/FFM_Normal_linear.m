close all;
throttle_points = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.6,0.7,0.8,0.9,0.95];


data.TCU.upshift.veh_spd=...
[5.6,6.5,7.2,8.1,9,9.85,10.7,11.35,12.1,14,17.1,21,24.5,28,31.5,33.25;
8,10,11.5,13,14.5,16,17.5,19.5,22,24,26,34,50,55.1083,55.1083,55.1083;
12,15.5,18.5,20.5,23.5,27.5,30,33.5,37,39,40,48,61.5,70,81,82.5;
23,27.5,30,33.5,37,40.5,44,47.5,51,54.5,62,68,72,80,86,88;
34,36,38,40,42,48,54,60,66,72,82,94,108,120,132,140;
[34,36,38,40,42,48,54,60,66,72,82,94,108,120,132,140] + 50;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500]';



data.TCU.downshift.veh_spd = ...
[ max(5.312,min(26,[5.6,6.5,7.2,8.1,9,9.85,10.7,11.35,12.1,14,17.1,21,24.5,28,31.5,33.25]-dist));
max(7.34,min(38,[8,10,11.5,13,14.5,16,17.5,19.5,22,24,26,34,50,55.1083,55.1083,55.1083]-dist));
max(11,min(55,[12,15.5,18.5,20.5,23.5,27.5,30,33.5,37,39,40,48,61.5,70,81,82.5]-dist));
max(16.412,min(80,[23,27.5,30,33.5,37,40.5,44,47.5,51,54.5,62,68,72,80,86,88]-dist));
max(22.7,min(110,[34,36,38,40,42,48,54,60,66,72,82,94,108,120,132,140]-dist));
max(31.54,min(160, [34,36,38,40,42,48,54,60,66,72,82,94,108,120,132,140] + 50-dist));
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

title('Gear ShiftMap Normal');
xlabel('Velocity [km/h]');
ylabel('Throttle')
axis([0 150 0 1])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%