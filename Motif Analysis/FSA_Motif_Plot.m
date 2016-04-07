function FSA_Motif_Plot(roi_ave)
% FSA_Motif_Plot.m

% Plots songs, depending on the extraction order (roughly, motif order of when the were
% extracted)

%   Created: 2016/04/07
%   By: WALIII
%   Updated: 2016/04/07
%   By: WALIII

% FSA_Motif_Plot will do several things:
%
%   1. Load in all imaging data from .mat in directory, and selerate them into trials
%      based on the last several digits, i.e. their motif ID.
%   2. plot the mean, bounded by 2*SEM.



% Run in the Directory of the .mat files. This is typically the 'mov' folder


close all
figure();
trialno = {'0001','0002','0003'}
colores = {'r','g','b'}


cell2 = 1:40;

 counter2 = 1;
 clear HoldingV;
 for c = 1:3
  triaL =    trialno{c}
  color = colores{c};
  counter2 = 1;
  HoldingV = [];

for trial = 1:size(roi_ave.filename,2)
   clear Y;
S = roi_ave.filename{1,trial};
Y = S(end-7:end-4);
counter = 1;

if Y == triaL;
    for i = 1:size(roi_ave.interp_raw,1)
HoldingV{i,counter2} = roi_ave.interp_raw{i,trial};
    end
counter2 = counter2+1;

end
end


x=[0.25, 0.25];
y=[0,95];
plot(x,y,'--r')

length(roi_ave.interp_time{1,1})
l2 = roi_ave.interp_time{1,1}(:,end)-0.75
x=[l2, l2];
y=[0,95];
plot(x,y,'--r')
axis tight;
xlabel('time(s)');

hold on;

%%AVERAGED CELL RESPONSES





for  cell = cell2  %[2 4 5 8 12 14  16 17 22 23  25 26] ;
    clear Meen;

for  j = 1:size(HoldingV,2)

  Meen(j,:) =   zscore(HoldingV{cell,j})+counter*5;

end


 y = (Meen);
 x = roi_ave.interp_time{1,1};

 shadedErrorBar(x,y,{@mean,@std},color,1);

 counter = counter+1;
end
a{c} = num2str(size(HoldingV,2));
TN{c} = trialno;
% clear HoldingV;
    clear x;
    clear y;
    hold on;

end;


x=[0.25, 0.25];
y=[0,95];
plot(x,y,'--r')

length(roi_ave.interp_time{1,1})
l2 = roi_ave.interp_time{1,1}(:,end)-0.75
x=[l2, l2];
y=[0,95];
plot(x,y,'--r')


titleWords = strcat('motif #',TN{1},'Trials = ',a{1});
title(titleWords);
titleWords = strcat('motif #',TN{2},'Trials = ',a{2});
title(titleWords);
titleWords = strcat('motif #',TN{3},'Trials = ',a{3});
title(titleWords);

axis tight;
