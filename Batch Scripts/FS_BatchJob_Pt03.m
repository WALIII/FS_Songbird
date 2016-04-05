function FS_BatchJob_Pt02(ROIS)
% FS_BatchJob_Pt03.m

% Part one aligns data to song.
% Part two performs within trial, within day and across-day motion correction
% * Part three performs ROI extraction



% Run thorough 5 Day Longitudinal studies, and directory and:
%  -- Performs ROI extraction
%  -- Makes sample XMASS tree image

% Run in Root (animal ID) folder


%   Created: 2016/03/16
%   By: WALIII
%   Updated: 2016/03/16
%   By: WALIII


%%========================================%%



% FIRST- select ROI mape and template using FS_Image_ROI


START_DIR_ROOT = pwd;

% Get a list of all files and folders in this folder.
files = dir(START_DIR_ROOT)
files(1:2) = [] % Exclude parent directories.
dirFlags = [files.isdir]% Get a logical vector that tells which is a directory.
subFolders = files(dirFlags)% Extract only those that are directories.


nextDir = strcat(subFolders(1).name,'/mat/extraction/mov')
% try
  cd(nextDir)



  for i = 1:length(subFolders)
         cd(START_DIR_ROOT);
            clear nextDir; clear mov_listing; clear filenames;

      try % in case there are Directories you can't enter...
        nextDir = strcat(subFolders(i).name,'/mat/extraction/mov')
          cd(nextDir);
      catch
         disp(' could not enter DIR...')
      end



roi_trial = FS_Plot_ROI_Batch(ROIS,'mov_mode',3); % Plot ROIs

  roi_ave(1).rois = roi_trial;

  clear roi_trial;
  end

  save(fullfile(START_DIR_ROOT,['ROI_DATA' '.mat']),'roi_ave');



  send_text_message('617-529-0762','Verizon', ...
           'Calculation Complete','FS_BatchJob_Pt03 (ROI Selection) has completed')
