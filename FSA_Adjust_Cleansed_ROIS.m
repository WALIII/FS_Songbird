function ROI_data_cleansed = FSA_Adjust_Cleansed_ROIS(ROI_data_cleansed,Adjusted_Filenames)


for iv = 1:size(Adjusted_Filenames,2);
for i = 1:size(ROI_data_cleansed{iv}.filename,2)
   OG = cellstr(ROI_data_cleansed{iv}.filename{1,i}(1:end-4));
    index = find(strcmp(Adjusted_Filenames{iv}{1}, OG));
    
    ROI_data_cleansed{iv}.filename{2,i} = Adjusted_Filenames{iv}{2}(index);
end
end


    

