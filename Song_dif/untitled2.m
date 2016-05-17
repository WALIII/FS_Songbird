% Song v calcium


close all;


figure;
FS = 24400;
counter = 1;
DAY = 3;
 

% computer SAP scores and smooth Mic data

for i = 1:size(A{DAY}.align_detrended,2)
[F{counter},P{counter}]=zftftb_sap_score(A{DAY}.mic_data{i}(6110:end-18330)',24400);

counter = counter+1;
end

counter = 1;

for c = 1:size(A{DAY}.align_detrended,2)

for i = 1:size(A{DAY}.align_detrended,2)

% Mic data
MICDATA = A{DAY}.mic_data{i}(6110:end-18330); % Change on each itteration
C_MICDATA = A{DAY}.mic_data{c}(6110:end-18330); % Change on each larger loop. to compare

% CA imaging data
IMDAT = zscore(A{DAY}.align_detrended{i}(6:end-16,:));
C_IMDAT = zscore(A{DAY}.align_detrended{c}(6:end-16,:));

%filter audio data
[b,a]=ellip(3,.2,40,[3e3 7e3]/(FS/2),'bandpass');
filt_signal=filtfilt(b,a,MICDATA);
c_filt_signal=filtfilt(b,a,C_MICDATA);

rms=sqrt(filter(ones(1e3,1)/1e3,1,filt_signal.^2));
c_rms=sqrt(filter(ones(1e3,1)/1e3,1,c_filt_signal.^2));


% Take dot product
Son{counter} = dot(c_rms,rms);
Ca{counter} = dot(C_IMDAT,IMDAT);
M_Ca{counter} = mean(Ca{counter});

% SAP scores
song_Spec_deriv{counter} = norm(F{c}.spec_deriv.*F{i}.spec_deriv);
song_AM{counter} = norm(F{c}.AM.*F{i}.AM);
song_FM{counter} = norm(F{c}.FM.*F{i}.FM);
song_entorpy{counter} = norm(F{c}.entropy.*F{i}.entropy);

song_amp{counter} = norm(F{c}.amp.*F{i}.amp);
song_gravity_center{counter} = norm(F{c}.gravity_center.*F{i}.gravity_center);
song_pitch_goodness{counter} = norm(F{c}.pitch_goodness.*F{i}.pitch_goodness);
song_pitch{counter} = norm(F{c}.pitch.*F{i}.pitch);
song_pitch_choose{counter} = norm(F{c}.pitch_chose.*F{i}.pitch_chose);
song_pitch_weight{counter} = norm(F{c}.pitch_weight.*F{i}.pitch_weight);





counter = counter+1;
end

end

disp('Starting to plot')
figure()
for ii = 1:size(Ca,2)

      subplot(4,2,1)  plot(M_Ca{ii},Son{ii},'*')
      title('Ca vs smoothed song')
hold on;

      figure(2);  plot(M_Ca{ii},song_Spec_deriv{ii},'*')
         title('song Spec_deriv')
hold on;

      figure(3);  plot(M_Ca{ii},song_AM{ii},'*')
         title('song AM')
hold on;

      figure(4);  plot(M_Ca{ii},song_FM{ii},'*')
         title('song FM')
hold on;

      figure(5);  plot(M_Ca{ii},song_entorpy{ii},'*')
         title('song entorpy')
hold on;

      figure(5);  plot(M_Ca{ii},song_amp{ii},'*')
         title('song amp')
hold on;

      figure(6);  plot(M_Ca{ii},song_gravity_center{ii},'*')
         title('song gravity center')
hold on;

      figure(7);  plot(M_Ca{ii},song_pitch_goodness{ii},'*')
         title('song pitch goodness')
hold on;

      figure(8);  plot(M_Ca{ii},song_pitch{ii},'*')
         title('song pitch')
hold on;



end

