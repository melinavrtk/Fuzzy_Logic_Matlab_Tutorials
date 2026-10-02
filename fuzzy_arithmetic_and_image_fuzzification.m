clc; clear; close all;

% =========================================================
% Part 1: Fuzzy Arithmetic (Extension Principle)
% =========================================================
x = linspace(0, 20, 1000); % Universe of discourse

% Define two Triangular Fuzzy Numbers
A1 = trimf(x, [1, 2, 3]);
A2 = trimf(x, [4, 5, 6]);

% Fuzzy Addition and Multiplication using 'fuzarith' 
% (Based on Zadeh's Extension Principle)
fuzzy_sum = fuzarith(x, A1, A2, 'sum');
fuzzy_prod = fuzarith(x, A1, A2, 'prod');

figure;
plot(x, A1, 'b', 'LineWidth', 2); hold on;
plot(x, A2, 'c', 'LineWidth', 2);
plot(x, fuzzy_sum, 'r', 'LineWidth', 2);
plot(x, fuzzy_prod, 'm', 'LineWidth', 2);
title('Fuzzy Arithmetic: Addition and Multiplication');
xlabel('Universe of Discourse'); ylabel('Membership Degree');
legend('Fuzzy Number A1', 'Fuzzy Number A2', 'Fuzzy Sum (A1+A2)', 'Fuzzy Product (A1*A2)');
grid on;

% =========================================================
% Part 2: Common Misconception in Fuzzy Aggregation
% =========================================================
w1 = 0.7;
w2 = 0.5;

% WARNING: The following operation scales the membership degrees (y-axis) 
% rather than performing arithmetic on the fuzzy numbers (x-axis).
% As noted in the comments: "It is wrong - it results in a set in another dimension" 
% because it modifies membership heights instead of shifting the fuzzy set.
y_wrong = (w1 * A1 + w2 * A2) / (w1 + w2);

figure;
plot(x, A1, 'b--', 'LineWidth', 1.5); hold on;
plot(x, A2, 'c--', 'LineWidth', 1.5);
plot(x, y_wrong, 'k', 'LineWidth', 2);
title('Incorrect Fuzzy Aggregation (Direct Membership Scaling)');
legend('A1', 'A2', 'Weighted Avg of Memberships (Incorrect Concept)');
grid on;

% =========================================================
% Part 3: Image Fuzzification (Property Domain / G-function)
% =========================================================
% Based on standard literature for defining a fuzzy image matrix:
% mu_mn = G(x_mn) = [1 + (x_max - x_mn)/Fd]^(-Fe)
% Fd = (x_max - x_mid) / (2^(1/Fe) - 1)

% Example parameters for an 8-bit grayscale image
x_max = 255; % Maximum pixel intensity (e.g., white)
x_mid = 128; % Mid-point intensity (crossover point)
Fe = 2;      % Exponential fuzzifier

% Calculate the denominator factor Fd
Fd = (x_max - x_mid) / ((2^(1/Fe)) - 1);

% Define the fuzzification function G(x_mn)
G_function = @(x_mn) (1 + (x_max - x_mn) / Fd).^(-Fe);

% Test the function on the standard image intensity range [0, 255]
pixel_intensities = linspace(0, x_max, 256);
mu_image = G_function(pixel_intensities);

figure;
plot(pixel_intensities, mu_image, 'g', 'LineWidth', 2);
title('Image Fuzzification (G-Function for Property Domain)');
xlabel('Pixel Intensity (x_{mn})'); ylabel('Fuzzy Membership (\mu_{mn})');
grid on;
