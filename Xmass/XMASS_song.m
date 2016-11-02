% Scrap XMASS song





Llim = 0.02;
Hlim = 0.4;

% for i = 1:3;
%     
%     im(:,:,i) = mat2gray(G1{i}); %sleepless
%     im2(:,:,i) = mat2gray(G{i+1});  % with sleep
% end; 


G{1} = test01
G{2} = test02


im1(:,:,1)=  mat2gray(G{1});
im1(:,:,2)=  mat2gray(G{2});
im1(:,:,3)=  mat2gray(G{2});


% im2(:,:,1)=  mat2gray(G{2});
% im2(:,:,2)=  mat2gray(G1{5});
% im2(:,:,3)=  mat2gray(G1{5});
% 
% im3(:,:,1)=  mat2gray(AVG_1);
% im3(:,:,2)=  mat2gray(AVG_2);
% im3(:,:,3)=  mat2gray(AVG_2);




figure(); 



RGB1 = imadjust(im1,[Llim Llim Llim; Hlim Hlim Hlim],[]);
% RGB2 = imadjust(im2,[Llim Llim Llim; Hlim Hlim Hlim],[]);
% RGB3 = imadjust(im3,[Llim Llim Llim; Hlim Hlim Hlim],[]);





figure();

imagesc(RGB1);
title('baseleine to baseline')

% subplot(3,1,2);
% image(flipdim(RGB2,1)); ylim([700, 1000]);
% title('baseleine to interrupt')
% 
% subplot(3,1,3);
% image(flipdim(RGB3,1)); ylim([700, 1000]);
% title('interrupt  to interrupt')
% 
% figure(); 
% for i = 1:4;
% subplot(4,1,i)
% image(flipdim(G{i},1)); ylim([700, 1000]);
% end;
% 
% figure(); 
% for i = 1:6;
% subplot(6,1,i)
% image(flipdim(G1{i},1)); ylim([700, 1000]);
% end;

