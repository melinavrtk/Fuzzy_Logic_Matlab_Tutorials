clc; clear; close all;

% =========================================================
% Part 1: Read and Prepare the Image
% =========================================================
% Read image (Using a built-in MATLAB image for universal execution)
% Replace 'cameraman.tif' with '28.bmp' to use your specific image.
im = imread('cameraman.tif'); 

% Convert to double for mathematical operations
im = double(im);

% =========================================================
% Part 2: Image Fuzzification (Property Domain)
% =========================================================
% Define the fuzzification G-function (Anonymous function)
mu_mn = @(x, xmax, Fd, Fe) (1 + (xmax - x) / Fd).^(-Fe);

% Compute spatial parameters
xmax = max(im(:)); 
xmid = mean(im(:)); % Crossover point
Fe = 2;             % Exponential fuzzifier
Fd = (xmax - xmid) / (2^(1/Fe) - 1); % Denominator factor

% Fuzzify image: Map pixel intensities [0, 255] to fuzzy memberships [0, 1]
imfuzzy = zeros(size(im));
for i = 1:size(im, 1)
    for j = 1:size(im, 2)
        imfuzzy(i,j) = mu_mn(im(i,j), xmax, Fd, Fe);
    end
end

% =========================================================
% Part 3: Apply the Intensification Operator (INT)
% =========================================================
% The INT operator enhances image contrast by making membership 
% values > 0.5 closer to 1, and values <= 0.5 closer to 0.
imfuzzy2 = zeros(size(im));
for i = 1:size(imfuzzy, 1)
    for j = 1:size(imfuzzy, 2)
        if imfuzzy(i,j) >= 0 && imfuzzy(i,j) <= 0.5
            % Decrease membership (darker)
            imfuzzy2(i,j) = 2 * imfuzzy(i,j)^2;
        else
            % Increase membership (brighter)
            imfuzzy2(i,j) = 1 - 2 * (1 - imfuzzy(i,j))^2;
        end
    end
end

% =========================================================
% Part 4: Defuzzification (Inverse mapping)
% =========================================================
% Compute alpha limit (membership of max intensity)
alpha = (1 + xmax / Fd)^(-Fe);
imD = zeros(size(im));

% Defuzzify the modified memberships back to spatial pixel intensities
for i = 1:size(imfuzzy, 1)
    for j = 1:size(imfuzzy, 2)
        if imfuzzy2(i,j) >= alpha
            % Inverse of the G-function
            imD(i,j) = xmax - Fd * (imfuzzy2(i,j)^(-1/Fe) - 1);
        else
            imD(i,j) = imfuzzy2(i,j);
        end
    end
end

% =========================================================
% Part 5: Visualize Results
% =========================================================
figure('Name', 'Fuzzy Image Contrast Enhancement', 'Position', [100, 100, 900, 400]);

subplot(1, 2, 1); 
imshow(uint8(im));
title('Original Image');

subplot(1, 2, 2); 
imshow(uint8(imD));
title('Contrast Enhanced (Fuzzy INT Operator)');
