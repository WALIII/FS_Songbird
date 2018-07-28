function output = FS_bootstrap(input,B)
% Replicate the data
input = input;
n = size(input,2);
xRepl = repmat(input,B,1);
% Random permutaiton of 1,...,B*n
u = randperm(n*B);
% Loop over B bootstraps
for b=1:B
  % Uniform random numbers over 1...n
    ind = ceil(n*rand(n,1));
%     ind = n*(b-1)+(1:n);
    xb(b,:) = xRepl(u(ind));
end
output = xb(:);
% figure(); 
% subplot(121)
% histogram(xb,10)
% subplot(122)
% histogram(input,10)


