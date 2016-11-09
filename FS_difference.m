function FS_difference(condition1, condition2)
%





% Normalize matrixes

axisL = -1000;
axisH = 1000;
figure();
try

normA = condition1 - min(condition1(:));
normA = normA ./ max(normA(:));

normB = condition2 - min(condition2(:));
normB = normB ./ max(normB(:));


% subplot(1,2,1)
% hold on;
% imagesc((std(C_mov2,[],3)-std(C_mov1,[],3)),[axisL axisH]); axis off; title('First vs Middle motif, difference image'); 

% axisL = -10;
% axisH = 10;
%      
 subplot(1,2,1)
imagesc((std(condition1.^2,[],3)-std(condition2.^2,[],3)),[axisL axisH]); axis off; title('COndition 01 (red) vs Condition 02 (blue)'); 

catch
    disp('images detected');
     subplot(1,2,1)
imagesc(double(condition1)-double(condition2),[axisL axisH]); axis off; title('COndition 01 (red) vs Condition 02 (blue)'); 
end
    
c = colormap(fireice); 
colorbar('Ticks',[axisL*0.8,axisH*0.8],...
         'TickLabels',{'Condition 02','Condition 01'})
     
    

Llim = 0.01;
Hlim = 0.6;

try
G{1} = std(normA.^2,[],3)
G{2} = std(normB.^2,[],3)
catch
G{1} = double(condition1);
G{2} = double(condition2);
end

clear im1;

im1(:,:,1)=  mat2gray(G{1}); %R
im1(:,:,2)=  mat2gray(G{2}); %G
im1(:,:,3)=  mat2gray(G{2}); %B



clear RGB1

RGB1 = imadjust(im1,[Llim Llim Llim; Hlim Hlim Hlim],[]);
% RGB2 = imadjust(im2,[Llim Llim Llim; Hlim Hlim Hlim],[]);
% RGB3 = imadjust(im3,[Llim Llim Llim; Hlim Hlim Hlim],[]);


 subplot(1,2,2);
image(RGB1); %ylim([700, 1000]);
title('Condition 1 (Red), vs Condition 2 (Blue)')

     
     
     
