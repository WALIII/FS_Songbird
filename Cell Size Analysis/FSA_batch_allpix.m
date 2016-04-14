function FSA_batch_allpix()






  mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
  mov_listing={mov_listing(:).name};
  filenames=mov_listing;

mkdir('allpix')

for  iii = 1:length(mov_listing)

  [path,file,ext]=fileparts(filenames{iii});

load(fullfile(pwd,mov_listing{iii}),'mov_data_aligned');
[im1_rgb norm_max_proj] = FS_plot_allpxs(mov_data_aligned);

  imwrite(im1_rgb,'allpix/TempImage.png','Alpha',norm_max_proj);
  I = imread('allpix/TempImage.png', 'BackgroundColor',[0 0 0]);

  NewFilename = strcat('allpix/',file,'.jpg')
  imwrite(I, NewFilename)
  clear I;
end
