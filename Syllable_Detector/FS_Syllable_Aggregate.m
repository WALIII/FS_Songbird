function FS_Syllable_Aggregate()
% run in 'extraction'

  % load data into a strcture like this:


  for i = 1: size(S,2)

if i ==1;
    mic_data_song_AGG =  Data.mic_data_song;
    mic_data_noise_AGG = Data.mic_data_noise;

  else
    mic_data_song_AGG = horzcat(mic_data_song_AGG,Data.mic_data_song);
    mic_data_noise_AGG = horzcat(mic_data_noise_AGG,Data.mic_data_noise);
  end
end
