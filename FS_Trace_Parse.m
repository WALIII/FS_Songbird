function [TRACES] = FS_Trace_Parse(maxNeurons)


  DIR = pwd;
  estNeuronSize = 25;
  AR_p = 2;
  maxITER = 1;

  % Preflight
  addpath(genpath('utilities'));

  % nam = VideoFileName; % insert path to tiff stack here
  % startFrame=1; % user input: first frame to read (optional, default 1)


  % Set parameters
  K = maxNeurons;                       % number of components to be found
  tau = estNeuronSize/2;                  % std of gaussian kernel (size of neuron)
  p = AR_p;                                % order of autoregressive system (p = 0 no dynamics, p=1 just decay, p = 2, both rise and decay)
  merge_thr = 0.80;                      % merging threshold


% Set up directories


  mov_listing=dir(fullfile(DIR,'*.mat'));
  mov_listing={mov_listing(:).name};
  filenames=mov_listing;


  [nblanks formatstring]=fb_progressbar(100);
  fprintf(1,['Progress:  ' blanks(nblanks)]);

for i=1:length(mov_listing)

      [path,file,ext]=fileparts(filenames{i});

  	fprintf(1,formatstring,round((i/length(mov_listing))*100));
      FILE = fullfile(DIR,mov_listing{i})

  load(fullfile(FILE),'audio','video');


[Y, n] = FS_Format(video.frames,1);
Y = Y - min(Y(:));
if ~isa(Y,'double');    Y = double(Y);  end         % convert to double

[d1,d2,T] = size(Y);                                % dimensions of dataset
d = d1*d2;                                          % total number of pixels
width = d1;
height = d2;

% Set options;
options = CNMFSetParms(...
    'd1',d1,'d2',d2,...  % dimensions of datasets
    'search_method','ellipse','dist',1.5,...      % search locations when updating spatial components
    'deconv_method','constrained_foopsi',...     % activity deconvolution method, 'constrained_foopsi'
    'temporal_iter',2,...                       % number of block-coordinate descent steps
    'fudge_factor',0.98,...                     % bias correction for AR coefficients
    'merge_thr',merge_thr,...                    % merging threshold
    'gSig',tau,...
    'init_method','greedy',...        % 'sparse_NMF' or 'greedy'
    'include_noise',0 ...
    );

% Data pre-processing
[P,Y] = preprocess_data(Y,p);

% fast initialization of spatial components using greedyROI and HALS
if i ==1; [A,C,b,f,~] = initialize_components(Y,K,tau,options); end;  % initialize end;

% display centers of found components
% Cn =  correlation_image(Y,8); %max(Y,[],3); %std(Y,[],3); % image statistic (only for display purposes)

Yr = reshape(Y,d,T);
clear Y;
Y = Yr;
for jj=1:maxITER
    % update spatial components
    [A,b,C] = update_spatial_components(Y,C,f,A,P,options);

    % update temporal components
    [C,f,P,S] = update_temporal_components(Y,A,b,C,f,P,options);

    % merge found components
    [A,C,~,~,P,S] = merge_components(Yr,A,b,C,f,P,S,options);
end


end


disp('Extracting Traces');
for i=1:length(mov_listing)

      [path,file,ext]=fileparts(filenames{i});

  	fprintf(1,formatstring,round((i/length(mov_listing))*100));
      FILE = fullfile(DIR,mov_listing{i})

  load(fullfile(FILE),'audio','video');
clear Yr;

[Y, n] = FS_Format(video.frames,1);
Y = Y - min(Y(:));
if ~isa(Y,'double');    Y = double(Y);  end         % convert to double

[d1,d2,T] = size(Y);                                % dimensions of dataset
d = d1*d2;                                          % total number of pixels
width = d1;
height = d2;

Yr = Y;


[A_or,C_or,S_or,~] = order_ROIs(A,C,S,P); % order components
K_m = size(C_or,1);
[C_df,~,~] = extract_DF_F(Yr,[A_or,b],[C_or;f],S_or,K_m+1); % extract DF/F values (optional)

SpatMap = A_or;
CaSignal = C_df(1:end-1,:);

contour_threshold = 0.30;                       % amount of energy used for each component to construct contour plot
figure();hold on;
[contour,Json] = plot_contours(A_or,reshape(Cn,d1,d2),contour_threshold,1); % contour plot of spatial footprints
title('Spatiotemporal Correlation Image');hold off;


TRACES{i}.SpatMap = SpatMap;
TRACES{i}.CaSignal = CaSignal;
TRACES{i}.width = width;
TRACES{i}.height =height;
TRACES{i}.contour =contour;
TRACES{i}.Json = Json;


clear audio; clear video;
end;



%
%
%
%
%
%
%
%
%
%
%
%
%
%   Data.audio = audio.data;
%   save_filename=[ file '_' 'traces'];
%
%   save(fullfile(pwd,[ save_filename '.mat' ]),...
%   		'Data');
%
%   clear data; clear Data;
%   end
%
%
%
%   [SpatMap,CaSignal,width,height,contour,Json] = CaImSegmentation2(data,maxNeurons,estNeuronSize,AR_p,maxITER)
%
%
%
%
%
% % for noiseless video of calcium dynamics
% % myMat = SpatMap*CaSignal;
% % maxColor = max(max(CaSignal));
% % T = size(CaSignal,2);
% % myMat = reshape(myMat,[width,height,T]);
% % figure();
% % for tt=1:T
% %     imagesc(myMat(:,:,tt));colormap jet;colorbar;caxis([0 maxColor]);
% %     pause(5/T)
% % end
% end
