function mov = FSA_Format_Mov(mov_data, smooth)
% Format Video data for analysis pipeline
%


cuttoff = 60;

  % format the data appropriately
  mov_data = cat(3, frames(:).cdata);

  % turn to single for memory purposes
  mov_data = single(mov_data);

  % smooth (use a [1/3 1/3 1/3] convolution along the third dimension)
if smooth == 1;
  mov = convn(mov_data, single(reshape([1 1 1] / 3, 1, 1, [])), 'same');
else
  mov = mov_data;
end

% Check data integrity
TERM_LOOP = 0;
for i=1:(length(mov))
  mov_A = mov(:,:,i)
      if mean(mean(mov_A))< cutoff;
        dispword = strcat(' WARNING:  Bad frame(s) detected on frame: ',num2str(i));
        disp(dispword);
        TERM_LOOP = 1;
        mov(:,:,i) = []; % Eliminate the bad frame...
        break
      end
end

% Termoinate if data integrity is comprimised
% if TERM_LOOP ==1;
%     disp(' skipping to nex mov file...')
%     mov= [];
%     continue
% end
