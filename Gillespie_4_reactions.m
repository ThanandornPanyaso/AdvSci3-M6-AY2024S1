function [A_counts, B_counts, time] = gillespie_algorithm(max_t,n_step)
    % Initial conditions
    A = 0;
    B = 0;
    
    % Rate constants
    k1 = 10^-3;
    k2 = 10^-2;
    k3 = 1.2;
    k4 = 1;
    
    % Time settings
    t_max = max_t;
    time_points = n_step;
    
    % Arrays to store molecule counts and time
    time = zeros(1, time_points);
    A_counts = zeros(1, time_points);
    B_counts = zeros(1, time_points);
    
    % Initial conditions
    t = 0;
    time(1) = t;
    A_counts(1) = A;
    B_counts(1) = B;
    
    i = 1;
    while t < t_max
        i = i + 1;
        
        % Step 1: Generate two random numbers r1, r2 uniformly distributed in (0,1)
        r1 = rand;
        r2 = rand;
        
        % Step 2: Compute the propensity functions
        a1 = k1 * A * A;
        a2 = k2 * A * B;
        a3 = k3;
        a4 = k4;
        a0 = a1 + a2 + a3 + a4;
        
        % Step 3: Compute the time to the next reaction
        tau = (1 / a0) * log(1 / r1);
        
        % Step 4: Determine which reaction occurs
        if r2 < a1 / a0
            A = A - 2;
        elseif r2 < (a1 + a2) / a0
            A = A - 1;
            B = B - 1;
        elseif r2 < (a1 + a2 + a3) / a0
            A = A + 1;
        else
            B = B + 1;
        end
        
        % Update time and store counts
        t = t + tau;
        time(i) = t;
        A_counts(i) = A;
        B_counts(i) = B;
        
        % Break if time exceeds the maximum time
        if i == time_points
            break;
        end
    end
    
    % Remove unused preallocated elements
    time(i+1:end) = NaN;
    A_counts(i+1:end) = NaN;
    B_counts(i+1:end) = NaN;
    

end
clearvars;
Nrun = 10;
max_t = 170;
n_step = 500;
A_array = [];
B_array = [];
time_array = [];


for i = 1:Nrun

    [A_count, B_count, time] = gillespie_algorithm(max_t,n_step);
     A_array = [A_array;A_count];
     B_array = [B_array;B_count];
     time_array =  [time_array;time];

end
max_t = max(time_array, [], 'all');
time = linspace(0,max_t,n_step);

 % Plot results
figure;
subplot(2, 1, 1);
lgd= legend();
lgd.AutoUpdate ="off";
hold on;
for i = 1:Nrun
     plot(time_array(i,:),A_array(i,:), 'Color', [125 125 125]/255, 'LineWidth', 0.2);
end
lgd.AutoUpdate ="on";
plot(time, mean(A_array,"omitnan"), 'r', 'LineWidth', 2, 'DisplayName','Mean');
xlabel('Time (sec)');
ylabel('Number of Molecules A');
hold off;


subplot(2, 1, 2);
lgd = legend();
lgd.AutoUpdate ="off";
hold on;
for i = 1:Nrun
     plot(time_array(i,:),B_array(i,:), 'Color', [125 125 125]/255, 'LineWidth', 0.2);
end
lgd.AutoUpdate ="on";
plot(time, mean(B_array,"omitnan"), 'b', 'LineWidth', 2, 'DisplayName','Mean');
xlabel('Time (sec)');
ylabel('Number of Molecules B');
hold off;