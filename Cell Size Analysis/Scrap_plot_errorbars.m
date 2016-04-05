


figure(); 
counter = 1;

for  cell = 1:6;
    clear Meen;
for  j = 1:70
    
  Meen(j,:) =   zscore(roi_ave.interp_raw{cell,j})+counter*5;
    
end

if cell ==  1 | cell == 2 | cell == 3
    color = '-r';
else
    color = '-b';
end

 
 y = (Meen);
 x = roi_ave.interp_time{1,1};
  shadedErrorBar(x,y,{@mean,@std},color,1); 
    
    clear x;
    clear y;
    hold on;
    counter = counter+1;
end;


x=[0.25, 0.25];
y=[0,35];
plot(x,y,'--r')

length(roi_ave.interp_time{1,1})
l2 = roi_ave.interp_time{1,1}(:,end)-0.75
x=[l2, l2];
y=[0,35];
plot(x,y,'--r')


% legend('','Big cells','','Small Cells');
% 



