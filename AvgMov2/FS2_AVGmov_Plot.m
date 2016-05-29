
function FS2_AVGmov_Plot(ROI_dat,MOV)
% Extract data from avg movies ( designed for LW76, for the NN paper)




%% Starting Variables
motif = 1;
Scale = 2;
sono_colormap='hot';
baseline=3;
n = 1; % How much to interpolate by?
ave_fs=30*n; % multiply by a variable 'n' if you want to interpolate
save_dir='roi';
template=[];
fs=48000;
per=2;
max_row=5;
min_f=0;
max_f=9e3;
lims=1;
dff_scale=20;
t_scale=.5;
resize=1;
detrend_traces=0;
crop_correct=0;
counteri = 1;
fs = 48000;







for i=1:size(MOV,2)
clear tmp; clear mov_data; clear frames; clear mic_data; clear ave_time; clear offset2; clear vid_times; clear mov_data_aligned;
warning('off','all')

 mov_data =imresize(MOV{1,i}{motif},2);
ROIS = ROI_dat{i};
colors=eval(['winter(' num2str(length(ROIS.coordinates)) ')']);
 
% Format ROIs
[rows,columns,frames]=size(mov_data);

roi_n=length(ROIS.coordinates);
roi_t=zeros(roi_n,frames);
ave_time=0:1/ave_fs:37;
[path,file,ext]=fileparts(pwd);
save_file=[ file '_roi' ];


	% resize if we want to add this later...



	disp('Computing ROI averages...');

	[nblanks,formatstring]=fb_progressbar(100);
	fprintf(1,['Progress:  ' blanks(nblanks)]);

	% unfortunately we need to for loop by frames, otherwise
	% we'll eat up too much RAM for large movies

	for j=1:roi_n
		fprintf(1,formatstring,round((j/roi_n)*100));

		for k=1:frames

			tmp=mov_data(ROIS.coordinates{j}(:,2),ROIS.coordinates{j}(:,1),k);
			roi_t(j,k)=mean(tmp(:));
		end
	end

	fprintf(1,'\n');

	dff=zeros(size(roi_t));



% roi_ave.analogIO_dat{i} = mic_data;
% roi_ave.analogIO_time{i}= (1:length(mic_data))/fs;
roi_ave.interp_time{i} = ave_time;

%------[ PROCESS ROIs]--------%
% interpolate ROIs to a common timeframe
	for j=1:roi_n
clear tmp; clear dff; clear yy2; clear yy;

timevec = (1:37)/22;
		tmp=roi_t(j,:);
        tmp = tmp(:,(1:37));
		if baseline==0
			norm_fact=mean(tmp,3);
		elseif baseline==1
			norm_fact=median(tmp,3);
		elseif baseline==2
			norm_fact=trimmean(tmp,trim_per,'round',3);
		else
			norm_fact=prctile(tmp,per);
		end

% Interpolate to timescale determined by 'n' paramater (see above)
dff(j,:)=((tmp-norm_fact)./norm_fact).*100;
% yy=interp1(timevec,dff(j,:),ave_time,'spline');
% yy2=interp1(timevec,tmp,ave_time,'spline');
% 
roi_ave.dff{j,counteri}=dff(j,:);
% roi_ave.interp_raw{j, counteri}=yy2;
roi_ave.raw_time{j,counteri} = timevec;
roi_ave.raw_dat{j,counteri} = tmp;

    end
        counteri = counteri+1; % In case we need to skip ROIs due to dropped frames, (instead of using u in the loop)
				roi_ave.filename{i}=strcat('day',num2str(i));

end


save('ave_roi.mat','roi_ave');
disp('Generating average ROI figure...');