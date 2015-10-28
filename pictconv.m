clc; clear; close all;

[X,map] = imread('numb.png');
figure,imshow(X,map)

BW = im2bw(X,map,0.4); %converts the indexed image X with colormap map to a binary image.
%figure, imshow(BW)

smallBW = imresize(BW, [28 28]);
%figure, imshow(smallBW)

J = imcomplement(smallBW); 
figure, imshow(J)

[X, map] = gray2ind(J,3); %converts the binary image BW to an indexed image X. n specifies the size of the colormap, gray(n). If n is omitted, it defaults to 2.
imwrite(X,map,'numb28.png')