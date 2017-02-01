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

emboss = [-2 -1 0; -1 1 1;0 1 2];
Embossed_image = conv2(I,emboss,'same');

%plotting the result
%values will be in range of 0 to 1, so we scale them by using imagesc and
%then plot them
figure; imagesc(Embossed_image); colormap('gray');
title('Edge Detection Using Fuzzy Logic')