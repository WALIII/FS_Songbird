 function FS_Dff(mov_data,varargin)

%run thorough directory and make Background Subtracted Movies in AVI format
% This Script is for 'unprocessed' videos


% WALIII
% For unprocessed videos
% 09.05.15

%% Default Paramaters:
filt_rad=1; % gauss filter radius
filt_alpha=1; % gauss filter alpha
lims=2; % contrast prctile limits (i.e. clipping limits lims 1-lims)
cmap=colormap('jet');
per=0; % baseline percentile (0 for min)
counter = 1;
mat_dir='DFF_MOVIES3';
counter = 1;
sT = 1;
resize = 1;
b = 4;


%% Custom Paramaters
nparams=length(varargin);

if mod(nparams,2)>0
	error('Parameters must be specified as parameter/value pairs');
end

for i=1:2:nparams
	switch lower(varargin{i})
		case 'filt_rad'
			filt_rad=varargin{i+1};
		case 'filt_alpha'
			filt_alpha=varargin{i+1};
		case 'lims'
			lims=varargin{i+1};
		case 'baseline'
			per=varargin{i+1};
        case 'start'
            sT=varargin{i+1};
        case 'resize'
            resize=varargin{i+1};
            filt_rad= round(filt_rad*resize); % gauss filter radius
            filt_alpha= round(filt_alpha*resize); % gauss filter alpha
	end
end



%if exist(mat_dir,'dir') rmdir(mat_dir,'s'); end
mkdir(mat_dir);


outlier_flag=0;


disp('Creating Dff movies');





try
[mov_data, n]= FS_Format_test(mov_data,1);
mov_data = mov_data(:,:,sT:end);
catch

    [mov_data, n]= FS_Format(mov_data,sT);
end

mov_data = imresize(mov_data,resize);
mov_data = convn(mov_data, single(reshape([1 1 1] / b, 1, 1, [])), 'same');
%%%%
% Detect Bad frames
counter = 1;
TERM_LOOP = 0;
% for i=sT:(size(mov_data,4))
%    mov_data2(:,:,counter) = mov_data(:,:,counter);
% 
%       if mean(mean(mov_data2))< 20;
%         dispword = strcat(' WARNING:  Bad frame(s) detected on frame: ',num2str(i));
%         disp(dispword);
%         TERM_LOOP = 1;
%         break
%       end
%       counter = counter+1;
% end



% if TERM_LOOP ==1;
%     disp(' skipping to nex mov file...')
%     continue
% end

% mov_data3 =  convn(mov_data, single(reshape([1 1 1] / 2, 1, 1, [])), 'same');



[rows,columns,frames]=size(mov_data);

%%%=============[ FILTER Data ]==============%%%

disp('Gaussian filtering the movie data...');

h=fspecial('gaussian',filt_rad,filt_alpha);
mov_data=imfilter(mov_data,h,'circular','replicate');

disp(['Converting to df/f using the ' num2str(per) ' percentile for the baseline...']);

baseline=repmat(prctile(mov_data,per,3),[1 1 frames]);
hfactor = round(30*resize);
h=fspecial('gaussian',hfactor,hfactor);
baseline = imfilter(baseline,h,'circular','replicate'); % filter baseline

mov_data = (mov_data.^2-baseline.^2)./baseline;

h=fspecial('disk',2);
mov_data=imfilter(mov_data,h); %Clean up
% baseline2=mean(tot,3);
% for iii=1:size(tot,3)
%   dff2 =  tot(:,:,iii)./baseline2.*100;
% end

%mov_data = imresize(mov_data,(1/resize));
mov_data = convn(mov_data, single(reshape([1 1 1] / b, 1, 1, [])), 'same');



H = prctile(max(max(mov_data(:,:,:))),70);
L = 2;%prctile(mean(max(dff2(:,:,:))),3); Good to fix lower bound

    clim = [double(L) double(H)];


mov_data = imresize(mov_data,1);
mov_data(:,:,:) = mat2gray(mov_data, clim);


% clear NormIm
% NormIm = NormIm2;
% clear NormIm2;
%figure(1); for  iii = 7:size(NormIm,3);  IM(:,:) = NormIm(:,:,iii); imagesc(IM); pause(0.05); end



%% Write VIDEO


v = VideoWriter('DFF_Vid','MPEG-4');
v.Quality = 30;
v.FrameRate = 30;

open(v)


for ii = 2:size(mov_data,3);
colormap(gray);
IM(:,:) = double(mov_data(:,:,ii));
writeVideo(v,IM)
imagesc(IM);
end
close(v)

figure(1);
imagesc(max(mov_data,[],3));

imwrite(max(mov_data,[],3),strcat('Dff_vid','_max_','.png'));





%% Save Data from aggregate
% Test = TotalX2;
%mov_data = video.frames;
%im_resize = 1;

%save(save_filename,'Test','mov_data','im_resize','-v7.3')
