
%======================================%
%           XMASS TREE CREATOR         %
%                09/02/15              %
%           updated: 03/15/16          %
%                 WALIII               %
%======================================%
 
%  Takes Averages of a days MAX projections, and clips the image in the
%  95th and 5th percentile across all days, based on the pixel intensity
%  vales of the ROIs in the image.



%%

% Load all images in:
% XmassData.m, was loaded in as such:

% A = imread('ave_maxdff_09.tiff');
% B = imread('ave_maxdff_10.tiff');
% C = imread('ave_maxdff_11.tiff');
% D = imread('ave_maxdff_12.tif');
% E = imread('ave_maxdff_13.tiff');

%Should also contain ROI locations

%% Step One, plot sample image, and plot ROI selections on top of this image:
G = imagesc(A);

hold on; 

for i = 1:size(ROI.coordinates,2)
plot(ROI.coordinates{1,i}(:,1),ROI.coordinates{1,i}(:,2));
hold on;

end

%% Step Two, concatonate the ROI data to a single (x,y) matrix
KittyCat = cat(1,ROI.coordinates{:}); % concatonate ROI locations
Linind = sub2ind(size(A),KittyCat(:,2),KittyCat(:,1)); % make index from ROI locations

%% Step Three, Take pixel value data from the index locations, from each image
AV = A(Linind);
BV = B(Linind);
CV = C(Linind);
DV = D(Linind);
EV = E(Linind);

LinKat = cat(1,AV,BV,CV,DV,EV); % concat each indexed pixel value
% make a histogram of the concatonated pixel values, for every pixel value in the image, and for just the p
% the pixel values idexed from the ROIs

[counts,binLocations] = imhist(LinKat); 
figure();
subplot(2,1,1)
plot(binLocations,counts);
title('hist of ALL ROI values')
xlabel('Pixel value')
ylabel('Pixel count')
subplot(2,1,2)
[counts,binLocations] = imhist(A);
plot(binLocations,counts);
title('hist of total image')
xlabel('Pixel value')
ylabel('Pixel count')


figure(); % Plot the pixel value distribution seperately for each day of imaging
subplot(5,1,1)
[counts,binLocations] = imhist(AV);
plot(binLocations,counts);
title('Pixel value distribution Day 1')
xlabel('Pixel value')
ylabel('Pixel count')

subplot(5,1,2)
[counts,binLocations] = imhist(BV);
plot(binLocations,counts);
title('Pixel value distribution Day 2')
xlabel('Pixel value')
ylabel('Pixel count')

subplot(5,1,3)
[counts,binLocations] = imhist(CV);
plot(binLocations,counts);
title('Pixel value distribution Day 3')
xlabel('Pixel value')
ylabel('Pixel count')

subplot(5,1,4)
[counts,binLocations] = imhist(DV);
plot(binLocations,counts);
title('Pixel value distribution Day 4')
xlabel('Pixel value')
ylabel('Pixel count')

subplot(5,1,5)
[counts,binLocations] = imhist(EV);
plot(binLocations,counts);
title('Pixel value distribution Day 5')
xlabel('Pixel value')
ylabel('Pixel count')

%% plot an image that clips the image by the 95th percentile and the 5th percentile of the pixel data
H = prctile(LinKat,100);
L = prctile(LinKat,0);

figure();
clims = [L H]; % limits of the data to be plotted 
colormap(gray)




%% Perform Motion Correction 


MaxProj(:,:,1) = A;
MaxProj(:,:,2) = B;
MaxProj(:,:,3) = C;
MaxProj(:,:,4) = D;
MaxProj(:,:,5) = E;


disp('Performing Motion Correction transform Calculation');
  X2 = MaxProj(:,:,3);
  [optimizer, metric] = imregconfig('multimodal');
  optimizer.InitialRadius = 0.009;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 300;
for ii = 1:size(MaxProj,3)
  tform = imregtform(MaxProj(:,:,ii),X2,'rigid',optimizer,metric);
  MaxProj2(:,:,ii) = imwarp(MaxProj(:,:,ii),tform,'OutputView',imref2d(size(X2))); % align locally to 7th image
end

A = MaxProj2(:,:,1);
B = MaxProj2(:,:,2);
C = MaxProj2(:,:,3);
D = MaxProj2(:,:,4);
E = MaxProj2(:,:,5);

% D = MaxProj2(:,:,4);
% E = MaxProj2(:,:,5);

%% Create and Plot each day of imaging by a common clim
% subplot(5,1,1)
% imagesc(A,clims);
% title('Day1')
% axis off

% subplot(5,1,2)
% imagesc(B,clims);
% title('Day2')
% axis off
% 
% subplot(5,1,3)
% imagesc(C,clims);
% title('Day3')
% axis off
% 
% subplot(5,1,4)
% imagesc(D,clims);
% title('Day4')
% axis off
% 
% subplot(5,1,5)
% imagesc(E,clims);
% title('Day5')
% axis off

%% Create and Plot RGB Xmass tree images
D123(:,:,1) = A;
D123(:,:,2) = B;
D123(:,:,3) = C;

D234(:,:,1) = B;
D234(:,:,2) = C;
D234(:,:,3) = D;

D345(:,:,1) = C;
D345(:,:,2) = D;
D345(:,:,3) = E;

figure();
% subplot(1,3,1)
% image(D123);
% axis off

% subplot(1,3,2)
image(D234);
axis off

% subplot(1,3,3)
% image(D345);
% axis off


%% print each image as a tif or png file

imwrite(A,'day01.tif')
imwrite(B,'day02.tif')
imwrite(C,'day03.tif')
imwrite(D,'day04.tif')
imwrite(E,'day05.tif')

% imwirite(D123,'D123.png')
% imwrite(D234,'D234.png')
% imwrite(D345,'D345.png')



