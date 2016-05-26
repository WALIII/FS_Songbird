


function [Avg_Ca_xcorr, sim_score, Ca_Xcorr, sim_score_point,Ca_Xcorr_point] = FSA2_Get_Mean_Scores(consensus,data)

% Use for inscopix birds. Wrapper is 'Plot_SDI_Comparison'



maxlag_samps=round(30*.02);


clear sim_score; clear Mean_c;
% Trim Data
for i = 1: size(data.align_detrended,2)
data.align_detrended{i} = data.align_detrended{i}(6:end-16,:);
end
consensus = consensus(:,600:4000,:);

% Get Mean of mic data ( similar to spectral density image)
Mean_c = mean(consensus,3);

% Compare to the days's contour to the SDI
for i = 1:size(data.align_detrended,2);
    %sim_score(i)=norm(consensus(:,:,i).*Mean_c)/sqrt(norm(consensus(:,:,i)).*norm(Mean_c));
sim_score(i)= sum(sum(consensus(:,:,i).*Mean_c))./sqrt(sum(sum(consensus(:,:,i).^2))*sum(sum(Mean_c.^2)));

end





% AVG Ca im data for each trial

    for cell = 1:size(data.align_detrended{1},2)

     for trial = 1:size(data.align_detrended,2)
    Ca_avg_maker(:,trial) =  data.align_detrended{trial}(:,cell); %6:end-16
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
%% Data Analysis For Tim %%
%%----------------------%%

% Xcorr ( Dot product) of each cell to average trace, point by point.

    for trial = 1:size(data.align_detrended,2);
     for point = 1:size(data.align_detrended{1},1)
        for cell = 1:size(data.align_detrended{1},2)
      Ca_Xcorr_point{trial}(point,cell) = (data.align_detrended{trial}(point,cell).*AVG_Trace(point,cell));%./sqrt((data.align_detrended{trial}(point,cell).^2)*(AVG_Trace(point,cell)).^2);
      %Ca_Xcorr_point{trial}(point,cell) = max(xcorr(data.align_detrended{trial}(point,cell),AVG_Trace(point,cell),maxlag_samps,'coeff'))/max(xcorr(data.align_detrended{trial}(point,cell),data.align_detrended{trial}(point,cell),maxlag_samps,'coeff'));

    %  Ca_Xcorr_point{trial}(point,cell) = sum(data.align_detrended{trial}(point,cell).*AVG_Trace(point,cell))./sqrt((data.align_detrended{trial}(point,cell).^2)*(AVG_Trace(point,cell)).^2);

        end
     end
    end

  % Binned comparison for the song.
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

% figure();
% for i = 1:size(data.align_detrended,2);
% plot(Avg_Ca_xcorr{i},sim_score(i),'*');
% hold on;
% end
