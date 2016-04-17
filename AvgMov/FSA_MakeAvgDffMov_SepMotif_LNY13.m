function AVG_MOV = FSA_MakeAvgDffMov_SepMotif(AF);
% Make average Dff movie, Seperate Motif no



filt_rad=20; % gauss filter radius
filt_alpha=30; % gauss filter alpha
lims=3; % contrast prctile limits (i.e. clipping limits lims 1-lims)
cmap=colormap('jet');
per=0; % baseline percentile (0 for min)
counter = 1; counter2 = 1; counter3 = 1; counter4 = 1;
% 
for i = 1:size(AF{1},2)
    if isempty(AF{1}{i});
        continue
    else 
    filenames{counter4} = AF{1}{i};
    realFilenames{counter4} = AF{2}{i};
    counter4 = counter4+1;
    end
end


for  iii = 1:size(filenames,2)

fName = filenames{iii};
%fName = strcat(filenames{iii},'.mat');
    
    
try
  load(fullfile(pwd,fName),'mov_data','vid_times');
DispWrd = strcat('moving to: ',fName);
disp(DispWrd);
catch
DispWrd = strcat('WARNING; Could not find: ',fName);
disp(DispWrd);
 continue
end
        
% Extract video data:
mov_data = mov_data;


% Reformat Movie data:
for i=1:(length(mov_data)-2)
   mov_data3 = single(rgb2gray(mov_data(i).cdata));
   mov_data4 = single(rgb2gray(mov_data(i+1).cdata));
   %mov_data5 = single(rgb2gray(mov_data(i+2).cdata));
   mov_data2(:,:,i) = uint8((mov_data3 + mov_data4)/2);
end

  
  test = (mov_data2);
[rows,columns,frames]=size(test);
  

test=imresize((test),.25);

h=fspecial('disk',50);
bground=imfilter(test,h);
% bground=smooth3(bground,[1 1 5]);
test=test-bground;
h=fspecial('disk',1);
test2=imfilter(test,h);

% Scale videos by pixel value intensities
LinKat =  cat(1,test2(:,1,10));
for i = 2:size(test2,2)
Lin = cat(1,test2(:,i,size(test2,3)));
LinKat = cat(1,LinKat,Lin);
end
H = prctile(LinKat,95)+20; % clip pixel value equal to the 95th percentile value
L = prctile(LinKat,20);% clip the pixel value equal to the bottem 20th percentile value
%%%%%

%%%=============[ FILTER Data ]==============%%%

% disp('Gaussian filtering the movie data...');
% 
% h=fspecial('gaussian',filt_rad,filt_alpha);
% test=imfilter(test,h,'circular');
% 
% disp(['Converting to df/f using the ' num2str(per) ' percentile for the baseline...']);
% 
% baseline=repmat(prctile(test,per,3),[1 1 frames]);
% baseline = baseline./100;
% 
% dff=((test-baseline)./(abs(baseline)).*100;

%
clim = [double(L) double(H)];
    
dff = mat2gray(test2, clim);


dff2 = imresize(dff,4);% Scale Data

 figure(1); for i = 1:40; IM(:,:,:) = dff(:,:,i); imagesc(IM);  pause(0.050); end;

I = find(diff(vid_times) > .04);
if size(I,1)<1

Y = char(realFilenames{iii});
Y = Y(end-3:end);

 trialno = {'0001', '0002', '0003'};
    if Y == trialno{1};
AggMov_data_01(:,:,:,counter) = dff2(:,:,1:40);
counter = counter+1;
    elseif Y == trialno{2};
AggMov_data_02(:,:,:,counter2) = dff2(:,:,1:40);
counter2 = counter2+1;

    elseif Y == trialno{3};
AggMov_data_03(:,:,:,counter3) = dff2(:,:,1:40);
counter3 = counter3+1;

    else
        disp('WARNING does not sort')
    end
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
