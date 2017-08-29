function XMASS_song(GG1,GG2,GG3,F,T);

if nargin < 4
   T = 1:size(GG1,2);
   F = 1:size(GG1,1);
elseif nargin < 5
   T = 1:size(GG1,2);
end

Llim = 0.00005;
 Hlim = .05;

im1(:,:,1)=  mat2gray(GG1);
im1(:,:,2)=  mat2gray(GG2);
im1(:,:,3)=  mat2gray(GG3);


RGB1 = imadjust(im1,[Llim Llim Llim; Hlim Hlim Hlim],[]);

% RGB1 = flipdim(RGB1,1);
 %F = flip(F,1);
%RGB1 = RGB1(size(RGB1,1):-1:1,:,:);
figure();
image(T,F,(RGB1));set(gca,'YDir','normal');

title('baseleine to baseline')

