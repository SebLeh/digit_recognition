clc; clear; close all;
%imread('numb28.png')

X = imread('numb.png');
figure,imshow(X)

smallBW = imresize(X, [28 28]);
figure,imshow(smallBW);

BW = im2bw(smallBW,0.6); %converts the indexed image X with colormap map to a binary image.

J = imcomplement(BW); 
figure, imshow(J)

X = gray2ind(J,256); %converts the binary image BW to an indexed image X. n specifies the size of the colormap, gray(n). If n is omitted, it defaults to 2.

imwrite(X,'numb28.png')