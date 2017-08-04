function XMASS_song(GG1,GG2,GG3)


Llim = 0.z5;
 Hlim = .70;

im1(:,:,1)=  mat2gray(GG1);
im1(:,:,2)=  mat2gray(GG2);
im1(:,:,3)=  mat2gray(GG3);


RGB1 = imadjust(im1,[Llim Llim Llim; Hlim Hlim Hlim],[]);


figure();
image((RGB1)); 
title('baseleine to baseline')

