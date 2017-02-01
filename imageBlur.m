clear;
% image imported as a matrix of rgb intensities.
Irgb = imread('lehar_boat.jpg');  
% image converted to grayscale so that we can work on a 2d matrix instead
% of 3d matrix
Igray = rgb2gray(Irgb);

%Fuzzy logic toolbox operates on double precision matrices.
I = double(Igray)/255;

% fuzzy logic edge-detection algorithm for this example relies on the image
% gradient to locate breaks in uniform regions

blur = [0.0625,0.125,0.0625;0.125,0.25,0.125;0.0625,0.125,0.0625];
Blurred_image = conv2(I,blur,'same');

box_blur = [1/9 1/9 1/9;1/9 1/9 1/9;1/9 1/9 1/9];
Box_Blurred_image = conv2(I,box_blur,'same');

%plotting the result
%values will be in range of 0 to 1, so we scale them by using imagesc and
%then plot them
figure; imagesc(Box_Blurred_image); colormap('gray');
title('Edge Detection Using Fuzzy Logic')