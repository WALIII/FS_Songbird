function FS_Align_RGB(AVG_DAT)
% Align RGB movies across days


MaxProj(:,:) = max(AVG_DAT{1},[],3);
MinProj(:,:) = min(AVG_DAT{1},[],3);

for i = 1:3;

    for ii = 1:50
           [temp Greg] = dftregistration(fft2(MinProj(:,:,1)),fft2(AVG_DAT{i}(:,:,ii)),100);
           AVG_DAT_Aligned{i}(:,:,ii) = abs(ifft2(Greg)); %% keep this data propogating through function....

    end
end

% Display image
for i = 1:3
    H = prctile(max(AVG_DAT_Aligned{i}(:,:,10)),85);
    L = prctile(mean(AVG_DAT_Aligned{i}(:,:,10)),30);
    
    clim = [double(L) double(H)];
    
NormIm(:,:,:,i) = mat2gray(AVG_DAT_Aligned{i}, clim);
end


figure(); for i = 4:50; IM(:,:,:) = NormIm(:,:,i,:); imagesc(IM); pause(0.05); end

