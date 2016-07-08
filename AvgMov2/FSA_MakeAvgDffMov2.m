function AVG_MOV = FSA_MakeAvgDffMov()
% Make average Dff movie



filt_rad=1; % gauss filter radius
filt_alpha=3; % gauss filter alpha
lims=3; % contrast prctile limits (i.e. clipping limits lims 1-lims)
cmap=colormap('jet');
per=0; % baseline percentile (0 for min)
counter = 1;


mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
mov_listing={mov_listing(:).name};
filenames=mov_listing;


for  iii = 1:length(mov_listing)

    [path,file,ext]=fileparts(filenames{iii});

  load(fullfile(pwd,mov_listing{iii}),'mov_data','mov_data_aligned','vid_times');
DispWrd = strcat('moving to: ', file);
disp(DispWrd);

% Extract video data:
TERM_LOOP = 0;
for i=1:(length(mov_data)-3)
   mov_data3 = single(rgb2gray(mov_data(i).cdata));
   mov_data4 = single(rgb2gray(mov_data(i+1).cdata));
   mov_data5 = single(rgb2gray(mov_data(i+2).cdata));
      if mean(mean(mov_data4))< 60;
        dispword = strcat(' WARNING:  Bad frame(s) detected on frame: ',num2str(i));
        disp(dispword);
        TERM_LOOP = 1;
        break
      end
   mov_data2(:,:,i) = uint8((mov_data3 + mov_data4 +mov_data5)/3);

end



if TERM_LOOP ==1;
    disp(' skipping to nex mov file...')
    continue
end


 test = single(mov_data2(:,:,1:end));
[rows,columns,frames]=size(test);



  
%%%=============[ FILTER Data ]==============%%%


disp('Gaussian filtering the movie data...');

h=fspecial('gaussian',filt_rad,filt_alpha);
test=imfilter(test,h,'circular','replicate');

disp(['Converting to df/f using the ' num2str(per) ' percentile for the baseline...']);

baseline=repmat(prctile(test,per,3),[1 1 frames]);

h=fspecial('gaussian',10,10);
baseline = imfilter(baseline,h,'circular','replicate'); % filter baseline

dff2 = (test.^2-baseline.^2)./baseline;

h=fspecial('disk',2);
dff2=imfilter(dff2,h); %Clean up


I = find(diff(vid_times) > .04);
if size(I,1)<1
     if size(dff2,3)>48;
AggMov_data(:,:,:,counter) = dff2(:,:,1:48);
     end;
counter = counter+1;
end

clear mov_data; clear mov_data2; clear mov_data3; clear mov_data4; clear vid_times; clear I;
end



AVG_MOV = mean(AggMov_data,4);

end
