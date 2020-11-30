% MehmetCagri Aksoy - 2020
% Contact: mcagriaksoy@ya.ru
% More information at: https://github.com/mcagriaksoy/EE7025_ImageProcessingLecture_Projects

%% EE7025- PROJECT-1 SOLUTIONS %%

%% Question-1 Answer:
% 1.	Write a computer program capable of reducing the number of intensity 
% levels in a image from 256 to 2, in integer powers of 2. The desired number 
% of intensity levels needs to be a variable input to your program. Apply your
% program to Figure 2.21(a)  and duplicate the results shown in Figure 2.21
% of the book.

img1=imread('Fig0221(a)(ctskull-256).tif');
figure (1),
k=8;
while (k>0)
    intensity_level = 2^k;  
    changed_img = 512/intensity_level;
    img_reduced = uint8(floor(img1/intensity_level));
    subplot(3, 3, k);
imshow(img_reduced, [0,(changed_img-1)]);
    title(['\fontsize{8}Changed Intensity Lvl = ', num2str(changed_img)]);
    k = k-1;
end

%% Question-2 Answer:
% 2.	Write a computer program capable of zooming and shrinking an image by 
% pixel replication. Assume that the desired zoom/shrink factors are integers.
% Apply your program to Figure 2.21(a) to shrink the image by a factor of 10.
% Use your program to zoom the image in back to the resolution of the original.
% Explain the reasons for their differences.  

img2=imread('Fig0221(a)(ctskull-256).tif');
size2 = size(img2);
img2_resized = imresize(img2,10);
size2_resized = size(img2_resized);
figure(2),
subplot(1,2,1), imshow(img2);
title(['\fontsize{8}Original Size = ', num2str(size2)]);
subplot(1,2,2), imshow(img2_resized);
title(['\fontsize{8}Interpolated Size = ', num2str(size2_resized)]);

%% Question-3 Answer:
% 3.	Repeat 2 by using bilinear and bicubic interpolations.

img3=imread('Fig0221(a)(ctskull-256).tif');
img3_bicubic = imresize(img3,10,'bicubic');
img3_bilinear = imresize(img3,10,'bilinear');
size3_bicubic = size(img3_bicubic);
size3_bilinear = size(img3_bilinear);


figure(3),
subplot(1,2,1), imshow(img3_bicubic);
title(['\fontsize{8}bicubic Interpolated Size = ', num2str(size3_bicubic)]);
subplot(1,2,2), imshow(img3_bilinear);
title(['\fontsize{8}bilinear Interpolated Size = ', num2str(size3_bilinear)]);

%% Question-4 Answer:

% 4.Write a computer program to implement affine transformation via inverse 
% mapping.  Apply your program to Figure 2.36(a) for the following affine 
% transforms and show the output images in each case (Hint: the first matrix
% rotates the image by 30 degrees, the second matrix shrinks the image by a
% factor of 2, and the last matrix shifts the image 15 pixels and 20 pixels 
% in the horizontal and vertical directions, respectively).
img4=imread('Fig0236(a)(letter_T).tif');
a = [0.866 0.5 0;-0.5 0.866 0; 0 0 1];
tform_a = affine2d(a);
b = [2 0 0; 0 2 0; 0 0 1];
tform_b = affine2d(b);
% c = [1 0 1; 0 1 0; 15 20 1];
% tform_c = affine2d(c);

img4_a = imwarp(img4,tform_a);
img4_b = imwarp(img4,tform_b);
% img3_c = imwarp(img3,tform_c);

figure(4),
subplot(1,3,1), imshow(img4_a);
title(['\fontsize{8}Rotated to 30degree CW']);
subplot(1,3,2), imshow(img4_b);
title(['\fontsize{8}Shrinked by 2']);
% subplot(1,3,3), imshow(img3_c);
% title(['\fontsize{8} ']);

%% Question-5 Answer:

% Write a program to implement image registration. The inputs to your program 
% are the original and distorted images, and the suitably chosen 4 reference
% point pairs in these images. The outputs of your program should be the 
% transformation parameters given by  c_1,c_2,…,c_8, the registered image and 
% the difference image between the original and the registered images. Apply
% horizontal shearing to Figure 2.37(a) to get a distorted image by selecting 
% an appropriate value for the parameter s_h in the horizontal shearing. Use 
% your registration program to get the registered and the difference 
% images

img5=imread('Fig0237(a)(characters test pattern)_POST.tif');
tform = affine2d([1 0 0; .5 1 0; 0 0 1]);
img5_horiz = imwarp(img5,tform);

[mp,fp] = cpselect(img5,img5_horiz,'Wait',true);
t = fitgeotrans(mp,fp,'projective');
Rfixed = imref2d(size(img5_horiz));
registered = imwarp(unregistered,t,'OutputView',Rfixed);
imshowpair(img5_horiz,registered,'blend')

% MehmetCagri Aksoy