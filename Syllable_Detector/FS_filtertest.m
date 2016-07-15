function FS_Syllable_Aggregate(BirdID)
% run in 'extraction'

  here = pwd; % current directory
  load('cluster_results.mat', 'sorted_syllable')
  load('cluster_data.mat', 'filenames')
  G = find(cellfun(@isempty,sorted_syllable))

% get filenames
i = 1: size(G);
  Mov_listing{i} = filenames{G(i)}
end

% Get Song_Data

load('extracted_data','mic_data')
S_data = mic_data;
% Get non-song audio data
cd ../

for i = 1:size(mov_listing)
load(mov_listing{i},'audio.data')
NS_data(:,i) = audio.data(10:size(S_data,2)+10);
end

cd(here)



  Data.mic_data_aligned = S_data;
  Data.mic_data_NonSong = NS_data;
  Data.BirdID = BirdID;
  Data.SamlingRate = 48000;

  save('Data','Syllable_Detector_Data');
