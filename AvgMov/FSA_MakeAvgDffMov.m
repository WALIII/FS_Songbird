function AVG_MOV = FSA_MakeAvgDffMov()
% Make average Dff movie



filt_rad=20; % gauss filter radius
filt_alpha=30; % gauss filter alpha
lims=3; % contrast prctile limits (i.e. clipping limits lims 1-lims)
cmap=colormap('jet');
per=0; % baseline percentile (0 for min)

mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
mov_listing={mov_listing(:).name};
filenames=mov_listing;


for  iii = 1:length(mov_listing)

    [path,file,ext]=fileparts(filenames{iii});

  load(fullfile(pwd,mov_listing{iii}),'mov_data_aligned');
DispWrd = strcat('moving to: ', file);
disp(DispWrd);

% Extract video data:
mov_data = mov_data_aligned;
[rows,columns,frames]=size(mov_data);

% Reformat Movie data:
  for i=1:(length(mov_data)-2)
     mov_data3 = mov_data(i).cdata;
     mov_data4 = mov_data(i+1).cdata;
     mov_data2(:,:,i) = (mov_data3 + mov_data4)/2;
  end

test = imresize((mov_data2),.25);% Scale Data

%%%=============[ FILTER Data ]==============%%%

disp('Gaussian filtering the movie data...');

h=fspecial('gaussian',filt_rad,filt_alpha);
test=imfilter(test,h,'circular');

disp(['Converting to df/f using the ' num2str(per) ' percentile for the baseline...']);

baseline=repmat(prctile(MOV_DATA,per,3),[1 1 frames]);

dff=((MOV_DATA-baseline)./(baseline)).*100;

%


AggMov_data(:,:,:,iii) = dff(:,:,1:50);

clear mov_data; clear mov_data2; clear mov_data3; clear mov_data4;
end



AVG_MOV = mean(AggMov_data(:,:,:,iii),4);

end
