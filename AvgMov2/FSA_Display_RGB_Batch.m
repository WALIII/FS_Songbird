function FSA_Display_RGB_Batch(BIRD)

clear NormIm;
    AVG_DAT1 = BIRD{1};
    AVG_DAT2 = BIRD{2};
    AVG_DAT3 = BIRD{3};


    
for ii = 1:size(BIRD,2)
    
   catVid = cat(3,BIRD{ii}{1},BIRD{ii}{2},BIRD{ii}{3});
    clear AVG_DAT; clear H, clear L;
    AVG_DAT = BIRD{ii};
    REF_DAT = BIRD{1};
    
    
    
for i = 1:size(BIRD{ii},2)

    H = prctile(max(max(AVG_DAT{i}(:,:,:))),70);
    L = prctile(mean(min(AVG_DAT{i}(:,:,:))),20);
    
    clim = [double(L) double(H)];

NormIm(:,:,:) = mat2gray(AVG_DAT{i}, clim);
RefIm(:,:,:) = mat2gray(REF_DAT{i}, clim);



NAME = strcat('DAY_',num2str(ii),'_Motif_',num2str(i));

v1 = VideoWriter(NAME);
v1.Quality = 100;
v1.FrameRate = 30;



open(v1)
for iii = 2:size(NormIm(:,:,:),3)
    
    %IMAGE REGISTRATION
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


