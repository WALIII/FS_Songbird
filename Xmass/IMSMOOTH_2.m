function IMSMOOTH(im_data,ROI)

% make normalized (Smoothed) Xmass Tree image


%IM_data = A{images};
data = im_data;
A = im_data{1};
KittyCat = cat(1,ROI.coordinates{:}); % concatonate ROI locations
Linind = sub2ind(size(im_data{1}),KittyCat(:,2),KittyCat(:,1)); % make index from ROI locations
cmap = gray;
%% Step Three, Take pixel value data from the index locations, from each image
[optimizer, metric] = imregconfig('multimodal')

for d = 1:size(im_data,2)
    tiledImage(:,:,d) = [data{d}, flipdim(data{d},1), data{d}; flipdim(data{d},2), data{d}, flipdim(data{d},2); data{d},flipdim(data{d},1), data{d}];
end





% for ii = 1:5;
% ToTdata(:,:,ii) =  imcrop(ToTdata(:,:,ii),[20 20 1400 1040]);
% end


%IM registration


for i = 1:size(im_data,2)
test = tiledImage(:,:,i);
test=imresize(double(test),1);
% 
% h=fspecial('disk',70);
% bground=imfilter(test,h);
% % bground=smooth3(bground,[1 1 5]);
% test=test./(bground+10);

ToTdata2(:,:,i) = double(test);
TempDat = test;
ToTdata3(:,:,i) = TempDat(size(A,1):size(A,1)*2,size(A,2):size(A,2)*2);%(1080:2160,1441:2880); %[xmin ymin width height].
end %(height,height*2% width,width*2:


ToTdata(:,:,1) = ToTdata3(:,:,1);
% for f = 2:5
% ToTdata(:,:,f) = imregister(ToTdata3(:,:,f), ToTdata(:,:,1), 'similarity', optimizer, metric);
% end

 for f =  2:size(im_data,2)
           [temp Greg] = dftregistration(fft2(ToTdata(:,:,1)),fft2(ToTdata3(:,:,f)),100);
           ToTdata(:,:,f) = abs(ifft2(Greg)); %% keep this data propogating through function....
 end

 for f = 1:size(im_data,2)
A1 = ToTdata(:,:,f);
AV{f} = A1(Linind);
clear A1
 end
% B1 = ToTdata(:,:,2);
% C1 = ToTdata(:,:,3);
% D1 = ToTdata(:,:,4);
% E1 = ToTdata(:,:,5);


% AV = A1(Linind);
% BV = B1(Linind);
% CV = C1(Linind);
% DV = D1(Linind);
% EV = E1(Linind);

LinKat = cat(1,AV{1},AV{2},AV{3}); % concat each indexed pixel value


H = prctile(LinKat,95);
L = prctile(LinKat,05);

clim=[ double(L) double(H)];


for ii = 1:size(im_data,2)

I=mat2gray(ToTdata(:,:,ii),[clim(1) clim(2)]);
IndI(:,:,ii) = round(I*255);

end


%Convert I to indices into the colormap,
for iii = 1:size(im_data,2);

D123(:,:,iii) = IndI(:,:,iii);
if size(im_data,2)>3;
D234(:,:,iii) = IndI(:,:,(iii+1));
D345(:,:,iii) = IndI(:,:,(iii+2));
end
end

imwrite(D123,cmap,'vD123_955_star.tif');
if size(im_data,2)>3;
imwrite(D234,cmap,'vD234_955_star.tif');
imwrite(D345,cmap,'vD345_955_star.tif');
end


%%%%% Make smoothed images.....


%figure(); imagesc(imgaussfilt(uint8(IndI(:,:,2)),2));

