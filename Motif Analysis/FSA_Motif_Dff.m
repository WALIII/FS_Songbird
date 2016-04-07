function [M_Im_Agg] =  FSA_Motif_Dff
  % FSA_Motif_Dff

  % Seperate Dff Images by motif extraction identifier
  %   Created: 2016/04/07
  %   By: WALIII
  %   Updated: 2016/04/07
  %   By: WALIII

  % FSA_Motif_Dff will do several things:
  %
  %   1. Load in all .tif images in directory, and selerate them into trials
  %      based on the last several digits, i.e. their motif ID.
  %   2. Save a average (mean) of the projections per type



  % Run in the Directory of the .tif files. FSA_Motif_Dff should be run first:
  % FSA_Motif_Dff-->
  %                  IMSMOOTH(M_IM_Agg(:,:,1),M_IM_Agg(:,:,2),M_IM_Agg(:,:,3),M_IM_Agg(:,:,2),M_IM_Agg(:,:,2),ROI)




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
