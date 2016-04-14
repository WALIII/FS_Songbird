function FSA_MakeAvgDffMov()
% Make average Dff movie


mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
mov_listing={mov_listing(:).name};
filenames=mov_listing;


for  iii = 1:length(mov_listing)

    [path,file,ext]=fileparts(filenames{iii});

  load(fullfile(pwd,mov_listing{iii}),'mov_data_aligned');


  mov_data = mov_data_aligned;

  for i=1:(length(mov_data)-2)
     mov_data3 = single(rgb2gray(mov_data(i).cdata));
     mov_data4 = single(rgb2gray(mov_data(i+1).cdata));
     %mov_data5 = single(rgb2gray(mov_data(i+2).cdata));
     mov_data2(:,:,i) = uint8((mov_data3 + mov_data4)/2);
  end

mov_data2 = =imresize((mov_data2),.25);

AggMov_data(:,:,:,iii) = mov_data2(:,:,1:50);

clear mov_data; clear mov_data2; clear mov_data3; clear mov_data4;
end



AVG_MOV = mean(AggMov_data(:,:,:,iii),4)

end
