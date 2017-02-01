clear;
img = imread('pup.jpg');
orig_img = rgb2gray(img);
img = double(rgb2gray(img));
r = size(img,1);
c = size(img,2);

fis = readfis('imageEnhancement.fis');
k = 1;
for i = 1:r
    for j =1:c
        input(k,1) = img(i,j);
        k = k + 1;
    end
end

output = evalfis(input,fis);

k = 1;
for i = 1:r
    for j = 1:c
        final(i,j) = output(k,1);
        k = k + 1;
    end
end

subplot(1,2,1);
imshow(orig_img);
subplot(1,2,2);
imshow(final,[]);