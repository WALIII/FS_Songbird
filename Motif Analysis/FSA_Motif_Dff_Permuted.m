function [M_Im_Agg] =  FSA_Motif_Dff_Permuted



counter= 1;
counter2 = 1;
counter3 = 1;

        gifListing = dir(fullfile(pwd,'*tif'));
        gifListing = {gifListing(48:48*2).name};
       for ii = 1:length(gifListing);
         Y{ii} = gifListing{ii}(end-11:end-8);
       end

       disp('Extracting good gif trials');

p = randperm(length(gifListing(1:48)));
for trial = 1:length(gifListing);

    if trial< length(gifListing)/3
        
           Imdat = imread(gifListing{(trial)});
           ImAgg(:,:,counter) = Imdat;
           counter = counter+1;
           clear Imdat;
    elseif trial > length(gifListing)/3 && trial < (length(gifListing)/3)*2
        
           Imdat = imread(gifListing{(trial)});
           ImAgg2(:,:,counter2) = Imdat;
           counter2 = counter2+1;
           clear Imdat;
    elseif trial > (length(gifListing)/3)*2
        try
        Imdat = imread(gifListing{(trial)});
           ImAgg3(:,:,counter3) = Imdat;
           counter3 = counter3+1;
           clear Imdat;
        catch
            disp('bad vids')
        end
    end
       
end

M_Im_Agg(:,:,1) = mean(ImAgg,3);
M_Im_Agg(:,:,2) = mean(ImAgg2,3);
M_Im_Agg(:,:,3) = mean(ImAgg3,3);

end
