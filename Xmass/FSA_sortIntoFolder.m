function FSA_sortIntoFolder




  mov_listing=dir(fullfile(pwd,'*.jpg')); % Get all .mat file names
  mov_listing={mov_listing(:).name};
  filenames=mov_listing;
Here = pwd;

for  iii = 1:length(mov_listing)

   cd(Here);
  [path,file,ext]=fileparts(filenames{iii});

  cd('../')


 
 Fname = strcat(file,'.mat');
 copyfile(Fname,Here);
end
