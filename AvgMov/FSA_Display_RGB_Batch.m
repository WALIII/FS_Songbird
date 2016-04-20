function FSA_Display_RGB_Batch(BIRD)

clear NormIm;
for ii = 1:size(BIRD,2)
    clear AVG_DAT; clear H, clear L;
    AVG_DAT = BIRD{ii};
for i = 1:3
    % Filter Data:
%     h = fspecial('disk',200);
%     bground = imfilter(AVG_DAT{i},h);
%     AVG_DAT{i} = AVG_DAT{i}-bground;
    % Adjust Clims:
    try
    H = prctile(max(AVG_DAT{i}(:,:,10)),90);
    L = prctile(mean(AVG_DAT{i}(:,:,10)),20);
    
    clim = [double(L) double(H)];
    
NormIm(:,:,:,i) = mat2gray(AVG_DAT{i}, clim);
    catch
        i = 2;
            H = prctile(max(AVG_DAT{i}(:,:,10)),90);
    L = prctile(mean(AVG_DAT{i}(:,:,10)),20);
    
    clim = [double(L) double(H)];
    
NormIm(:,:,:,i) = mat2gray(AVG_DAT{i}, clim);
    end
end


figure(); for i = 7:33; IM(:,:,:) = NormIm(:,:,i,:); imagesc(IM); pause(0.05); end

NAME = strcat('DAY_',num2str(ii));

%% Write VIDEO
v = VideoWriter(NAME);
v.Quality = 100;
v.FrameRate = 30;

open(v)
for i = 2:size(NormIm(:,:,:,:),3)
    
    IM(:,:,:) = NormIm(:,:,i,:);
writeVideo(v,IM)

end
close(v)
clear v;
end


