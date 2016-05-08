function FS_Batch_Dff(Hi,Lo)

  %run thorough directory and make Background Subtracted Movies in AVI format
  % This Script is for 'unprocessed' videos


  % WALIII
  % For unprocessed videos
  % 05.08.16

% Create directory for Dff movies and images.
  mat_dir='DFF_MOVIES';
  counter = 1;

  if exist(mat_dir,'dir') rmdir(mat_dir,'s'); end
  mkdir(mat_dir);


  outlier_flag=0;
  if nargin<1 | isempty(DIR), DIR=pwd; end
  mov_listing=dir(fullfile(DIR,'*.mat'));
  mov_listing={mov_listing(:).name};
  filenames=mov_listing;


  disp('Creating Dff movies');

  [nblanks formatstring]=fb_progressbar(100);
  fprintf(1,['Progress:  ' blanks(nblanks)]);

  for i=1:length(mov_listing)
            [path,file,ext]=fileparts(filenames{i});
  	           fprintf(1,formatstring,round((i/length(mov_listing))*100));

               load(fullfile(DIR,mov_listing{i}),'video','mov_data');
               save_filename=[ fullfile(mat_dir,file) ];
               try
                 mov_data = video.frames(1:LastFrame);
               catch
                 mov_data = mov_data;
               end

mov_data = FSA_Format_Mov(mov_data)


[dff] = FSA_Subtract_Background(mov_data,filt_rad,filt_alpha,scale);



    H = prctile(mean(max(dff(:,:,:))),Hi);
    L = prctile(mean(max(dff(:,:,:))),Lo);

        clim = [double(L) double(H)];
        NormIm(:,:,:) = mat2gray(dff2, clim);

    v = VideoWriter(save_filename);
    v.Quality = 30;
    v.FrameRate = 30;


    open(v)
    for ii = 2:size(NormIm,3);
      figure(1);
      colormap(gray);
      IM(:,:) = NormIm(:,:,ii);
      writeVideo(v,IM)
      imagesc(IM);
    end
    close(v)
    clear v;

    imwrite(max(NormIm,[],3),strcat(save_filename,'_MAX','.png'));
    imwrite(std(NormIm,[],3),strcat(save_filename,'_STD','.png'));
    
  end
