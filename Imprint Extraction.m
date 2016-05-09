% This code implemented a comparison between “k-means” “mean-shift” and
% “normalized-cut” segmentation

% Teste methods are:
% Kmeans segmentation using (color) only
% Kmeans segmentation using (color + spatial)
% Mean Shift segmentation using (color) only
% Mean Shift segmentation using (color + spatial)
% Normalized Cut (inherently uses spatial data)

% an implementation by "Naotoshi Seo" with a little modification is used 
% for “normalized-cut” segmentation, available online at:
% "http://note.sonots.com/SciSoftware/NcutImageSegmentation.html"
% it is sensitive in choosing parameters.
% an implementation by "Bryan Feldman" is used for “mean-shift clustering" 

% Alireza Asvadi
% Department of ECE, SPR Lab
% Babol (Noshirvani) University of Technology
% http://www.a-asvadi.ir
% 2013
%% clear command windows
clc
clear all
close all
%% input
I    = imread('E:\edu\MST\SEM2\Randy Moss\Pill Challenge\dc\Mask Images2\27.jpg');    % Original: also test 2.jpg
%% parameters
% kmeans parameter
K    = 3;                  % Cluster Numbers
% meanshift parameter
bw   = 0.2;                % Mean Shift Bandwidth
% ncut parameters
SI   = 5;                  % Color similarity
SX   = 6;                  % Spatial similarity
r    = 1.5;                % Spatial threshold (less than r pixels apart)
sNcut = 0.21;              % The smallest Ncut value (threshold) to keep partitioning
sArea = 80;                % The smallest size of area (threshold) to be accepted as a segment
%% compare
Ikm          = Km(I,K);                     % Kmeans (color)
Ikm2         = Km2(I,K);                    % Kmeans (color + spatial)
[Ims, Nms]   = Ms(I,bw);                    % Mean Shift (color)
[Ims2, Nms2] = Ms2(I,bw);                   % Mean Shift (color + spatial)
%[Inc, Nnc]   = Nc(I,SI,SX,r,sNcut,sArea);   % Normalized Cut
%% show
figure(1)
subplot(231); imshow(I);    title('Original'); 
subplot(232); imshow(Ikm);  title(['Kmeans',' : ',num2str(K)]);
subplot(233); imshow(Ikm2); title(['Kmeans+Spatial',' : ',num2str(K)]); 
subplot(234); imshow(Ims);  title(['MeanShift',' : ',num2str(Nms)]);
subplot(235); imshow(Ims2); title(['MeanShift+Spatial',' : ',num2str(Nms2)]);
figure(2)

w     = 20;       % bilateral filter half-width
sigma = [20 0.1]; % bilateral filter standard deviations

I = im2double(I);
% I = bfilter2(I,w,sigma);
% I = I*255;
%I(:,:,1) = imgaussfilt(I(:,:,1),2);
%I(:,:,2) = imgaussfilt(I(:,:,2),2);
%I(:,:,3) = imgaussfilt(I(:,:,3),2);
x1=Ikm-I;
x1(:,:,1) = imadjust(imgaussfilt(x1(:,:,1),2));
x1(:,:,2) = imadjust(imgaussfilt(x1(:,:,2),2));
x1(:,:,3) = imadjust(imgaussfilt(x1(:,:,3),2));

x2=Ikm2-I;
x2(:,:,1) = imadjust(imgaussfilt(x2(:,:,1),2));
x2(:,:,2) = imadjust(imgaussfilt(x2(:,:,2),2));
x2(:,:,3) = imadjust(imgaussfilt(x2(:,:,3),2));

x3=Ims-I;
x3(:,:,1) = imadjust(imgaussfilt(x3(:,:,1),2));
x3(:,:,2) = imadjust(imgaussfilt(x3(:,:,2),2));
x3(:,:,3) = imadjust(imgaussfilt(x3(:,:,3),2));

x4=Ims2-I;
x4(:,:,1) = imadjust(imgaussfilt(x4(:,:,1),2));
x4(:,:,2) = imadjust(imgaussfilt(x4(:,:,2),2));
x4(:,:,3) = imadjust(imgaussfilt(x4(:,:,3),2));
subplot(231); imshow(I);    title('Original'); 
subplot(232); imshow(x1);  title(['Kmeans',' : ',num2str(K)]);
subplot(233); imshow(x2); title(['Kmeans+Spatial',' : ',num2str(K)]); 
subplot(234); imshow(x3);  title(['MeanShift',' : ',num2str(Nms)]);
subplot(235); imshow(x4); title(['MeanShift+Spatial',' : ',num2str(Nms2)]);
%subplot(236); imshow(Inc);  title(['NormalizedCut',' : ',num2str(Nnc)]); 

