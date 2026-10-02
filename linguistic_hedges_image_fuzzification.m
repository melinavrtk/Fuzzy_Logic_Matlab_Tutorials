clc; clear; close all;

% =========================================================
% Part 1: Gaussian Membership Functions & Linguistic Hedges
% =========================================================
x = linspace(70, 97, 1000); % Universe of discourse
centers = linspace(70, 97, 3); % 3 centers for the fuzzy sets
sigma = 9; % Standard deviation

% Generate Gaussian membership functions
A = zeros(length(centers), length(x));
for i = 1:length(centers)
    A(i,:) = gaussmf(x, [sigma, centers(i)]);
end

figure;
plot(x, A, 'b', 'LineWidth', 2); hold on;

% Linguistic Hedges (Modifiers)
% 1. Dilation (e.g., "Somewhat"): Square root of membership degree (power of 0.5)
B1_dilated = A(2,:).^0.5;

% 2. Concentration (e.g., "Very"): Square of membership degree (power of 2)
B2_concentrated = A(3,:).^2;

plot(x, B1_dilated, 'm--', 'LineWidth', 2);
plot(x, B2_concentrated, 'g--', 'LineWidth', 2);
title('Fuzzy Sets & Linguistic Hedges (Dilation / Concentration)');
legend('Set 1', 'Set 2', 'Set 3', 'Set 2 Dilated (x^{0.5})', 'Set 3 Concentrated (x^2)');
xlabel('Universe of Discourse'); ylabel('Membership Degree');
grid on;

% =========================================================
% Part 2: Image Fuzzification Concept (Medical Image Processing)
% =========================================================
% In fuzzy image processing, pixel intensities (usually [0, 255]) 
% must be mapped to fuzzy membership degrees [0, 1].
% 
% Example workflow (Commented out):
% Im = imread('medical_image.bmp'); % Read the image
% ImF = rescale(Im); % Normalizes intensities from [0, 255] to [0, 1]
%
% % To display the original and fuzzified image side-by-side:
% % figure;
% % subplot(1, 2, 1); imshow(Im); title('Original Image');
% % subplot(1, 2, 2); imshow(ImF); title('Fuzzified (Scaled [0,1])');

% =========================================================
% Part 3: Yager Complement with Anonymous Functions
% =========================================================
% Define Yager complement as an anonymous function
% Formula: C_w(x) = (1 - x^w)^(1/w)
yager = @(x,w) (1 - x.^w).^(1/w); 

% Apply Yager complement to Set 2 for different values of w
w_values = [0.5, 1, 2];

figure;
plot(x, A(2,:), 'k', 'LineWidth', 2); hold on;

colors = {'r', 'b', 'm'};
for i = 1:length(w_values)
    w = w_values(i);
    % Calculating Yager complement for the specific w
    Cw = yager(A(2,:), w);
    plot(x, Cw, colors{i}, 'LineWidth', 2);
end

title('Yager Complement for Various w Values');
xlabel('Universe of Discourse'); ylabel('Membership Degree');
legend('Original Set 2', 'Yager w=0.5', 'Yager w=1', 'Yager w=2');
grid on;
