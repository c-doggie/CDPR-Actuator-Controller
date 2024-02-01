clc;
% Initial Conditions
theta0 = 0;   % Initial angle
theta_dot0 = 0;  % Initial angular velocity
x0 = [theta0; theta_dot0];

% Simulation Parameters
T = 0.2;         
dt = 0.001;

% Controller Params
tau_values = [1 2 3 4];
%load_values = -5;

%square config
sq_amplitude = 200;
sq_period = 2*pi*10;
square_t = 0:dt:T;
square_x = square_wave(square_t, sq_amplitude, sq_period);

% Prepare the figure
figure;
colors = ['b', 'r', 'g', 'm'];

% Plot the square wave before the loop
subplot(2, 1, 1);
plot(square_t, square_wave(square_t,0.5,sq_period), '.-','HandleVisibility','off'); % Plot the square wave
%hold on;

% Using MATLAB ode45's Runge-Kutta integration:
for i = 1:length(tau_values)
    
    [time, x] = ode45(@(t,x) Motor(t, x, square_wave(t,sq_amplitude,sq_period), tau_values(i)), [0 T], x0);

    % Plot original solution
    subplot(2, 1, 1);
    hold on;
    plot(time, x(:,1), colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Velocity [rad/s]');
    title(['Shaft Velocity Responses for Different Tau Values (Load = ' num2str(sq_amplitude) '*square(' num2str(sq_period) '*t) kg)']);
    
    % Compute and plot derivative
    subplot(2, 1, 2); % Two rows, one column, second plot
    hold on;
    plot(time, x(:,2), colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Acceleration [rad/s^2]');
    title('Shaft Acceleration');
end

% Add legends for the response curves only
subplot(2, 1, 1);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
subplot(2, 1, 2);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
sgtitle('$T+Fr = \ddot{\theta_1}(I_r+\frac{I_g}{N}) + k_t\dot{\theta}$','Interpreter','latex')

hold off;

% Square wave config
function square_out = square_wave(t, amplitude, period)
    square_out = amplitude*square(period*t);
end
