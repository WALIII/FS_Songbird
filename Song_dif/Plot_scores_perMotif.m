

% Make histogram of songbird data, with transparent histogram. 
% Edited 05.29.2016
% WAL3







figure(); 


counter = 1;
for i = 1:size(A,2); 
 for ii = 1:size(sim_score_agg{i},2)
     try
     %if A{i}.filename{2,ii}{1,1}(end-3:end) == '0001';
    sim_score_agg2{i}(counter) = sim_score_agg{i}(ii);
    counter = counter+1;
     %end;
     catch
         disp('skipping file');
     end
     
 end
end
map = lines(5);
for i = 1:size(A,2); 
    
    
    histogram(sim_score_agg2{i},20,'facecolor',map(i,:),'facealpha',.3,'edgecolor','none'); 
    hold on;
    xlim([.2 .8]); 
    ylim([0 50]);
    xlabel('Song Similarity'); 
    ylabel(' #Songs in bin'); 
    title(' Distribution of scopres for LNY18'); 
end;

legend('day 01', 'Day 02', 'Day 03', 'Day 04', 'Day 05');
