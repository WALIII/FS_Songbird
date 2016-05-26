% function Plot_SDI_Comparison(A,consensus)


for i = 1:size(A,2)
[BB1 BB2 BB3 BB4 BB5 BB6] = FSA3_Get_Mean_Scores(consensus{i},A{i});
Avg_Ca_xcorr_agg{i} = BB1;
sim_score_agg{i} = BB2;
CA_Xcorr{i} = BB3;
sim_score_point{i} = BB4;
Ca_Xcorr_point{i} = BB5;
A{i}.align_detrended = BB6;
end


figure();

disp('Plotting data')
c = {'*r','*g','*b','*c','*m'};
for i = 1:size(A,2)
    for ii = 1:size(Avg_Ca_xcorr_agg{i},2)
    plot(Avg_Ca_xcorr_agg{i}{ii},sim_score_agg{i}(ii),c{i})
    xlabel('CA++ ROI value minus average (binned per frame)')
    ylabel('SONG Similarity (binned per frame)')
    hold on
    end
end



% figure();
% c = {'*r','*g','*b','*c','*m'};
% for i = 1:5% Day
%     for ii = 1:size(Avg_Ca_xcorr_agg{i},2); % trials
%         %if A{i}.filename{ii}(end-3:end) == '0001';
%         for iii = 1:size(sim_score_point{1}{1},2); % points/bins
%     plot(sim_score_point{1,i}{1,ii}(iii),abs(mean(Ca_Xcorr_point{1,i}{1,ii}(iii,:))),c{i})
% 
%     ylabel('CA++ ROI value multiplied by average value (binned per frame)')
%     xlabel('SONG Similarity (binned per frame)')
%     hold on
%     end
%        % end
%     end
% end



% figure();
%
% disp('Plotting data')
% c = jet(81);
%
% for i = 1:5
%     for ii = 1:size(A{i}.align_detrended,2);
%         for iii = 1:size(A{i}.align_detrended{1},2)
%
%     plot(CA_Xcorr{1, i}{1, ii}(iii),sim_score_agg{i}(ii),'*','color',c(iii,:))
%     hold on;
%     xlabel('CALCIUM')
%     ylabel('SONG')
%     hold on
%         end
%     end
% end
