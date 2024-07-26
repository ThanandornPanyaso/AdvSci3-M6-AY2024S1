% Number of walkers
N = 1000;

% Number of steps
n = 100;

% Initialize positions
positions = zeros(N, n+1);

% Perform random walk
for i = 2:n+1
    step = 2 * (rand(N, 1) > 0.5) - 1; % Step is either -1 or 1
    positions(:, i) = positions(:, i-1) + step;
end

% Calculate the mean final position
mean_final_position = mean(positions(:, end));

% Plot trajectories of walkers
figure;
subplot(1,2,1);
plot(0:n, positions', 'LineWidth', 1);
title(['N=', num2str(N), ', n=', num2str(n), ', <x>=', num2str(mean_final_position)]);
xlabel('Number of steps (n)');
ylabel('Position (x)');
grid on;

% Plot histogram of final positions
subplot(1,2,2);
histogram(positions(:, end), 'Normalization', 'count');
title([num2str(n), ' steps of random walk']);
xlabel('Position');
ylabel('Number of particles');
grid on;
