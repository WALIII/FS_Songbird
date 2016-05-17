


function [Avg_Ca_xcorr, sim_score, Ca_Xcorr] = FSA2_Get_Mean_Scores(consensus,A,DAY)


% Use 

maxlag_samps=round(30*.02);

clear sim_score; clear Mean_c;
% Trim Data
for i = 1: size(A{DAY}.align_detrended,2)
A{DAY}.align_detrended{i} = A{DAY}.align_detrended{i}(6:end-16,:);
end
consensus{DAY} = consensus{DAY}(:,600:4000,:);

% Get Mean of mic data
Mean_c = mean(consensus{DAY},3);

for i = 1:size(A{DAY}.align_detrended,2);
    %sim_score(i)=norm(consensus{DAY}(:,:,i).*Mean_c)/sqrt(norm(consensus{DAY}(:,:,i)).*norm(Mean_c));
sim_score(i)= sum(sum(consensus{DAY}(:,:,i).*Mean_c))./sqrt(sum(sum(consensus{DAY}(:,:,i).^2))*sum(sum(Mean_c.^2)));

end





% AVG Ca im data for each trial 

    for cell = 1:81
     for trial = 1:size(A{DAY}.align_detrended,2)
    Ca_avg_maker(:,trial) =  A{DAY}.align_detrended{trial}(:,cell); %6:end-16
    end
    AVG_Trace(:,cell) = mean(Ca_avg_maker,2);
    end
    
% Cross correlatoin
    for cell = 1:81
     for trial = 1:size(A{DAY}.align_detrended,2); 
    Ca_Xcorr{trial}(cell) = max(xcorr(A{DAY}.align_detrended{trial}(:,cell),AVG_Trace(:,cell),maxlag_samps,'coeff'))/max(xcorr(A{DAY}.align_detrended{trial}(:,cell),A{DAY}.align_detrended{trial}(:,cell),maxlag_samps,'coeff'));
     end
    end

    
 % Compare matrix of Ca traces the average matrix of ca traces   
for i = 1:size(A{DAY}.align_detrended,2); 
    Avg_Ca_xcorr{i} = mean(Ca_Xcorr{i});
    Ca_score(i)=norm(A{DAY}.align_detrended{i}.*AVG_Trace)/sqrt(norm(A{DAY}.align_detrended{i}).*norm(AVG_Trace));
end


disp('plotting data');

% figure();
% for i = 1:size(A{DAY}.align_detrended,2);
% plot(Avg_Ca_xcorr{i},sim_score(i),'*');
% hold on;
% end



