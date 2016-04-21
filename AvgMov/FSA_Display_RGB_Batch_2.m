function FSA_Display_RGB_Batch_2(BIRD)

clear NormIm;
    AVG_DAT1 = BIRD{1};
    AVG_DAT2 = BIRD{2};
    AVG_DAT3 = BIRD{3};


    catVid = cat(3,AVG_DAT1{2},AVG_DAT2{2},AVG_DAT3{2});
for ii = 1:size(BIRD,2)
    clear AVG_DAT; clear H, clear L;
    AVG_DAT = BIRD{ii};
    REF_DAT = BIRD{1};
    
    
    
for i = 1:3

    H = prctile(max(max(catVid(:,:,:))),70);
    L = prctile(mean(mean(catVid(:,:,:))),2.5);
    
    clim = [double(L) double(H)];

NormIm(:,:,:) = mat2gray(AVG_DAT{i}, clim);
RefIm(:,:,:) = mat2gray(REF_DAT{i}, clim);


NAME = strcat('DAY_',num2str(ii),'_Motif_',num2str(i));

v1 = VideoWriter(NAME);
v1.Quality = 100;
v1.FrameRate = 30;



open(v1)
for iii = 2:size(NormIm(:,:,:),3)
    
    
% [temp Greg] = dftregistration(fft2(RefIm(:,:,iii)),fft2(NormIm(:,:,iii)),100);
% IM(:,:)= abs(ifft2(Greg));
% IM(IM>1) = 1; IM(IM < 0) = 0;
IM = NormIm(:,:,iii);

writeVideo(v1,IM)

end
close(v1)
clear v1;

end
end


