function FSA_LW76_rip

% read through ROI files generated by Jeff's old script, and extract the data with the filenames


mov_listing=dir(fullfile(pwd,'*.mat'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;




for i=1:length(mov_listing)

     [path,file,ext]=fileparts(filenames{i});
	         load(fullfile(pwd,mov_listing{i}),'align_detrended','align_frame_idx', 'align_mic_data', 'align_raw','movie_fs','padding','ROI_dat','rois','TEMPLATE');  %load movie data

S = filenames{i}(1:end-4);



Align_detrend{i} = align_detrended;
Align_frame_idx{i} = align_frame_idx;
Align_mic_data{i} = align_mic_data;
Align_raw{i} = align_raw;
roi_dat{i} = ROI_dat;
Filenames{i} = S;
Movie_fs = movie_fs;
Padding = padding
ROIs = rois;
Template = TEMPLATE;


end

save(fullfile(path,[ROI_Data_LW76 '.mat']),'Align_detrend''Align_frame_idx','Align_mic_data','Align_raw','roi_dat','Movie_fs','Padding','ROIs','Template','-append');
