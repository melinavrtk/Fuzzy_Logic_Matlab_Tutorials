clc; clear; close all;

% =========================================================
% Part 1: Define Trapezoidal Membership Functions & Union
% =========================================================
x = linspace(-1, 10, 1000); % Universe of discourse

% Define Trapezoidal Membership Functions: [bottom-left, top-left, top-right, bottom-right]
t1 = trapmf(x, [-1, 0, 1, 4]);
t2 = trapmf(x, [1, 4, 5, 10]);

% Compute the Union (MAX operator) of the two fuzzy sets
union_set = max(t1, t2);

% Visualize the sets and their union
figure;
plot(x, t1, 'k', 'LineWidth', 2); hold on;
plot(x, t2, 'k--', 'LineWidth', 2);
plot(x, union_set, 'r', 'LineWidth', 3);
title('Fuzzy Sets Union & Defuzzification');
xlabel('Universe of Discourse'); ylabel('Membership Degree');
legend('Trapezoid 1', 'Trapezoid 2', 'Union (Aggregated Set)');
grid on;

% =========================================================
% Part 2: Defuzzification Methods (Manual Implementation)
% =========================================================

% 1. Centroid (Center of Gravity / Area)
% Formula: sum(x * mu(x)) / sum(mu(x))
numerator_centroid = sum(x .* union_set);
denominator = sum(union_set);
centroid_val = numerator_centroid / denominator;

% 2. Mean of Maximum (MoM)
% Finds the mean of all elements x that have the maximum membership degree
max_value = max(union_set);             % Find the peak membership value
max_points = x(union_set == max_value); % Find all x coordinates with this peak value
mean_of_max = mean(max_points);         % Average these x coordinates

% 3. Weighted Average
% Note: When computed over the entire aggregated continuous set as done here, 
% the Weighted Average is mathematically identical to the Centroid method. 
% (Typically, Weighted Average is calculated using only the centers of symmetrical output sets).
wa_numerator = sum(x .* union_set);  
wavg = wa_numerator / denominator;

% =========================================================
% Display Results
% =========================================================
fprintf('--- Defuzzification Results ---\n');
fprintf('Centroid (Center of Gravity) : %.4f\n', centroid_val);
fprintf('Mean of Maximum (MoM)        : %.4f\n', mean_of_max);
fprintf('Weighted Average             : %.4f\n', wavg);

% Plot the defuzzified values as vertical lines on the graph
xline(centroid_val, 'b-', 'Centroid', 'LineWidth', 2);
xline(mean_of_max, 'm-', 'Mean of Max', 'LineWidth', 2);
