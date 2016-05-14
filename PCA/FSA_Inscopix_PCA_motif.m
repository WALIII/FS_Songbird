

close all

counter1 = 1;
counter2 = 1;
counter3 = 1;


for i = 1:18;
    data = A{2};
Matrix_data = (data.align_detrended{i}');

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



try
Y = char(data.filename{i});
Y = Y(end-3:end);
catch
    disp('Warning- too much song?')
    continue
end


 trialno = {'0001', '0002', '0003'};
    if Y == trialno{1};
z1 = score(:,1);
x1 = score(:,2);
y1 = score(:,4);
obj1{counter1} = cat(2,x1,y1,z1); 
obj1{counter1}(:,4) = 1:length(obj{counter1}); 
obj1{counter1}(:,5) = counter1; % Specify object ID number 
counter1 = counter1+1;
    elseif Y == trialno{2};
z1 = score(:,1);
x1 = score(:,2);
y1 = score(:,4);
obj2{counter2} = cat(2,x1,y1,z1); 
obj2{counter2}(:,4) = 1:length(obj{counter2}); 
obj2{counter2}(:,5) = counter2; % Specify object ID number 
counter2 = counter2+1;
    elseif Y == trialno{3};
z1 = score(:,1);
x1 = score(:,2);
y1 = score(:,4);
obj3{counter3} = cat(2,x1,y1,z1); 
obj3{counter3}(:,4) = 1:length(obj{counter3}); 
obj3{counter3}(:,5) = counter2; % Specify object ID number 
counter3 = counter3+1;
    else
        disp('WARNING does not sort')
    end




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


figure(3);

PosList1 = cat(1,obj1{1},obj1{2},obj1{3},obj1{4},obj1{5},obj1{6},obj1{7});
comet3n(PosList1)

PosList2 = cat(1,obj2{1},obj2{2},obj2{3},obj2{4},obj2{5},obj2{6},obj2{7},obj2{8});
comet3n(PosList2)

PosList3 = cat(1,obj3{1},obj3{2},obj3{3});
comet3n(PosList3)

