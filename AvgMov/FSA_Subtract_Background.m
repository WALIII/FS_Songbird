function [dff] = FSA_Subtract_Background(mov_data,filt_rad,filt_alpha,scale);
% Subtract Background from FreedomScope Movies


% Reformat Movie data:
mov_data2 = FSA_Format_Mov(mov_data, 1)

    test = single(mov_data2);
  [rows,columns,frames]=size(test);


  % Filter Data
  disp('Gaussian filtering the movie data...');

  h=fspecial('gaussian',filt_rad,filt_alpha);
  test=imfilter(test,h,'circular');

  disp(['Converting to df/f using the ' num2str(per) ' percentile for the baseline...']);

  baseline=repmat(prctile(test,per,3),[1 1 frames]);
  dff = (test.^2-baseline.^2)./baseline;
  dff = imresize(dff,1);% Scale Data
