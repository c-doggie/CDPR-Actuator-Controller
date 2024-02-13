%------------------- Motor Model Parameters -----------------

r = 10/100; %radius of shaft load (m)
I_r = 10*10^-3; %inertia of rotor (kg m)
I_g = 7.44*10^-3; %inertia of gearbox (kg m)
k_t = 0.67; %torque constant 
N = 6; %gear ratio of motor

%Friction Model
critical_velocity_friction_coefficient = 0.1; 
critical_velocity = 0;

%------------------- Simulation Parameters -----------------

% Initial Conditions
theta0 = 0;   % Initial angle
theta_dot0 = 0;  % Initial angular velocity
x0 = [theta0; theta_dot0];

% Simulation Parameters
T = 20;         
dt = 0.001;

% Controller Params
tau_values = [-4 -2 0 2 4];
%load_values = -5;

%square config
sq_amplitude = -200;
sq_period = 2*pi*0.5;
square_t = 0:dt:T;
