function FS_Play_mov(MOV);

figure();

for i = 1: size(MOV,3);
    image(MOV(:,:,i));
    pause(0.03);
end;
figure(2);
colormap(gray);
imagesc(std(MOV(:,:,8:end-10).^2,[],3))
% figure(3);
% colormap(gray);
% imagesc(mean(MOV,3))

end
