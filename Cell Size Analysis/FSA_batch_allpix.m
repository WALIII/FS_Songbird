function FSA_batch_allpix()






  mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
  mov_listing={mov_listing(:).name};
  filenames=mov_listing;

mkdir('allpix')

for  iii = 1:length(mov_listing)

  [path,file,ext]=fileparts(filenames{iii});

  try
      load(fullfile(pwd,mov_listing{iii}),'video');
      mov_data = video.frames;
  catch
load(fullfile(pwd,mov_listing{iii}),'mov_data');
  end



[im1_rgb norm_max_proj] = FS_plot_allpxs(mov_data,'start',40,'stop',100);

  imwrite(im1_rgb,'allpix/TempImage.png','Alpha',norm_max_proj);
  I = imread('allpix/TempImage.png', 'BackgroundColor',[0 0 0]);

  NewFilename = strcat('allpix/',file,'.jpg')
  imwrite(I, NewFilename)
  clear I;
end
