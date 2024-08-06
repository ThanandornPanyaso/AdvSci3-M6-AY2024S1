clearvars;
nrun = 100; % Number of simulation runs
nstep = 10000; % Number of time steps
A = zeros(nrun, nstep); % Preallocate array for molecule counts
A(:,1) = 20; % Initial number of molecules
dt = 0.005; % Time step
k = 0.1; % Rate constant
p = k * dt; % Probability per time step

% Perform stochastic simulation
for i = 1:nrun
    for j = 1:nstep-1
        if A(i,j) > 0
            if rand() < p * A(i,j)
                A(i,j+1) = A(i,j) - 1; % Molecule A is consumed
            else
                A(i,j+1) = A(i,j); % Molecule A remains the same
            end
        else
            break; % No molecules left to react
        end
    end
end

% Calculate mean number of molecules at each time step
meanA = mean(A, 1);


% Plot SSA results
time = (0:nstep-1) * dt; % Time vector
figure;
lgd = legend('AutoUpdate','off');
hold on;
colors = lines(nrun); % Generate a colormap with 'nrun' different colors
for i = 1:nrun
    stairs(time, A(i,:), 'Color', colors(i,:)); % Individual runs with unique colors
end

lgd.AutoUpdate = "on";
plot(time, meanA, 'k--', 'LineWidth', 2,'DisplayName','SSA Mean'); % Mean number of molecules in dashed black line

% Initialize variables for Gillespie
t = 0;
A = 20;
time_vec = t;
A_vec = A;

% Perform Gillespie simulation
while A > 0
    r = rand; % Uniform random number
    tau = (1 / (A * k)) * log(1 / r); % Time to next reaction
    t = t + tau; % Update time
    A = A - 1; % Molecule A is consumed
    
    % Store results
    time_vec = [time_vec; t];
    A_vec = [A_vec; A];
end
    
plot(time_vec, A_vec,  'r--', 'LineWidth', 2, 'DisplayName','Gillespie 1 run');
xlabel('Time (sec)');
ylabel('Number of Molecules A');
title('Fixed Time Step Stochastic Simulation');

hold off;
