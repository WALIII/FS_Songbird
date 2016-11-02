% Scrap XMASS song





Llim = 0.01;
Hlim = 0.1;

% for i = 1:3;
%     
%     im(:,:,i) = mat2gray(G1{i}); %sleepless
%     im2(:,:,i) = mat2gray(G{i+1});  % with sleep
% end; 


AVG_1 = (G{1} + G{2} + G{3} + G{4})/4;
AVG_2 = (G1{1} + G1{2} + G1{3} + G1{4}+ G1{5}+ G1{6})/6;


im1(:,:,1)=  mat2gray(G{3});
im1(:,:,2)=  mat2gray(G{4});
im1(:,:,3)=  mat2gray(G{4});


im2(:,:,1)=  mat2gray(G{2});
im2(:,:,2)=  mat2gray(G1{5});
im2(:,:,3)=  mat2gray(G1{5});

im3(:,:,1)=  mat2gray(AVG_1);
im3(:,:,2)=  mat2gray(AVG_2);
im3(:,:,3)=  mat2gray(AVG_2);




figure(); 



RGB1 = imadjust(im1,[Llim Llim Llim; Hlim Hlim Hlim],[]);
RGB2 = imadjust(im2,[Llim Llim Llim; Hlim Hlim Hlim],[]);
RGB3 = imadjust(im3,[Llim Llim Llim; Hlim Hlim Hlim],[]);





figure();
subplot(3,1,1);
image(flipdim(RGB1,1)); ylim([700, 1000]);
title('baseleine to baseline')

subplot(3,1,2);
image(flipdim(RGB2,1)); ylim([700, 1000]);
title('baseleine to interrupt')

subplot(3,1,3);
image(flipdim(RGB3,1)); ylim([700, 1000]);
title('interrupt  to interrupt')

figure(); 
for i = 1:4;
subplot(4,1,i)
image(flipdim(G{i},1)); ylim([700, 1000]);
end;

figure(); 
for i = 1:6;
subplot(6,1,i)
image(flipdim(G1{i},1)); ylim([700, 1000]);
end;

