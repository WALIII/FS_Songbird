function [DAT] = SAP_Calcium(A,DAY)


FS = 24400;
counter = 1;
 
% compute SAP scores and smooth Mic data
for i = 1:size(A{DAY}.align_detrended,2)
[F{counter},P{counter}]=zftftb_sap_score(A{DAY}.mic_data{i}(6110:end-18330)',24400);
counter = counter+1;
end

% Compare all to all:
counter = 1;
for c = 1:size(A{DAY}.align_detrended,2)
for i = 1:size(A{DAY}.align_detrended,2)

% Mic data
MICDATA = A{DAY}.mic_data{i}(6110:end-18330); % Change on each itteration
C_MICDATA = A{DAY}.mic_data{c}(6110:end-18330); % Change on each larger loop. to compare

% CA imaging data
IMDAT = (A{DAY}.align_detrended{i}(6:end-16,:));
C_IMDAT = (A{DAY}.align_detrended{c}(6:end-16,:));

%filter audio data
[b,a]=ellip(3,.2,40,[3e3 7e3]/(FS/2),'bandpass');
filt_signal=filtfilt(b,a,MICDATA);
c_filt_signal=filtfilt(b,a,C_MICDATA);

rms=zscore(sqrt(filter(ones(1e3,1)/1e3,1,filt_signal.^2)));
c_rms=zscore(sqrt(filter(ones(1e3,1)/1e3,1,c_filt_signal.^2)));


% Take dot product
Son{counter} = (sum(c_rms.*rms))./sqrt((sum(c_rms.^2))*(sum(rms.^2)));%Son{counter} = dot(c_rms,rms);
Ca{counter} = sum(sum(C_IMDAT.*IMDAT))./sqrt(sum(sum(C_IMDAT.^2))*sum(sum(IMDAT.^2))); %Ca{counter} = dot(C_IMDAT,IMDAT);
% Mean of Imaging Data:
M_Ca{counter} = mean(Ca{counter});

% Compare SAP scores
song_Spec_deriv{counter} = sum(sum(F{c}.spec_deriv.*F{i}.spec_deriv))./sqrt(sum(sum(F{c}.spec_deriv.^2))*sum(sum(F{i}.spec_deriv.^2)));
song_AM{counter} = sum(sum(F{c}.AM.*F{i}.AM))./sqrt(sum(sum(F{c}.AM.^2))*sum(sum(F{i}.AM.^2)));
song_FM{counter} = sum(sum(F{c}.FM.*F{i}.FM))./sqrt(sum(sum(F{c}.FM.^2))*sum(sum(F{i}.FM.^2)));
song_entorpy{counter} = sum(sum(F{c}.entropy.*F{i}.entropy))./sqrt(sum(sum(F{c}.entropy.^2))*sum(sum(F{i}.entropy.^2)));
song_amp{counter} = sum(sum(F{c}.amp.*F{i}.amp))./sqrt(sum(sum(F{c}.amp.^2))*sum(sum(F{i}.amp.^2)));
song_gravity_center{counter} = sum(sum(F{c}.gravity_center.*F{i}.gravity_center))./sqrt(sum(sum(F{c}.gravity_center.^2))*sum(sum(F{i}.gravity_center.^2)));
song_pitch_goodness{counter} = sum(sum(F{c}.pitch_goodness.*F{i}.pitch_goodness))./sqrt(sum(sum(F{c}.pitch_goodness.^2))*sum(sum(F{i}.pitch_goodness.^2)));
song_pitch{counter} = sum(sum(F{c}.pitch.*F{i}.pitch))./sqrt(sum(sum(F{c}.pitch.^2))*sum(sum(F{i}.pitch.^2)));

% Advance counter
counter = counter+1;
end

end

disp('Storing Data')


DAT.M_Ca = M_Ca;
DAT.song_pitch = song_pitch;
DAT.song_gravity_center = song_gravity_center;
DAT.song_amp = song_amp;
DAT.song_entorpy = song_entorpy;
DAT.song_FM = song_FM;
DAT.song_AM = song_AM;
DAT.song_Spec_deriv = song_Spec_deriv;
DAT.Son = Son;

