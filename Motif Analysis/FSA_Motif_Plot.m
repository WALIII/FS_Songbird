


close all
figure(); 
trialno = {'0001','0002','0003'}
colores = {'r','g','b'}


cell2 = [1 2 3 4 6 7 8 9 10 12 16 17 20 24 27 29 30 34 41]

 counter2 = 1;
 clear HoldingV;
 for c = 1:3
  triaL =    trialno{c}
  color = colores{c};
  counter2 = 1;
  HoldingV = [];
  
for trial = 1:300
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




    
