
% Get_Consensus
function [consensus2] = Get_Consensus(A)

for DAY = 1:5;

	[consensus f t]=acontour(A{DAY}.mic_data{1},24400);
	% compute sdi, relevant quantities, store

	ntrials=size(A{DAY}.mic_data,2);
	[rows,columns]=size(consensus);

	consensus=zeros(rows,columns,ntrials,'single');

	parfor j=1:ntrials
		disp([num2str(j) ' of ' num2str(ntrials)]);
		[consensus(:,:,j)]=acontour(A{DAY}.mic_data{j},24400);
	end

	Gconsensus{DAY}=consensus;
clear consensus;
end

consensus = Gconsensus;
    


