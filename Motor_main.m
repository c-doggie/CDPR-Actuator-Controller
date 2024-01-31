clc;
%Initial Conditions
theta0 = 0;   %Initial angle
theta_dot0 = 0;  %Initial angular velocity
x0 = [theta0; theta_dot0];

%Simulation Parameters
T = 0.2;         %Simulation time
dt = 0.001;
%Square wave config
square_t = 0:dt:T;
square_x = square(square_t);

%Controller Params
tau_values = [1 2 3 4];
load_values = -5;

% Prepare the figure
figure;
hold on;
grid on;
colors = ['b', 'r', 'g', 'w']; % Define a set of colors

%Using MATLAB ode45's Runge-Kutta integration:
for i = 1:length(tau_values)
    tau = tau_values(i);
    [time, x] = ode45(@(t,x) Motor(t, x, load_values, tau), [0 T], x0);
    x = x./(2*pi*60); %convert rad to rps
    
    % Plot original solution
    subplot(3, 1, 1); % Two rows, one column, first plot
    hold on;
    plot(time, x(:,1), colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft angle \theta [rotations]');
    title(['Shaft Angle Responses for Different Tau Values (Load = ' num2str(load_values) 'kg)']);
    
    % Compute and plot derivative
    dt = diff(time); % Differences in time
    dx = diff(x(:,1)); % Differences in solution
    derivative = dx ./ dt;
    disp(['derivative array size: ' num2str(size(derivative))]);
    time_derivative = time(1:end-1) + dt/2; % Time vector for derivative
    
    subplot(3, 1, 2); % Two rows, one column, second plot
    hold on;
    plot(time_derivative, derivative, colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Velocity [rpm]');
    title('Shaft Velocity');

    % Compute and plot acceleration
    dx2 = diff(dx(:,1));
    derivative2 = dx2 ./ dt(1:end-1);
    time_derivative2 = time(1:end-1) + dt/2;
    
    subplot(3, 1, 3); % Two rows, one column, second plot
    hold on;
    plot(time_derivative2(1:end-1), derivative2, colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Acceleration [rpm^2]');
    title('Shaft Acceleration');
    
end

% Add legends
subplot(3, 1, 1);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
subplot(3, 1, 2);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
subplot(3,1,3);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
sgtitle('$T+Fr = \ddot{\theta_1}(I_r+\frac{I_g}{N}) + k_t\dot{\theta}$','Interpreter','latex')

hold off;
