% get field along z axis for single-tunr coil

clc
clear
close all

%Define global variables
global u0

u0=4*pi*1e-7; %permeability of free space

%Define coil parameters

I0=1000; %Coil current in Amps
a=1.5302; %Coil radius in m

x_p=0; y_p=0; z_p=0; %Define coordinates of coil center point

%First we see how to calculate the magnetic field at a single point in
%space

%Input test point
x=0; y=0; z=0;

[Bx,By,Bz] = magnetic_field_current_loop(x,y,z,x_p,y_p,z_p,a,I0)

%Now showing how to calculate points along a straigh line

clear x y z

%Input vector of points

x=0; y=0; z=linspace(-6,6,12000); %These default coordinates calculates the magnetic field along the z axis through the center of the coil

[Bx,By,Bz] = magnetic_field_current_loop(x,y,z,x_p,y_p,z_p,a,I0);

figure
plot(z,Bz)
xlabel('z [m]')
ylabel('Bz [T]')
title('1D magnetic field tests')

% save output
Name = [ 'BField_singleTurn' sprintf('_a%0.1fm_I%0.1fA',a,I0)];
save( [ 'output/' Name '.mat' ] , 'Bz' , 'Bz' );

% output to .txt file
xfix(1:12000) = x(1,1);
yfix(1:12000) = y(1,1);

B_table_out = [ xfix' , yfix' , z' , 1000*Bx' , 1000*By' , 1000*Bz' ];

fileID = fopen( ['output/' Name '.txt'] ,'w');
fprintf(fileID,'%26s\n','x/F:y/F:z/F:Bx/F:By/F:Bz/F');
fprintf(fileID,'%6.4f %6.4f %6.4f %6.4f %6.4f %6.4f\n' ,B_table_out');
fclose(fileID);

%NOTE: This code can also be used to calculate the magnetic field due to
%distributed windings by simply treating each winding as a separate loop
%and calculate them individually, then add up the resulting field values.


