function [S C] = FS_GLM(A, sim_score_point)

data.align_detrended = A{1}.align_detrended;
% params
start = 7;
stop = 16;

% format Calcium data;
for i = 1: size(data.align_detrended,2)
% detrend and smooth data data
[rows,cols] = size(data.align_detrended{i});
baseline = prctile(data.align_detrended{i},5);
dff= (data.align_detrended{i}-repmat(baseline,[rows 1]))./repmat(baseline,[rows 1]);
dff = tsmovavg((dff*1e2),'s',3,1);
dff2 = dff(3:end,:);
   % temp = markolab_deltacoef(dff2');
data.align_detrended{i} = zscore(dff2);%(startFrame:end-finishFrame,:);
end

C1 = data.align_detrended{1};

 S1 = zscore((sim_score_point{1,1}{1}));
 S1 = tsmovavg(S1,'s',3,2);

S = S1(start:end-stop);
C = C1(start:end-stop,:);


for trials = 2:18
    
C_2 = data.align_detrended{trials};
S_2 = zscore((sim_score_point{1,1}{trials}));
S_2 = tsmovavg(S_2,'s',3,2);

C2 = C_2(start:end-stop,:);
S2 = S_2(start:end-stop);
C = vertcat(C,C2);
S = cat(2,mapstd(S),mapstd(S2));

end
S = detrend(S);

figure(); plot(C,'r'); hold on; plot(S,'b');

[B,DEV,STATS] = glmfit(C,S');


