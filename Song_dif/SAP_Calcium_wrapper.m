
% Wrapper for Ca imaging...

function SAP_Calcium_wrapper(A);


for i = 1:5
[DAT] = SAP_Calcium(A,i)
DAT_tot{i} = DAT;
end


figure();
      title('Ca++ data compaed to Smoothed RMS song')
      xlabel('Ca Imaging Similarity')
      ylabel('Smoothed Song Similarity')
c = {'*r','*g','*b','*c','*m'};
for i = 1:5
    for ii = 1:size(DAT_tot{i}.M_Ca,2)
    hold on;
    plot(DAT_tot{i}.M_Ca{ii},DAT_tot{i}.Son{ii},c{i});
    end
end


figure();
c = {'*r','*g','*b','*c','*m'};
for i = 1:5
    for ii = 1:size(DAT_tot{i}.M_Ca,2)
    hold on;
    plot(DAT_tot{i}.M_Ca{ii},DAT_tot{i}.song_gravity_center{ii},c{i});
    end
end
