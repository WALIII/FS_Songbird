function FSA_Display_RGB_Batch(BIRD)

clear NormIm;
    AVG_DAT1 = BIRD{1};
    AVG_DAT2 = BIRD{3};
    AVG_DAT3 = BIRD{5};

    catVid = cat(3,AVG_DAT1{2},AVG_DAT2{2},AVG_DAT3{2});
for ii = [1 3 5]
    clear AVG_DAT; clear H, clear L;
    AVG_DAT = BIRD{ii};
    
    
    
    
for i = 1:3
    % Filter Data:
%     h = fspecial('disk',200);
%     bground = imfilter(AVG_DAT{i},h);
%     AVG_DAT{i} = AVG_DAT{i}-bground;
    % Adjust Clims:
    H = prctile(max(mean(catVid(:,:,:))),97.5);
    L = prctile(mean(mean(catVid(:,:,:))),2.5);
    
    clim = [double(L) double(H)];
    
NormIm(:,:,:,i) = mat2gray(AVG_DAT{i}, clim);

end


NAME = strcat('DAY_',num2str(ii));

%% Write VIDEO
v = VideoWriter(NAME);
v.Quality = 100;
v.FrameRate = 30;

if ii ==1;
RGB(:,:,:,1) = NormIm(:,:,:,2);
elseif ii ==3;
RGB(:,:,:,2) = NormIm(:,:,:,2);
elseif ii==5;
RGB(:,:,:,3) = NormIm(:,:,:,2);
end


open(v)
for iii = 2:size(NormIm(:,:,:,:),3)
    
    IM(:,:,:) = NormIm(:,:,iii,:);
writeVideo(v,IM)

end
close(v)
clear v;
end

v = VideoWriter('AcrossDays');
v.Quality = 100;
v.FrameRate = 22;



open(v)
for i = 1:size(RGB(:,:,:,:),3)
    
    

[temp Greg] = dftregistration(fft2(RGB(:,:,i,1)),fft2(RGB(:,:,i,1)),100);
[temp2 Greg2] = dftregistration(fft2(RGB(:,:,i,1)),fft2(RGB(:,:,i,2)),100);
[temp3 Greg3] = dftregistration(fft2(RGB(:,:,i,1)),fft2(RGB(:,:,i,3)),100);
IM(:,:,1) = abs(ifft2(Greg));
IM(:,:,2)= abs(ifft2(Greg2)); %% keep this data propogating through function....
IM(:,:,3)= abs(ifft2(Greg3));
IM(IM>1) = 1; IM(IM < 0) = 0;
    
writeVideo(v,IM)

clear temp; clear Greg; clear Greg2; clear temp2; clear Greg3; clear temp3; clear IM; 
end
close(v)
clear v;
