
Function FS_PCA(

% Plot pretty PCA plots
%%%%%

close all



for i = 1:18;

clear colorA

maxdff=max(Matrix_data,[],2);
%GoodCells = find(maxdff>20); % 10 is cutoff


[coeff,score] = princomp((Matrix_data'));

for ii = 1:3 
colorA(i,:) = ((abs(coeff(:,i))-min(abs(coeff(:,i))))/(max(abs(coeff(:,i)))-min(abs(coeff(:,i)))));
end

%figure(1); comet3(score(:,1),score(:,3),score(:,2)) % plot 1st and third component, with time (30000 samples in this trial)
hold on;
figure(1); fb_plot_3dtime(score,1:size(score,1),'dims',1:3) % plot in 3d with color
hold on;



%format for plotting 
z1 = score(:,1);
x1 = score(:,2);
y1 = score(:,4);
obj{i} = cat(2,x1,y1,z1); 
obj{i}(:,4) = 1:length(obj{i}); 
obj{i}(:,5) = i; % Specify object ID number 



end

figure(2);
PosList = cat(1,obj{1},obj{2},obj{3},obj{4},obj{5},obj{6},obj{7},obj{8},obj{9},obj{10},obj{11},obj{12},obj{13},obj{14},obj{15},obj{16},obj{17},obj{18}); 
comet3n(PosList)
% 
% 
% 
% z1 = -2*pi:pi/250:2*pi; 
% x1 = (cos(2*z1).^2).*sin(z1); 
% y1 = (sin(2*z1).^2).*cos(z1); 
% obj1 = cat(2,x1',y1',z1'); 
% obj1(:,4) = 1:length(obj1); 
% obj1(:,5) = 1; % Specify object ID number 
% % create trajectory for first object 
% z2 = -3*pi:pi/250:3*pi; 
% x2 = -(cos(2*z2).^2).*sin(z2); 
% y2 = (sin(2*z2).^2).*cos(z2); 
% obj2 = cat(2,x2',y2',z2'); 
% obj2(:,4) = 1:length(obj2); 
% obj2(:,5) = 2;
% 
% % Combine two position lists and plot 
% PosList = cat(1,obj1,obj2); 
% comet3n(PosList)
% 
% % 
% % 
% % 
% % 
% % 
% %    