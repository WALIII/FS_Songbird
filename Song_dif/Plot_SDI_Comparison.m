

% for i = 1:5;
% [BB1 BB2 BB3] = FSA2_Get_Mean_Scores(consensus,A,i);
% Avg_Ca_xcorr_agg{i} = BB1;
% sim_score_agg{i} = BB2;
% CA_Xcorr{i} = BB3;
% end


figure();

disp('Plotting data')
c = {'*r','*g','*b','*c','*m'};
for i = 1:5
    for ii = 1:size(A{i}.align_detrended,2);
    plot(Avg_Ca_xcorr_agg{i}{ii},sim_score_agg{i}(ii),c{i})
    xlabel('CALCIUM')
    ylabel('SONG')
    hold on
    end
end



figure();

disp('Plotting data')
c = jet(81);

for i = 1:5
    for ii = 1:size(A{i}.align_detrended,2);
        for iii = 1:size(A{i}.align_detrended{1},2)

    plot(CA_Xcorr{1, i}{1, ii}(iii),sim_score_agg{i}(ii),'*','color',c(iii,:))
    hold on;
    xlabel('CALCIUM')
    ylabel('SONG')
    hold on
        end
    end
end
