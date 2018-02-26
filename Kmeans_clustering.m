%%%%%%%%
idx = zeros(max(max(length(Velocity.vel_12(Velocity.vel_12>0)),length(Velocity.vel_23(Velocity.vel_23>0))),...
             (max(length(Velocity.vel_34(Velocity.vel_34>0)),length(Velocity.vel_45(Velocity.vel_45>0))))),6);         %Making matrix with max elements from one of the six upshifts 
         
C = cell(1,(numel(par.GB.rg)-1));                               %Six cells for each upshift

for i = 12:11:67                                                %Gear shifts from 1-2 to 6-7
R=0;
if i==12
    vel_i = Velocity.vel_12;
    th_i = Throttle.th_12;
    y = 1;                                                      %Assigning cell numbers      
elseif i==23
    vel_i = Velocity.vel_23;
    th_i = Throttle.th_23;
    y = 2;
elseif i==34
    vel_i = Velocity.vel_34;
    th_i = Throttle.th_34;
    y=3;
elseif i==45
    vel_i = Velocity.vel_45;
    th_i = Throttle.th_45;
    y = 4;
elseif i==56
    vel_i = Velocity.vel_56;
    th_i = Throttle.th_56;
    y = 5;
elseif i==67
    vel_i = Velocity.vel_67;
    th_i = Throttle.th_67;
    y = 6;
end   

x1=[vel_i(vel_i>0)]';
x2=[th_i(vel_i>0)]';
X=[x1,x2];

if numel(vel_i(vel_i>0)) > 0
figure
hold on
grid minor
axis([0 150 0 1]);
plot(vel_i(vel_i>0),th_i(vel_i>0),'ko');
xlabel('Velocity [km/h]')
ylabel('Throttle [-]')
if i==12
title('Shift points for 1^{st} to 2^{nd}')
elseif i==23
    title('Shift points for 2^{nd} to 3^{rd}')
elseif i==34
    title('Shift points for 3^{rd} to 4^{th}')
elseif i==45
    title('Shift points for 4^{th} to 5^{th}')
elseif i==56
    title('Shift points for 5^{th} to 6^{th}')
elseif i==67
    title('Shift points for 6^{th} to 7^{th}')

end
end



hold off

%Change number of centroids based on number of shift points

if numel(vel_i(vel_i>0))>0 && numel(vel_i(vel_i>0))<5
    NoC=1;
elseif numel(vel_i(vel_i>0))>=5 && numel(vel_i(vel_i>0))<20
    NoC=2;
elseif numel(vel_i(vel_i>0))>=20 && numel(vel_i(vel_i>0))<50
    NoC=3;
elseif numel(vel_i(vel_i>0))>=50 && numel(vel_i(vel_i>0))<100
    NoC=4;
elseif numel(vel_i(vel_i>0))>=100 && numel(vel_i(vel_i>0))<220
    NoC=5;
elseif numel(vel_i(vel_i>0))>=220
    NoC=6;
end

if numel(vel_i(vel_i>0)) > 0                                    %Omit empty cells
opts = statset('Display','final');
    while NoC > 0 
    [idsx,R,sumd]=kmeans(X,NoC,'Replicates',20);
    if sumd < 50
        NoC=NoC-1;
    else NoC=0;
    end
    end
        
%%
figure
grid minor
axis([0 150 0 1]);
hold on
plot(X(idsx==1,1),X(idsx==1,2),'r.','MarkerSize',17)
plot(X(idsx==2,1),X(idsx==2,2),'b.','MarkerSize',17)
plot(X(idsx==3,1),X(idsx==3,2),'g.','MarkerSize',17)
plot(X(idsx==4,1),X(idsx==4,2),'m.','MarkerSize',17)
plot(X(idsx==5,1),X(idsx==5,2),'y.','MarkerSize',17)
plot(X(idsx==6,1),X(idsx==6,2),'k.','MarkerSize',17)
plot(X(idsx==7,1),X(idsx==7,2),'r.','MarkerSize',17)

plot(R(:,1),R(:,2),'kx','LineWidth',2,'MarkerSize',9)


xlabel('Velocity [km/h]')
ylabel('Throttle [-]')
if i==12
title('Shift points for 1^{st} to 2^{nd}')
elseif i==23
    title('Shift points for 2^{nd} to 3^{rd}')
elseif i==34
    title('Shift points for 3^{rd} to 4^{th}')
elseif i==45
    title('Shift points for 4^{th} to 5^{th}')
elseif i==56
    title('Shift points for 5^{th} to 6^{th}')
elseif i==67
    title('Shift points for 6^{th} to 7^{th}')

end
else sumd = 0;
end

idx(1:length(idsx),y) = idsx;
C{y} = sortrows(R,1);                                                       % Ascending row wise
sumdist(y,:)= sum(sumd);
end


% (If there is a warning, kindly ignore as it is due to lack of data points...
%   in the upshift map, ~~5-6||6-7)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
