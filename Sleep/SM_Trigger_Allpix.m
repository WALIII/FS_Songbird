function SM_Trigger_Allpix(mov_dat, trigger)


for i = 1:size(threshT)
T = threshT(i)
S = T-10;
F = T+10;
    mov_dat(:,:,S:F,i);
 
end


Mean_Mov = mean(mov_dat,4);

FS_allpix(Mean_Mov);





    
    
    