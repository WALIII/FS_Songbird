
function FSA_AvgMov_Allpix(MOV_DATA)

% Takes data from FSA_MakeAvgDffMov)


lims=3; % contrast prctile limits (i.e. clipping limits lims 1-lims)
cmap=colormap('jet');

MOV_DATA = double(MOV_DATA(:,:,15:40));


[rows,columns,frames]=size(MOV_DATA);

dff = MOV_DATA; 

disp('Computing the center of mass...');

com_idx=zeros(1,1,frames);

for i=1:frames
	com_idx(:,:,i)=i;
end

com_idx=repmat(com_idx,[rows columns 1]);

mass=sum(dff,3);
com_dff=sum((dff.*com_idx),3)./mass;

max_proj=std(dff,[],3);

%

disp('Creating images...');

clims(1)=prctile(max_proj(:),lims);
clims(2)=prctile(max_proj(:),100-lims);

norm_max_proj=min(max_proj,clims(2));
norm_max_proj=max(norm_max_proj-clims(1),0);
norm_max_proj=norm_max_proj./(clims(2)-clims(1));

% map to [0,1] for ind2rgb

clims(1)=min(com_dff(:));
clims(2)=max(com_dff(:));

norm_dff=min(com_dff,clims(2)); % clip to max
norm_dff=max(norm_dff-clims(1),0); % clip min
norm_dff=norm_dff./(clims(2)-clims(1)); % normalize to [0,1]


idx_img=round(norm_dff.*size(cmap,1));
im1_rgb=ind2rgb(idx_img,cmap);
%
% [s,f,t]=fb_pretty_sonogram(filtfilt(b,a,double(MIC_DATA)),fs,'n',2048,'overlap',2040,'nfft',4096,'low',1,'zeropad',0);
 cbar_idxs=linspace(0,size(cmap,1),1e3);


% Single Use Plotting
 imwrite(im1_rgb,'Filename.png','Alpha',norm_max_proj);
 I = imread('Filename.png', 'BackgroundColor',[0 0 0]);
 imwrite(I, 'NewFilename.jpg')