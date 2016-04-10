function [Adjusted_Filenames] = FSA_Adjust_MotifNo(sorted_syllable, filenames)

counter3 = 1; % Placeholder for all data;
for i = 1:size(filenames,2)
counter = 1; % for old data, and placeholder
counter2 = 1; % for new data
   FN = filenames{i}(1:end-4);
    for ii = 1:size(sorted_syllable{i},1)
        place = [1:size(sorted_syllable{i},1)];

if sorted_syllable{i}(ii) < (220*24400)/48000;
    Old_FileName{counter3} = [];
    New_FileName{counter3} = strcat(FN,'_000',num2str(counter2));
    counter2 = counter2+1;
    counter3 = counter3+1;
else
Old_FileName{counter3} = strcat(FN,'_000',num2str(counter));
New_FileName{counter3} = strcat(FN,'_000',num2str(counter2));
counter2 = counter2+1;
counter = counter+1;
counter3 = counter3+1;
end
    end
    
end

Adjusted_Filenames{:,1} = Old_FileName;
Adjusted_Filenames{:,2} = New_FileName;


