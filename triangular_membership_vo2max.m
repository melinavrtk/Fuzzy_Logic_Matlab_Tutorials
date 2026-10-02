clc; clear; close all;

% Define the universe of discourse for VO2max
VO2max = linspace(70, 97, 1000);

% Define Triangular Membership Function for Set I (e.g., Intermediate)
% Parameters: [start, peak, end]
muI = trimf(VO2max, [72, 79, 93]);

% Define Triangular Membership Function for Set B (e.g., Beginner)
% Parameters: [start, peak, end]
% Note: start and peak are both 70, creating a right-angled triangle shape
muB = trimf(VO2max, [70, 70, 95]);

% Plot the membership functions
figure;
plot(VO2max, muI, 'b', 'LineWidth', 2);
hold on;
plot(VO2max, muB, 'r', 'LineWidth', 2);
title('Triangular Membership Functions for VO2max');
xlabel('VO2max (ml/kg/min)');
ylabel('Membership Degree');
legend('Set I', 'Set B');
grid on;

% =========================================================
% Evaluate membership degrees for specific crisp inputs
% =========================================================

% Find the membership degree of VO2max = 77 for Set I
muI_77 = trimf(77, [72, 79, 93]);
fprintf('Membership degree of VO2max = 77 in Set I: %.4f\n', muI_77);

% Evaluate membership degrees for multiple specific values (77 and 95) simultaneously
dum = trimf([77, 95], [72, 79, 93]);
fprintf('Membership degree of VO2max = 77 in Set I: %.4f\n', dum(1));
fprintf('Membership degree of VO2max = 95 in Set I: %.4f\n', dum(2));

% Alternative: Gaussian Membership Function (Example)
% muI_gauss = gaussmf(VO2max, [1, 80]); % [sigma, center]
