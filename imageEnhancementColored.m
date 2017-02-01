clear;
img = imread('pup.jpg');
img = double(img);
r = size(img,1);
c = size(img,2);

fis = readfis('imageEnhancement.fis');

k = 1;
for i = 1:r
    for j =1:c
        for w =1:3
            input(k,1) = img(i,j,w);
            k = k + 1;
        end
    end
end

output = evalfis(input,fis);

k = 1;
for i = 1:r
    for j = 1:c
        for w = 1:3
            final(i,j,w) = output(k,1);
            k = k + 1;
        end
    end
end


subplot(2,2,1);
imshow(uint8(img));
xlabel('Original Image');

subplot(2,2,2);
imshow(uint8(final));
xlabel('Enhanced Image');

subplot(2,2,3);
imshow(255-rgb2gray(uint8(final)));
xlabel('Negative Image');