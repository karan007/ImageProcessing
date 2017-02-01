clear;
% image imported as a matrix of rgb intensities.
Irgb = imread('train.jpg');  
% image converted to grayscale so that we can work on a 2d matrix instead
% of 3d matrix
Igray = rgb2gray(Irgb);

%Fuzzy logic toolbox operates on double precision matrices.
I = double(Igray)/255;

% fuzzy logic edge-detection algorithm for this example relies on the image
% gradient to locate breaks in uniform regions

%Sobel Operator
%sobelx = [-1 0 1;-2 0 2;-1 0 1];
%sobely = sobelx';
%Ix = conv2(I,sobelx,'same');
%Iy = conv2(I,sobely,'same');

%sobely = [1 0 -1;0 0 0;-1 0 1];
%sobelx = sobely';
%Ix = conv2(I,sobelx,'same');
%Iy = conv2(I,sobely,'same');

%sobely = [-1 -1 -1;-1 8 -1;-1 -1 -1];
%sobelx = sobely';
%Ix = conv2(I,sobelx,'same');
%Iy = conv2(I,sobely,'same');

%Image Gradient between -1 and 1
%Gx = [-1 1];
%Gy = Gx';
%s = [1;1];
%Ix = conv2(conv2(I,Gx,'same'),s,'same')*0.5;
%Iy = conv2(conv2(I,Gy,'same'),s','same')*0.5;

fis = readfis('edgeDetection.fis');

Ieval = I;   % Preallocate the output matrix
for ii = 1:size(I,1)
    Ieval(ii,:) = evalfis([(Ix(ii,:));(Iy(ii,:));]',fis);
end

%plotting the result
%values will be in range of 0 to 1, so we scale them by using imagesc and
%then plot them
figure; imagesc(255-Ieval); colormap('gray');
title('Edge Detection Using Fuzzy Logic')