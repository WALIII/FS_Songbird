function AVG_MOV = FSA_MakeAvgDffMov_RandMotif();
% Make average Dff movie



filt_rad=20; % gauss filter radius
filt_alpha=30; % gauss filter alpha
lims=3; % contrast prctile limits (i.e. clipping limits lims 1-lims)
cmap=colormap('jet');
per=0; % baseline percentile (0 for min)
counter = 1;


mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
mov_listing={mov_listing(:).name};
filenames=mov_listing;


for  iii = 1:length(mov_listing)

    [path,file,ext]=fileparts(filenames{iii});

  load(fullfile(pwd,mov_listing{iii}),'mov_data_aligned','vid_times');
DispWrd = strcat('moving to: ', file);
disp(DispWrd);

% Extract video data:
mov_data = mov_data_aligned;


% Reformat Movie data:
  for i=1:(length(mov_data)-2)
     mov_data3 = mov_data(i).cdata;
     mov_data4 = mov_data(i+1).cdata;
     mov_data2(:,:,i) = (mov_data3 + mov_data4)/2;
  end
  
  test = single(mov_data2);
[rows,columns,frames]=size(test);
  
%%%=============[ FILTER Data ]==============%%%

disp('Gaussian filtering the movie data...');

h=fspecial('gaussian',filt_rad,filt_alpha);
test=imfilter(test,h,'circular');

disp(['Converting to df/f using the ' num2str(per) ' percentile for the baseline...']);

baseline=repmat(prctile(test,per,3),[1 1 frames]);

dff=((test-baseline)./(baseline+20)).*100;

%
dff2 = imresize(dff,1);% Scale Data

I = find(diff(vid_times) > .04);
if size(I,1)<1
     
AggMov_data(:,:,:,counter) = dff2(:,:,1:50);

counter = counter+1;
end

clear mov_data; clear mov_data2; clear mov_data3; clear mov_data4; clear vid_times; clear I;
end

R = randperm(size(AggMov_data,4));

counterB = 1;
counterC = 1;
for ix = 1:(size(AggMov_data,4))
    if ix<(size(AggMov_data,4))/3
        AggMov_data_A(:,:,:,ix) = AggMov_data(:,:,:,R(ix));
    elseif ix<((size(AggMov_data,4))/3)*2
        AggMov_data_B(:,:,:,counterB) = AggMov_data(:,:,:,R(ix));
        counterB = counterB+1;
    else
        AggMov_data_C(:,:,:,counterC) = AggMov_data(:,:,:,R(ix));
        counterC = counterC +1;
    end
end
    
    
AVG_MOV{1} = mean(AggMov_data_A(:,:,:,:),4);
AVG_MOV{2} = mean(AggMov_data_B(:,:,:,:),4);
AVG_MOV{3} = mean(AggMov_data_C(:,:,:,:),4);


end
