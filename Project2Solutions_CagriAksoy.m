% MehmetCagri Aksoy - 2020
% Contact: mcagriaksoy@ya.ru
% More information at: https://github.com/mcagriaksoy/EE7025_ImageProcessingLecture_Projects

%% EE7025- PROJECT-2 SOLUTIONS %%

%% Question-1 Answer:
% 1. Write a program that can compute the histogram of a grayscale image 
% (assuming 256 levels of gray). and display the histogram as a stem plot
% besides the image (for example, using “subplot” function if you use MATLAB). 
% Apply your program to Figure 3.23(a) and show the results.

img1=imread('Fig0323(a)(mars_moon_phobos).tif');
figure(1),
subplot(1,2,1), imshow(img1);
title(['\fontsize{8}Referenced Image']);
subplot(1,2,2), hist = histogram(img1);
title(['\fontsize{8}Histogram Graph ']);

%% Question-2 Answer:
% 2.Write a program that performs histogram equalization on a grayscale image.

img2=imread('Fig0309(a)(washed_out_aerial_image).tif');

hist_eq = histeq(img2);
figure(2),
subplot(2,2,1), imshow(img2);
title(['\fontsize{8}Original Image ']);
subplot(2,2,2), hist2 = histogram(img2);
title(['\fontsize{8}Histogram Graph of Original One ']);
subplot(2,2,3), imshow(hist_eq);
title(['\fontsize{8}Enhanced Image ']);
subplot(2,2,4), hist3 = histogram(hist_eq);
title(['\fontsize{8}Histogram Graph of Enhanced One ']);

%% Question-3 Answer:

% 3.Write program to perform spatial filtering of an image.
% You can fix the size of the spatial mask at 3 x 3, but the coefficients
% need to be variables that can be input into your program.

img3=imread('Fig0340(a)(dipxe_text).tif');
% mask = [1,1,1;1,1,1;1,1,1];
k = 30; 
% When 𝑘=1 we get unsharp masking, if 𝑘>1, we obtain highboost filtering

mask = ones(3)/9;
img_masked = imfilter(img3,mask); 
img_boost = k*(img3 - img_masked);
img_boost = img3 + img_boost;
figure(3),
subplot(1,2,1), imshow(img3);
title(['\fontsize{8}Original Image ']);
subplot(1,2,2), imshow(img_boost);
title(['\fontsize{8}High-Boosted Image ']);

%% Question-4 Answer:

% 4.Use the program that you develeoped in Question 3 to implement the
% Laplacian enhancement technique 

img4=imread('Fig0338(a)(blurry_moon).tif');

laplacian_mask = -1 * ones(3);
laplacian_mask(2,2) = 8;
img4_laplacian = conv2(img4, laplacian_mask, 'same');

img4_laplacian = img4 + uint8(img4_laplacian);

figure(4),
subplot(1,2,1), imshow(img4);
title(['\fontsize{8}Original Image ']);
subplot(1,2,2), imshow(img4_laplacian);
title(['\fontsize{8}Laplacian enhanced Image ']);

% MehmetCagri Aksoy