function [im1_rgb norm_max_proj] = FS_plot_allpxs(MOV_DATA,varargin)
%FS_plot_allpxs uses the center of mass (df/f here) (COM) across time to define


% for i = 1:size(MOV_DATA,2)
% 		mov_data(:,:,i) = double(rgb2gray(MOV_DATA(i).cdata(:,:,:,:)));
% end

try
for i = 1:size(MOV_DATA,2);
		mov_data(:,:,i) = double(rgb2gray((MOV_DATA(i).cdata(:,:,:,:))));
end
MOV_DATA	= mov_data;
catch
    mov_data = MOV_DATA;

end

	%clear MOV_DATA;

 %MOV_DATA	= mov_data(:,:,7:end-10);


nparams=length(varargin);

filt_rad=25; % gauss filter radius
filt_alpha=30; % gauss filter alpha
lims=3; % contrast prctile limits (i.e. clipping limits lims 1-lims)
cmap=colormap('jet');
per=5; % baseline percentile (0 for min)
bgcolor=[ .75 .75 .75 ]; % rgb values for axis background
time_select=0;
startT = 1;
stopT = size(mov_data,2);


if mod(nparams,2)>0
	error('Parameters must be specified as parameter/value pairs');
end

for i=1:2:nparams
	switch lower(varargin{i})
		case 'baseline'
			baseline=varargin{i+1};
		case 'filt_rad'
			filt_rad=varargin{i+1};
		case 'trim_per'
			trim_per=varargin{i+1};
		case 'filt_alpha'
			filt_alpha=varargin{i+1};
		case 'per'
			per=varargin{i+1};
		case 'lims'
			lims=varargin{i+1};
		case 'fs'
			fs=varargin{i+1};
		case 'cmap'
			cmap=varargin{i+1};
		case 'bgcolor'
			bgcolor=varargin{i+1};
		case 'time_select'
			time_select=varargin{i+1};
		case 'sono_cmap'
			sono_cmap=varargin{i+1};
        case 'start'
			startT=varargin{i+1};
        case 'stop'
			stopT=varargin{i+1};
	end
end




[rows,columns,frames]=size(MOV_DATA);

disp('Gaussian filtering the movie data...');

h=fspecial('gaussian',filt_rad,filt_alpha);
MOV_DATA=imfilter(MOV_DATA,h,'circular');

disp(['Converting to df/f using the ' num2str(per) ' percentile for the baseline...']);

baseline=repmat(prctile(MOV_DATA,per,3),[1 1 frames]);

dff=((MOV_DATA.^4-baseline.^4)./(baseline)).*100;
dff = dff;

% take the center of mass across dim 3 (time) for each point in space
disp('Computing the center of mass...');

com_idx=zeros(1,1,frames);

for i=1:frames
	com_idx(:,:,i)=i;
end

com_idx=repmat(com_idx,[rows columns 1]);

mass=sum(dff,3);
com_dff=sum((dff.*com_idx),3)./mass;

max_proj=max(dff,[],3);

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
 cbar_idxs=linspace(0,size(cmap,1),1e3);


% Single Use Plotting
 imwrite(im1_rgb,'Filename.png','Alpha',norm_max_proj);
 I = imread('Filename.png', 'BackgroundColor',[0 0 0]);
figure();  imshow(I);
 imwrite(I, 'NewFilename.jpg');
