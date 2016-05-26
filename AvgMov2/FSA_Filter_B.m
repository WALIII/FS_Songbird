function [MOV_DAT_F] = FSA_Filter_B(mov_dat,radius)
% Filter Data from Average Movies.


 
for ii = 1:size(mov_dat,2)
AVG_DAT = mov_dat{ii};
for i = 1:3
    
h = fspecial('disk',radius);
    bground = imfilter(AVG_DAT{i},h,'replicate');
    AVG_DAT_f3{i} = AVG_DAT{i}-bground;
    AVG_DAT_f3{i}(AVG_DAT_f3{i}<0)=0;
end
MOV_DAT_F{ii} = AVG_DAT_f3;
clear AVG_DAT_f3;
end



