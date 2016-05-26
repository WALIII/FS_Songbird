function AVG_MOV = FSA_MakeAvgDffMov(varargin);
% Make average Dff movie. By default, will make an averaged video of all movies in the .mat directory.

% EXAMPLE
% >> FSA_MakeAvgDffMov('Adjusted_Filenames',AF)


% Default Paramaters
filt_rad=20; % gauss filter radius
filt_alpha=30; % gauss filter alpha
cmap=colormap('jet'); % colormap
per=0; % baseline percentile (0 for min)
counter = 1;%\
scale = 1; % to resize/downsample the data ( i.e. 0.25 for 1/4 the image)
AF_case = 0; % Are we extracting by motif?
MOTIF = 0;

% User inputs
if mod(nparams,2)>0
	error('Parameters must be specified as parameter/value pairs');
end

for i=1:2:nparams
	switch lower(varargin{i})
		case 'filt_rad'
			filt_rad=varargin{i+1};
		case 'filt_alpha'
			filt_alpha=varargin{i+1};
		case 'percentile'
			per=varargin{i+1};
    case 'motif'
      MOTIF=varargin{i+1}; % three cases, 1 = '123',2 = 'random' 3 = 'FML'
		case 'Adjusted_Filenames'
			AF=varargin{i+1};
      AF_case = 1;
		case 'motif_random'
			MotifOrder=varargin{i+1};
    case 'DownSample'
        scale=varargin{i+1};
	end
end

% Adjust Filenames
if AF_case ==1;
for i = 1:size(AF{1},2)
    if isempty(AF{1}{i});
        continue
    else
    filenames{counter4} = AF{1}{i};
    realFilenames{counter4} = AF{2}{i};
    counter4 = counter4+1;
    end
end
else
mov_listing=dir(fullfile(pwd,'*.mat')); % Get all .mat file names
mov_listing={mov_listing(:).name};
filenames=mov_listing;
end


for  iii = 1:length(mov_listing)

    [path,file,ext]=fileparts(filenames{iii});
    load(fullfile(pwd,mov_listing{iii}),'mov_data','mov_data_aligned','vid_times');
DispWrd = strcat('moving to: ', file);
disp(DispWrd);


% Scrub Data
TERM_LOOP = 1;

% Scrub data for bad pixels.
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


% Extract video data:
dff = FSA_Subtract_Background(mov_data,filt_rad,filt_alpha,scale);


% Screen for bad frames.
I = find(diff(vid_times) > .04);
if size(I,1)<1
AggMov_data(:,:,:,counter) = dff(:,:,1:50);
counter = counter+1;
end
 clear vid_times; clear I;
end


AVG_MOV = mean(AggMov_data,4);

end
