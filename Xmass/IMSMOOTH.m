function IMSMOOTH(A,B,C,D,E,ROI)

% aAke normalized (Smoothed) Xmass Tree image


data = {A B C D E};


KittyCat = cat(1,ROI.coordinates{:}); % concatonate ROI locations
Linind = sub2ind(size(A),KittyCat(:,2),KittyCat(:,1)); % make index from ROI locations
cmap = gray;
%% Step Three, Take pixel value data from the index locations, from each image
[optimizer, metric] = imregconfig('multimodal')

for d = 1:5
    tiledImage(:,:,d) = [data{d}, flipdim(data{d},1), data{d}; flipdim(data{d},2), data{d}, flipdim(data{d},2); data{d},flipdim(data{d},1), data{d}];
end





% for ii = 1:5;
% ToTdata(:,:,ii) =  imcrop(ToTdata(:,:,ii),[20 20 1400 1040]);
% end


%IM registration


for i = 1:5
test = tiledImage(:,:,i);
test=imresize(double(test),1);

h=fspecial('disk',80);
bground=imfilter(test,h);
% bground=smooth3(bground,[1 1 5]);
test=test./(bground+10);

ToTdata2(:,:,i) = double(test);
TempDat = test;
ToTdata3(:,:,i) = TempDat(size(A,1):size(A,1)*2,size(A,2):size(A,2)*2);%(1080:2160,1441:2880); %[xmin ymin width height].
end %(height,height*2% width,width*2:


ToTdata(:,:,1) = ToTdata3(:,:,1);
% for f = 2:5
% ToTdata(:,:,f) = imregister(ToTdata3(:,:,f), ToTdata(:,:,1), 'similarity', optimizer, metric);
% end

 for f =  2:5
           [temp Greg] = dftregistration(fft2(ToTdata(:,:,1)),fft2(ToTdata3(:,:,f)),100);
           ToTdata(:,:,f) = abs(ifft2(Greg)); %% keep this data propogating through function....
 end

A1 = ToTdata(:,:,1);
B1 = ToTdata(:,:,2);
C1 = ToTdata(:,:,3);
D1 = ToTdata(:,:,4);
E1 = ToTdata(:,:,5);


AV = A1(Linind);
BV = B1(Linind);
CV = C1(Linind);
DV = D1(Linind);
EV = E1(Linind);

LinKat = cat(1,AV,BV,CV,DV,EV); % concat each indexed pixel value


H = prctile(LinKat,100);
L = prctile(LinKat,40);

clim=[ double(L) double(H)];


for ii = 1:5

I=mat2gray(ToTdata(:,:,ii),[clim(1) clim(2)]);
IndI(:,:,ii) = round(I*255);

end


%Convert I to indices into the colormap,
for iii = 1:3;

D123(:,:,iii) = IndI(:,:,iii);
D234(:,:,iii) = IndI(:,:,(iii+1));
D345(:,:,iii) = IndI(:,:,(iii+2));

end

imwrite(D123,cmap,'vD123_955_star.tif');
imwrite(D234,cmap,'vD234_955_star.tif');
imwrite(D345,cmap,'vD345_955_star.tif');


%%%%% Make smoothed images.....


%figure(); imagesc(imgaussfilt(uint8(IndI(:,:,2)),2));

