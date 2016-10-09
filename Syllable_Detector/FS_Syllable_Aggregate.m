function Data_Aggregate = FS_Syllable_Aggregate(Data)
% run in 'extraction'

  % load data into a strcture of cells, for each day ( manually
  % constructed) 


  for i = 1: size(Data,2)

if i ==1;
    mic_data_song_AGG =  Data{1,1}.mic_data_song;
    mic_data_noise_AGG = Data{1,1}.mic_data_noise;
    BirdID = Data{1,1}.BirdID;

  else
    mic_data_song_AGG = horzcat(mic_data_song_AGG,Data{1,i}.mic_data_song);
    mic_data_noise_AGG = horzcat(mic_data_noise_AGG,Data{1,i}.mic_data_noise);
  end
end

  Data_Aggregate.mic_data_song = mic_data_song_AGG;
  Data_Aggregate.mic_data_noise = mic_data_noise_AGG;
  Data_Aggregate.fs = 48000;
  Data_Aggregate.BirdID = BirdID;
