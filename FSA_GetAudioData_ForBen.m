function FSA_GetAudioData_ForBen




  mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
  mov_listing={mov_listing(:).name};
  filenames=mov_listing;
Here = pwd;

for  iii = 1:length(mov_listing)

   cd(Here);
  [path,file,ext]=fileparts(filenames{iii});
  
  load(fullfile(pwd,mov_listing{iii}),'mic_data');
  audio.filename = file;
  AudioData{iii} = mic_data(:,1);
  
 
end

save('AudioDataFiles', 'AudioData');


