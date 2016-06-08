
% Get_Consensus
function [consensus F T] = FS_Get_Consensus(A)
% For freedomScope Birds.


for DAY = 1:5;

	[consensus f t]=acontour(A{DAY}.analogIO_dat{1},48000);
	% compute sdi, relevant quantities, store

	ntrials=size(A{DAY}.analogIO_dat,2);
	[rows,columns]=size(consensus);

	consensus=zeros(rows,columns,ntrials,'single');

	parfor j=1:ntrials
		disp([num2str(j) ' of ' num2str(ntrials)]);
		[consensus(:,:,j)]=acontour(A{DAY}.analogIO_dat{j},48000);
	end

	Gconsensus{DAY}=consensus;
clear consensus;
F{DAY} = f;
T{DAY} = t;
end

consensus = Gconsensus;



