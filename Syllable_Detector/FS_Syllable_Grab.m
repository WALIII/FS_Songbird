function FS_Syllable_Grab()
% FS_Syllable_Grab will work though s single day's data, and aggregate all
% The song and non-song data, as well as relevant paramaters for Ben's syllable
% detector. Run in 'extraction' for FreedomScope Bir's analysis pipeline

% d07.14.16
% WAL3


%Get Bird ID
G = pwd;
k = strfind(G,'/');
BirdID = G(k(5)+1:k(6)-1);


% Detector Paramaters
Params.ntrain = 1000;                                   % How many songs from the data set will be used as training data (if available)?
Params.nhidden_per_output = 4;                          % How many hidden units per syllable?  2 works and trains fast.  4 works ~20% better...
Params.fft_time_shift_seconds_target = 0.002;           % FFT frame rate (seconds).  Paper mostly used 0.0015 s: great for timing, but slow to train
Params.use_jeff_realignment_train = false;              % Micro-realign at each detection point using Jeff's time-domain code?  Don't do this.
Params.use_jeff_realignment_test = false;               % Micro-realign test data only at each detection point using Jeff's time-domain code.  Nah.
Params.use_nn_realignment_test = false;                 % Try using the trained network to realign test songs (reduce jitter?)
Params.confusion_all = false;                           % Use both training and test songs when computing the confusion matrix?
Params.nonsinging_fraction = 5;                         % Train on this proportion of nonsinging data (e.g. cage noise, calls)
Params.n_whitenoise = 10;                               % Add this many white noise samples (FIXME simplistic method)
Params.testfile_include_nonsinging = false;             % Include nonsinging data in audio test file
Params.samplerate = 48000;                              % Target samplerate (interpolate data to match this)
Params.fft_size = 256;                                  % FFT size
Params.use_pattern_net = false;                         % Use MATLAB's pattern net (fine, but no control over false-pos vs false-neg cost)
Params.do_not_randomise = false;                        % Use songs in original order?
Params.separate_network_for_each_syllable = false;       % Train a separate network for each time of interest?  Or one network with multiple outs?
Params.nruns = 1;                                       % Perform a few training runs and create beeswarm plot (paper figure 3 used 100)?
Params.freq_range = [1000 8000];                        % Frequencies of the song to examine
Params.time_window = 0.03;                              % How many seconds long is the time window?
Params.false_positive_cost = 1;
Params.trim_range =  [0.250 0.938];

% Load in cluster results
  here = pwd; % current directory
  load('cluster_results.mat', 'sorted_syllable')
  load('cluster_data.mat', 'filenames')
DATE =  filenames{1}(1:10);
% Get files that contain no song. (noise trials)
  G = find(cellfun(@isempty,sorted_syllable)); % TO DO: what about periods of silence in song trials?

for i = 1: size(G,2);
  mov_listing{i} = filenames{G(i)}
end

% Get Song_Data
load('extracted_data','mic_data')
S_data = mic_data;
% Get non-song audio data
cd ../

counter = 1;
for i = 1:size(G,2)
load(mov_listing{i},'audio')
for ii = 1:floor(size(audio.data,1)/size(S_data,1));
NS_data(:,counter) = audio.data(size(S_data,1)*(ii-1)+10:size(S_data,1)*(ii)+9);


counter = counter+1;
end
end

cd(here)



  Data.mic_data_song = S_data;
  Data.mic_data_noise = NS_data;
  Data.BirdID = BirdID;
  Data.SamlingRate = 48000;

  Params.BirdID = BirdID;
  Params.SamlingRate = 48000;

% Save Data.
strcat('Syllable_Detector_Data','_',BirdID)
  save(strcat('Syllable_Detector_Data','_',BirdID,'_',DATE),'Data');
  save(strcat('Detection_Paramaters','_',BirdID,'_',DATE),'Params')
