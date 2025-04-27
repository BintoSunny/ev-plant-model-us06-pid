%% To simulate a basic plant model for an EV based on US06 drive cycle.
% Certain values for the parameters are not actual it's based on the reference values.
% Processing the datas
clear all
clc
data=readtable('US06_drive_cycle.xlsx'); % Reading US06 excel file.
time_s=data.Time;
t_new=0:0.01:time_s(end); % creating a vector from 1 to length of time with an increment of 0.01
speed_mph=data.Speed_mph; % Reading US06 speed
% Perform linear interpolation
speed_new = interp1(time_s, speed_mph, t_new, 'linear');
speed_new_kmph=speed_new*1.6089;
drive_cycle_data=timeseries(speed_new, t_new);
assignin('base', 'drive_cycle', drive_cycle_data); %Creating timeseries object
%% Assiging parameter values
M=2000; % Mass in Kg
initial_speed=0;
FDR=10;  %Final drive ratio
D=0.7; %Wheel diameter
r=0.35; %Wheel radius
Mr=0.015;  % coefficient_of_rolling_resistance,value for car.
p=1.225;   % density of air. Unit kg/m3
Cd=0.3;   % drag coefficient (Cd) dimensionless (no units).
A=2.0;     % cross sectional area m²
g=9.81;     % acceleration due to gravity
max_torque=400; %Unit is Nm
power_kW =100; %Unit is KW
power_W = power_kW * 1000; %Converting power to W
max_rpm=12000;  %Unit is rpm
speed_rad_s=(2*pi/60); %Convert rpm to rad/s
omega=2*pi;
radiant_angle = 0;% Angle of road inclination
break_force=5000;
%% Simulating the midel
sim_time=length(time_s);
sim('plant_model_us06_ev_V06')
