function AVG_MOV = FSA_MakeAvgDffMov_SepMotif_LW76
% Make average Dff movie, Seperate Motif no



filt_rad=20; % gauss filter radius
filt_alpha=30; % gauss filter alpha
lims=3; % contrast prctile limits (i.e. clipping limits lims 1-lims)
cmap=colormap('jet');
per=0; % baseline percentile (0 for min)
counter = 1; counter2 = 1; counter3 = 1; counter4 = 1;
% 

mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
mov_listing={mov_listing(:).name};
filenames=mov_listing;


for  iii = 1:length(mov_listing)

    [path,file,ext]=fileparts(filenames{iii});

  load(fullfile(pwd,mov_listing{iii}),'mov_data');
DispWrd = strcat('moving to: ', file);
disp(DispWrd);
   
        

  
  test = single(mov_data);
  test = imresize(test,.5);% Scale Data
[rows,columns,frames]=size(test);
  
%%%=============[ FILTER Data ]==============%%%

disp('Gaussian filtering the movie data...');

h=fspecial('gaussian',filt_rad,filt_alpha);
test=imfilter(test,h,'circular');

disp(['Converting to df/f using the ' num2str(per) ' percentile for the baseline...']);

baseline=repmat(prctile(test,per,3),[1 1 frames]);

dff2=((test-baseline)./(baseline+20)).*100;

%

try
Y = char(filenames{iii});
Y = Y(end-7:end-4);
catch
    disp('Warning- too much song?')
    continue
end


 trialno = {'0001', '0002', '0003'};
    if Y == trialno{1};
AggMov_data_01(:,:,:,counter) = dff2(:,:,1:37);
counter = counter+1;
    elseif Y == trialno{2};
AggMov_data_02(:,:,:,counter2) = dff2(:,:,1:37);
counter2 = counter2+1;

    elseif Y == trialno{3};
AggMov_data_03(:,:,:,counter3) = dff2(:,:,1:37);
counter3 = counter3+1;

    else
        disp('WARNING does not sort')
    end


clear mov_data; clear mov_data2; clear mov_data3; clear mov_data4; clear vid_times; clear I;


end


try
AVG_MOV{1} = mean(AggMov_data_01(:,:,:,:),4);
catch
    disp('No Movies with 0001')
    AVG_MOV{1} = [];
end

try
AVG_MOV{2} = mean(AggMov_data_02(:,:,:,:),4);
catch
    disp('No Movies with 0002')
    AVG_MOV{2} = [];
end

try
AVG_MOV{3} = mean(AggMov_data_03(:,:,:,:),4);
catch
    disp('No Movies with 0003')
    AVG_MOV{3} = [];
end
end
