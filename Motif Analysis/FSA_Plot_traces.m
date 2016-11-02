

figure(1);

hold on;


trialno = '0003'

cell2 = 1:5;

 counter2 = 1;
 clear HoldingV;
for trial = 1:50

   clear Y; 
S = roi_ave.filename{1,trial};
Y = S(end-7:end-4);
counter = 1; 


if Y == trialno;
    for i = 1:size(roi_ave.interp_raw,1)
HoldingV{i,counter2} = roi_ave.interp_raw{i,trial};
    end
counter2 = counter2+1;
for cell = cell2 %[2 4 5 8 12 14  16 17 22 23  25 26] ;


    subplot(1,2,1);
   
    
    
    
    Pdat = tsmovavg(roi_ave.raw_dat{cell,trial}(:,:)','s',3,1);
    Pdat = Pdat';
 plot(roi_ave.raw_time{cell,trial}(:,3:end),zscore(Pdat(3:end))+counter*5); 
 hold on;  

  counter = counter+1;
 
end


else
   
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
 
hold off;

%%AVERAGED CELL RESPONSES




counter = 1;
color = '-r';
for  cell = cell2  %[2 4 5 8 12 14  16 17 22 23  25 26] ;
    clear Meen;
for  j = 1:size(HoldingV,2)
    
  Meen(j,:) =   zscore(HoldingV{cell,j})+counter*5;
    
end

 
 y = (Meen);
 x = roi_ave.interp_time{1,1};
 subplot(1,2,2);
 shadedErrorBar(x,y,{@mean,@std},color,1); 
    
    clear x;
    clear y;
    hold on;
    counter = counter+1;
end;


x=[0.25, 0.25];
y=[0,95];
plot(x,y,'--r')

length(roi_ave.interp_time{1,1})
l2 = roi_ave.interp_time{1,1}(:,end)-0.75
x=[l2, l2];
y=[0,95];
plot(x,y,'--r')

titleWords = strcat('motif #',trialno,'Trials = ',num2str(size(HoldingV,2)));
title(titleWords);
axis tight;




    
