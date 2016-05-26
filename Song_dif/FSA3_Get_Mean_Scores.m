


function [Avg_Ca_xcorr, sim_score, Ca_Xcorr, sim_score_point,Ca_Xcorr_point,AD] = FSA3_Get_Mean_Scores(consensus,data)
% FSA3_Get_Mean_Scores
%
% Created: 05/20/16
% Updated: 05/23/16
% WALIII

% Use for freedomscope birds. Wrapper is 'Plot_SDI_Comparison'

%==============================================%
% Convert if in the freedomsScope format.
if any(strcmp('interp_dff',fieldnames(data))) ==1;
disp('freedomsScope format detected- converting to proper format...')
for trial = 1: size(data.raw_dat,2);
  for cell = 1:size(data.raw_dat,1);
      % INTERPLOLATE
ave_fs = 30;
fs = 48000;

% Get on to the proper timescale by interpolating
timevec = data.raw_time{cell,trial};
ave_time=0:1/ave_fs:size(data.analogIO_dat{trial},1)/fs;
tmp = data.raw_dat{cell,trial};

data.align_detrended{trial}(:,cell) = (interp1(timevec,tmp,ave_time,'spline'));

end
end


else
  disp('Inscopix format assumed- continuing...')

end


maxlag_samps=round(30*.02);

% to export aligned, detrended data:
AD = data.align_detrended;

clear sim_score; clear Mean_c;
% Use delta function:
for i = 1: size(data.align_detrended,2)

% detrend and smooth data data
[rows,cols] = size(data.align_detrended{i});
baseline = prctile(data.align_detrended{i},5);
dff= (data.align_detrended{i}-repmat(baseline,[rows 1]))./repmat(baseline,[rows 1]);
dff = tsmovavg((dff*1e2),'s',3,1);
dff2 = dff(3:end,:);



    temp = markolab_deltacoef(dff2');
data.align_detrended{i} = zscore(temp');%(startFrame:end-finishFrame,:);
end
consensus2 = consensus(:,750:2100,:);

% Get Mean of mic data ( similar to spectral density image)
Mean_c = mean(consensus,3);
Mean_c2 = mean(consensus2,3);

% Compare to the days's contour to the SDI
for i = 1:size(data.align_detrended,2);
    %sim_score(i)=norm(consensus(:,:,i).*Mean_c)/sqrt(norm(consensus(:,:,i)).*norm(Mean_c));
sim_score(i)= sum(sum(consensus2(:,:,i).*Mean_c2))./sqrt(sum(sum(consensus2(:,:,i).^2))*sum(sum(Mean_c2.^2)));

end





% AVG Ca im data for each trial
    for cell = 1:size(data.align_detrended{1},2)

     for trial = 1:size(data.align_detrended,2)
    Ca_avg_maker(:,trial) =  (data.align_detrended{trial}(:,cell)); %6:end-16
    end
    AVG_Trace(:,cell) = mean(Ca_avg_maker,2); % Average trace for each cell
    end

% Xcorr ( Dot product) of each cell to average trace.
    for cell = 1:size(data.align_detrended{1},2)
     for trial = 1:size(data.align_detrended,2);
    Ca_Xcorr{trial}(cell) = max(xcorr(data.align_detrended{trial}(:,cell),AVG_Trace(:,cell),maxlag_samps,'coeff'))/max(xcorr(data.align_detrended{trial}(:,cell),data.align_detrended{trial}(:,cell),maxlag_samps,'coeff'));
     end
    end



 % Compare matrix of Ca traces the average matrix of ca traces
for i = 1:size(data.align_detrended,2);
    Avg_Ca_xcorr{i} = mean(Ca_Xcorr{i});
    Ca_score(i)=norm(data.align_detrended{i}.*AVG_Trace)/sqrt(norm(data.align_detrended{i}).*norm(AVG_Trace));
end




%%----------------------%%
% Data Analysis For Tim %%
%%----------------------%%

% Xcorr ( Dot product) of each cell to average trace, point by point. ( a
% point is a frame)

    for trial = 1:size(data.align_detrended,2);
     for point = 1:size(data.align_detrended{1},1)
        for cell = 1:size(data.align_detrended{1},2)
      Ca_Xcorr_point{trial}(point,cell) = (data.align_detrended{trial}(point,cell)-(AVG_Trace(point,cell)));%./sqrt((data.align_detrended{trial}(point,cell).^2)*(AVG_Trace(point,cell)).^2);
      %Ca_Xcorr_point{trial}(point,cell) = max(xcorr(data.align_detrended{trial}(point,cell),AVG_Trace(point,cell),maxlag_samps,'coeff'))/max(xcorr(data.align_detrended{trial}(point,cell),data.align_detrended{trial}(point,cell),maxlag_samps,'coeff'));
    %  Ca_Xcorr_point{trial}(point,cell) = sum(data.align_detrended{trial}(point,cell).*AVG_Trace(point,cell))./sqrt((data.align_detrended{trial}(point,cell).^2)*(AVG_Trace(point,cell)).^2);

        end
     end
    end

  % Binned the song in frame sized compartments, for comparison to the ca data.
  bin_size = round(size(consensus,2)/size(data.align_detrended{1},1));

  for trial = 1:size(data.align_detrended,2);
    for point = 1:size(data.align_detrended{1},1)
start = (bin_size*point)-bin_size+1;
stop =  (bin_size*point) -1;
  % sim_score_point{trial}(point)= sum(sum(consensus(:,start:stop,trial).*Mean_c(:,start:stop)))./sqrt(sum(sum(consensus(:,start:stop,trial).^2))*sum(sum(Mean_c(start:stop).^2)));
  sim_score_point{trial}(point)= sum(sum(consensus(:,start:stop,trial).*Mean_c(:,start:stop)))./sqrt(sum(sum(consensus(:,start:stop,trial).^2)).*sum(sum(Mean_c(:,start:stop).^2)));
%[F{trial}{point},P{trial}counter}]=zftftb_sap_score(A{DAY}.mic_data{i}(6110:end-18330)',24400);
    end
  end

%% Get

disp('plotting data');
