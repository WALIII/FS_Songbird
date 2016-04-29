function [dff] = FSA_Subtract_Background(mov_data,filt_rad,filt_alpha,scale);




% Reformat Movie data:
for i=1:(length(mov_data)-2)
   mov_data3 = single(rgb2gray(mov_data(i).cdata));
   mov_data4 = single(rgb2gray(mov_data(i+1).cdata));
   mov_data2(:,:,i) = uint8((mov_data3 + mov_data4)/2);
end

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
