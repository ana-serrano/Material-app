function [z_plot,xrange] = calc_map(pcL,att,alphax)
% CALCULATE PLOT OF THE FUNCTION (2D SLICE)

load(sprintf('Python_scripts/RBF/trained_RBF/RBFN_att_%02d_N_010_sigma_010_09-Feb-2017.mat',att));
load('./Core/Python_scripts/precompData/hull_normalize.mat');

xrange = [-1.5:0.01:0.5];

for i=1:length(xrange)
        pcL(alphax) = xrange(i);
        z_plot(i) = (evaluateFuncApproxRBFN(Centers, betas, Theta, true, pcL) - minms(att)) / (maxms(att) - minms(att));
end

z_plot = repmat(z_plot,length(xrange),1);

end

