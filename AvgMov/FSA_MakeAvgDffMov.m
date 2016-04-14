function FSA_MakeAvgDffMov()
% Make average Dff movie



for frame = 1:frames
    z = a(:,:,frame);
    [x,y] = meshgrid(1:256,1:256);
    id = find(z ~= 0);
    a(:,:,frame) = griddata(x(id),y(id),z(id),x,y,'linear');
end
