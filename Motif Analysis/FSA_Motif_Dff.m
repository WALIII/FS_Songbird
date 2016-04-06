function [M_Im_Agg] =  FSA_Motif_Dff;



trialno = {'0001','0002','0003'};

        gifListing = dir(fullfile(pwd,'*tif'));
        gifListing = {gifListing(:).name};
       for ii = 1:length(gifListing);
         Y{ii} = gifListing{ii}(end-11:end-8);


       end

       disp('Extracting good gif trials');


for c = 1:3
         triaL = trialno{c}

         counter = 1;
for trial = 1:length(gifListing);

       if Y{trial} == triaL;
           Imdat = imread(gifListing{trial});
           ImAgg(:,:,counter) = Imdat;
           counter = counter+1;
           clear Imdat;
       end
end

M_Im_Agg(:,:,c) = mean(ImAgg,3);
clear ImAgg;
end
