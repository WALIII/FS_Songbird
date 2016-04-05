function FS_BatchJob_Pt02()
% FS_BatchJob_Pt02.m

% Part one aligns data to song.
% * Part two performs within trial, within day and across-day motion correction
% Part three performs ROI extraction



% Run thorough 5 Day Longitudinal studies, and directory and:
%  -- Within session alignment ** not in place
%  -- Within day image alignment (using selected  MAX projection )
%  -- Across day image alignment (using selected  MAX projection )
%  -- Create STD and MAX images ( in order to manually check local alignment, and make XMASS tree images)


% Run in Root (animal ID) folder


%   Created: 2016/03/14
%   By: WALIII
%   Updated: 2016/03/15
%   By: WALIII


%%========================================%%




START_DIR_ROOT = pwd;

% Get a list of all files and folders in this folder.
files = dir(START_DIR_ROOT)
files(1:2) = [] % Exclude parent directories.
dirFlags = [files.isdir]% Get a logical vector that tells which is a directory.
subFolders = files(dirFlags)% Extract only those that are directories.


%=========[  Get alignment info from day one ]==========%
% nextDir = strcat(subFolders(1).name,'/mat/extraction/mov')
% % try
%   cd(nextDir)


mov_listing=dir(fullfile(pwd,'*.mat'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;

disp('Loading in data from Day One');
% 
% for i=1:length(mov_listing) % for all .mat files in directory,
% clear video;
% 
%         [path,file,ext]=fileparts(filenames{i});
%             load(fullfile(pwd,mov_listing{i}),'mov_data');
% 
%   for ii = 1:size(mov_data,2)
%       mov_data2(:,:,ii) = rgb2gray(mov_data(ii).cdata(:,:,:,:)); % convert to
%   end
% 
%             MaxProj(:,:,i) = max(mov_data2,[],3);
% 
% 
% clear mov_data2; clear mov_data;
% end
% 





disp('Applying NO Motion Correction transform to all trials on all days');
[nblanks formatstring]=fb_progressbar(100);
fprintf(1,['Progress:  ' blanks(nblanks)]);

for i = 1:length(subFolders)
    cd(START_DIR_ROOT);
  clear nextDir; clear mov_listing; clear filenames;

try % in case there are Directories you can't enter...
  nextDir = strcat(subFolders(i).name,'/mat/extraction/mov')
catch
  disp(' could not enter DIR...')
end

% Make subdirectories:
  MaxDir = strcat(nextDir,'/MAX')
  StdDir = strcat(nextDir,'/STD')
  mkdir(MaxDir);
  mkdir(StdDir);
% Go to new Dir:
    cd(nextDir)
  mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
  mov_listing={mov_listing(:).name};
  filenames=mov_listing;


  for iii=1:length(mov_listing)

        [path,file,ext]=fileparts(filenames{iii});
	         load(fullfile(pwd,mov_listing{iii}),'mov_data');  %load movie data

        for ii = 1:size(mov_data,2) % format movie data
          mov_data2(:,:,ii) = rgb2gray(mov_data(ii).cdata(:,:,:,:));
          mov_data3(ii).cdata(:,:,:) =  rgb2gray(mov_data(ii).cdata(:,:,:,:));
        end

         % Clear buffer
mov_data_aligned = [];
save(fullfile(path,[file '.mat']),'mov_data_aligned','-append');

mov_data_aligned = mov_data3; % this will overwirte motion correction
        clear mov_data;
        clear mov_data2;
        clear mov_data3;



save(fullfile(path,[file '.mat']),'mov_data_aligned','-append');



FS_Write_IM(file,mov_data_aligned)

    clear mov_data_aligned;
%FS_BATCH_DFF_STD_Image(pwd,1); % takes the
%catch; disp('could not enter file') end;

  end
   cd(START_DIR_ROOT)
end


send_text_message('617-529-0762','Verizon', ...
         'Calculation Complete','FS_BatchJob_Pt02 has completed')
