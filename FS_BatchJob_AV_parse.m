function FS_BatchJob_AV_parse()
% FS_BatchJob_AV_Parse.m


%   Created: 2016/09/29
%   By: WALIII
%   Updated: 2016/09/29
%   By: WALIII



% [nblanks formatstring]=fb_progressbar(100);
% fprintf(1,['Progress:  ' blanks(nblanks)]);


% Root is where the script is run...
START_DIR_ROOT = pwd;

% myfile = '/template/template_data.mat';
[parentdir,~,~]=fileparts(START_DIR_ROOT);

% load(fullfile(START_DIR_ROOT,myfile),'TEMPLATE');


% Get a list of all files and folders in this folder.

files = dir(START_DIR_ROOT)
files(1:2) = [] % Exclude parent directories.
dirFlags = [files.isdir]% Get a logical vector that tells which is a directory.
subFolders = files(dirFlags)% Extract only those that are directories.


for i = 1:length(subFolders)
  clear nextDir
  nextDir = subFolders(i).name

  
%   if exist('mat') == 7;
%       disp( 'Already extracted-' )
%       
% send_text_message('617-529-0762','Verizon', ...
%          'Error','mat file detected- skipped dir')
% 
%       continue
%   else
      
      
try
    cd(nextDir)
catch
  disp('could not enter file...')
end


    
    
try
FS_AV_Parse;
catch
  disp('could not perform function')
%   send_text_message('617-529-0762','Verizon', ...
%          'ERROR','Could not perform function')
end
disp('Processing for day X moving to the next day')
cd(START_DIR_ROOT)
  end
% end

send_text_message('617-529-0762','Verizon', ...
         'Calculation Complete','FS_BatchJob_Pt01 has completed')
