function AVG_MOV = FSA_MakeAvgDffMov_SepMotif(AF);
% Make average Dff movie, Seperate Motif no



filt_rad=10; % gauss filter radius **20
filt_alpha=30; % gauss filter alpha **30
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
  load(fullfile(pwd,fName),'mov_data','mov_data_aligned','vid_times');
DispWrd = strcat('moving to: ',fName);
disp(DispWrd);
catch
DispWrd = strcat('WARNING:  Could not find: ',fName);
warning(DispWrd);
 continue
end
        
% Extract video data:
TERM_LOOP = 0;

for ui = 1:size(mov_data_aligned,2); % Check for bad frames
    if mean(mean(mov_data_aligned(ui).cdata(:,:)))< 40;
        dispword = strcat(' WARNING:  Bad frame(s) detected on frame: ',num2str(ui));
        warning(dispword);
        TERM_LOOP = 1;
        break
    end
end

if TERM_LOOP ==1;
    disp(' skipping to nex mov file...')
    continue
end


% Reformat Movie data:
for i=1:(length(mov_data)-2)
   
   mov_data3 = single(rgb2gray(mov_data(i).cdata));
   mov_data4 = single(rgb2gray(mov_data(i+1).cdata));
   %mov_data5 = single(rgb2gray(mov_data(i+2).cdata));
   mov_data2(:,:,i) = uint8((mov_data3 + mov_data4)/2);

end

  
  test = single(mov_data2);
[rows,columns,frames]=size(test);
  
%%%=============[ FILTER Data ]==============%%%

disp('Gaussian filtering the movie data...');

h=fspecial('gaussian',filt_rad,filt_alpha);
test=imfilter(test,h,'circular','replicate');

disp(['Converting to df/f using the ' num2str(per) ' percentile for the baseline...']);


baseline=repmat(prctile(test,per,3),[1 1 frames]);

% h=fspecial('gaussian',30,10);
% baseline = imfilter(baseline,h,'circular'); % filter baseline


dff = (test.^2-baseline.^2)./baseline;

dff2 = imresize(dff,1);% Scale Data



I = find(diff(vid_times) > .04);
if size(I,1)<1

try
Y = char(realFilenames{iii});
Y = Y(end-3:end);
catch
    disp('Warning- too much song?')
    continue
end


 trialno = {'0001', '0002', '0003'};
    if Y == trialno{1};
AggMov_data_01(:,:,:,counter) = dff2(:,:,1:45);
counter = counter+1;
    elseif Y == trialno{2};
AggMov_data_02(:,:,:,counter2) = dff2(:,:,1:45);
counter2 = counter2+1;

    elseif Y == trialno{3};
AggMov_data_03(:,:,:,counter3) = dff2(:,:,1:45);
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
AVG_MOV{3} = median(AggMov_data_03(:,:,:,:),4);
catch
    disp('No Movies with 0003')
    AVG_MOV{3} = [];
end
end
