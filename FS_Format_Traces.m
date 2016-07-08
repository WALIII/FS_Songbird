function dff2 = FS_Format_Traces(data)

% Created: 05/20/16
% Updated: 05/23/16
% WALIII

% to plot: figure(); for ii = 1: 28; for i = 1:80; hold on; plot(zscore(dff2{i}(:,ii))+ii*5); end; end;


%==============================================%
% Convert if in the freedomsScope format.
if any(strcmp('interp_dff',fieldnames(data))) ==1;
disp('freedomsScope format detected- converting to proper format...')
for trial = 1: size(data.raw_dat,2);
  for cell = 1:size(data.raw_dat,1);
      % INTERPLOLATE
ave_fs = 30;
fs = 48000;

% Get on to the proper timescale by interpolating
timevec = data.raw_time{cell,trial};
ave_time=0:1/ave_fs:size(data.analogIO_dat{trial},1)/fs;
tmp = data.raw_dat{cell,trial};

data.align_detrended{trial}(:,cell) = (interp1(timevec,tmp,ave_time,'spline'));

end
end


else
  disp('Inscopix format assumed- continuing...')

end


maxlag_samps=round(30*.02);

% to export aligned, detrended data:
AD = data.align_detrended;


% Use delta function:
for i = 1: size(data.align_detrended,2)

% detrend and smooth data data
[rows,cols] = size(data.align_detrended{i});
baseline = prctile(data.align_detrended{i},5);
dff= (data.align_detrended{i}-repmat(baseline,[rows 1]))./repmat(baseline,[rows 1]);
dff = tsmovavg((dff*1e2),'s',3,1);
dff2{i} = dff(3:end,:);
end




