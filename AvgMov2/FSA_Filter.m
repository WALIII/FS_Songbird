function [MOV_DAT_F] = FSA_Filter(mov_dat,radius)




AVG_DAT{1} = mov_dat;
for i = 1
% for d = 1:size(AVG_DAT{i},3)
%     data = AVG_DAT{1}(:,:,d);
%     tiledImage(:,:,d) = [data, flipdim(data,1), data; flipdim(data,2), data, flipdim(data,2); data,flipdim(data,1), data];
% end
    
h = fspecial('disk',radius);
    bground = imfilter(AVG_DAT{i},h,'replicate');
    AVG_DAT_f3{i} = AVG_DAT{i}-bground;
    AVG_DAT_f3{i}(AVG_DAT_f3{i}<0)=0;
end
MOV_DAT_F = AVG_DAT_f3;



