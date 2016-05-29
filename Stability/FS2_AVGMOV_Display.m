function FS2_AVGMOV_Display(roi_ave);
% FUnction- plot 

figure(); for ii = 1:81; for i = 1:5; plot(roi_ave.raw_dat{ii,i}+ii*2); IMDAT{i}(:,ii) =roi_ave.raw_dat{ii,i}; hold on; end; end;

for i = 1:5;
    
data{i} = IMDAT{i};
end

% figure(); imagesc(data{1}')



%% Stability analysis



for cell = 1:size(data{1},2)
for i = 1:1:size(data,2)
 trial1(:,i)  = data{i}(:,cell);
[acor,lag] = xcorr(trial1(:,i),trial1(:,1));
[M,I] = max(acor);
offset(i) = lag(I);
 hold on
end
Cell_Stability(cell) = abs(mean(offset));
end

cutoff = 0.0001;
clear U; clear S;
U = find(Cell_Stability > cutoff);
S = find(Cell_Stability < cutoff);


% unstable



% Assign Variables:
t = 1;
%             
% U = [5,6,7,8,9,10,14,15,16,17,22,24,25,26,29,33,35,36,39,40,47,55,56,58,60,61,62,66,71,72 ];
% S = 1:size(data{1},2)-1;
% S(U) = [];

ci = 1;
figure(); 
subplot(1,2,1);
c  = colormap(hsv(5));


ci = 1;
figure();
subplot(1,2,1)
for i = U
    for ii = 1:5;
        hold on;
    plot((data{ii}(:,i)-mean(data{ii}(:,i)))/mean(data{ii}(:,i))+ci*5,'color',c(ii,:),'LineWidth',2);  hold on; 
    grid on;
    end
        ymax = ci*5;
        strmax = strcat('Cell:',' ',num2str(i-1));
       text(t,ymax,strmax,'HorizontalAlignment','right');

    ci = ci+1;
    axis off
    axis tight
    
    
end
title('UNSTABLE CELLS, Mean Subtracted');

subplot(1,2,2);
for i = S
    for ii = 1:5;
    plot((data{ii}(:,i)-mean(data{ii}(:,i)))/mean(data{ii}(:,i))+ci*5,'color',c(ii,:),'LineWidth',2);  hold on; 
    grid on;
    end
        ymax = ci*5;
        strmax = strcat('Cell:',' ',num2str(i-1));
       text(t,ymax,strmax,'HorizontalAlignment','right');
    ci = ci+1;
    axis off
    axis tight

end
legend('Day01','Day02','Day03','Day04','Day05')
title('STABLE CELLS, Mean Subtracted');


for i = 1:5
    INDEX1 = U;
    INDEX2 = S;
S_dat{i} = data{i};
S_dat{i}(:,INDEX1) = [];
U_dat{i} = data{i};
U_dat{i}(:,INDEX2) = [];
end
    colormap(hot);

figure();
for i = 1:5
%     
    %S_dat{i} = normc((S_dat{i}(2:end,:)));
    S_dat3{i} = normc((S_dat{i}(1:end,:)));
    for ii = 1:size(S_dat{1}(:,:),2)
        if max(S_dat{i}(:,ii))> 0.2
            S_dat2{i}(:,ii) = S_dat3{i}(:,ii);
        else
         S_dat2{i}(:,ii) = zeros(1,size(S_dat{i}(:,:),1));
        end
    end

    
        
 A    = S_dat2{i}(:,:)';
  if i ==1;  
[maxA, Ind] = max(A, [], 2);
[dummy, index] = sort(Ind);
  else end;
B  = A(index, :);
subplot(1,5,i)
imagesc(B)
set(gca,'YTick',[1:size(index)])
set(gca,'YTickLabel',index)

end

colormap(hot);

set(gcf,'NextPlot','add');
axes;
h = title('Stable Cells');
set(gca,'Visible','off');
set(h,'Visible','on');



figure();
for i = 1:5
    
        U_dat3{i} = normc((U_dat{i}(1:end,:)));
    for ii = 1:size(U_dat{1}(:,:),2)
        if max(U_dat{i}(:,ii))> 20
            U_dat2{i}(:,ii) = U_dat3{i}(:,ii);
        else
         U_dat2{i}(:,ii) = zeros(1,size(U_dat{i}(:,:),1));
        end
    end
    
    

 A  = U_dat{i}(:,:)';
  if i ==1;  
[maxA, Ind] = max(A, [], 2);
[dummy, index] = sort(Ind);
  else end;
B  = A(index, :);
subplot(1,5,i)
imagesc(B);
set(gca,'YTick',[1:size(index)])
set(gca,'YTickLabel',index)


end

colormap(hot);

set(gcf,'NextPlot','add');
axes;
h = title('Unstable Cells');
set(gca,'Visible','off');
set(h,'Visible','on');

% All Cells
clear U_dat3; clear U_dat3; clear U_dat2;
U_dat = data;
U_dat_full = U_dat{1}(1:end,:);
for i= 1:4
U_dat_full = horzcat(U_dat_full,U_dat{i+1});
end
U_dat_full = normc((U_dat_full(:,:)));

figure();
for i = 1:5
    
% U_dat{i} = normc((U_dat{i}(1:end,:)));
U_datX(:,1:size(U_dat{i},2)) = U_dat_full(:,size(U_dat{i},2)*(i-1)+1:(size(U_dat{i},2)*i));
% [cmin cmax]

    for ii = 1:size(U_datX(:,:),2)
        if max(U_datX(:,ii))> .30;
            U_dat2{i}(:,ii) = U_datX(:,ii);
        else
         U_dat2{i}(:,ii) = zeros(1,size(U_datX(:,:),1));
        end
    end
        % U_dat2{i} = normc((U_dat2{i}(1:end,:)));
    

 A  = U_dat2{i}(:,:)';
  if i ==1;  
[maxA, Ind] = max(A, [], 2);
[dummy, index] = sort(Ind);
  else end;
B  = (A(index, :));
subplot(1,5,i)
imagesc(B);
set(gca,'YTick',[1:size(index)])
set(gca,'YTickLabel',index)


end

colormap(hot);

set(gcf,'NextPlot','add');
axes;
h = title('All Cells');
set(gca,'Visible','off');
set(h,'Visible','on');
