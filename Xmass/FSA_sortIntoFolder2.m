function FSA_sortIntoFolder(input,delay)

% input should be '*.gif'
% delay should bt 0 for gif, and 



  mov_listing=dir(fullfile(pwd,input)); % Get all .mat file names
  mov_listing={mov_listing(:).name};
  filenames=mov_listing;
Here = pwd;

for  iii = 1:length(mov_listing)

   cd(Here);
  [path,file,ext]=fileparts(filenames{iii});

  cd('../')


<<<<<<< Updated upstream

 Fname = strcat(file,'.mat');
=======
 
 Fname = strcat(file(1:end-delay),'.mat');
>>>>>>> Stashed changes
 copyfile(Fname,Here);
end
