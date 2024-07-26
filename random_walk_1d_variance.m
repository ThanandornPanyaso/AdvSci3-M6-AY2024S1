% Function to perform random walk and return the mean squared displacement of the final step
function [mean_squared_displacement, final_mean_squared_displacement] = random_walk_simulation(N, n)
    % Initialize positions
    positions = zeros(N, n+1);

    % Perform random walk
    for i = 2:n+1
        step = 2 * (rand(N, 1) > 0.5) - 1; % Step is either -1 or 1
        positions(:, i) = positions(:, i-1) + step; % Update positions
    end

    % Calculate squared displacement
    squared_displacement = positions.^2;

    % Calculate mean squared displacement
    mean_squared_displacement = mean(squared_displacement, 1);

    % Calculate mean squared displacement at the final step
    final_mean_squared_displacement = mean(squared_displacement(:, end));
end

% Define the cases
cases = {
    struct('N', 100, 'n', 1000),
    struct('N', 100, 'n', 10000),
    struct('N', 1000, 'n', 1000)
};

% Plot mean squared displacement for each case
for i = 1:length(cases)
    case_i = cases{i};
    N = case_i.N;
    n = case_i.n;
    [mean_squared_displacement, final_mean_squared_displacement] = random_walk_simulation(N, n);
    
    figure;
    plot(0:n, mean_squared_displacement, 'LineWidth', 2);
    xlabel('Number of steps (n)');
    ylabel('<x^2>');
    title(['N=', num2str(N), ', n=', num2str(n), ', Last step <x^2>=', num2str(final_mean_squared_displacement)]);
    grid on;
end
