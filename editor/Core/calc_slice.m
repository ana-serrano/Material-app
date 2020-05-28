function [z_plot,xrange] = calc_slice(pcL,att,alphax,alphay)

load(sprintf('Python_scripts/RBF/trained_RBF/RBFN_att_%02d_N_010_sigma_010_09-Feb-2017.mat',att));
load('./Core/Python_scripts/precompData/hull_normalize.mat');

xrange = [-1.5:0.01:0.5];
z_plot = zeros(length(xrange));

for i=1:length(xrange)
    pcL(alphay) = xrange(i);
    for j=1:length(xrange)        
        pcL(alphax) = xrange(j);
        z_plot(i,j) = (evaluateFuncApproxRBFN(Centers, betas, Theta, true, pcL) - minms(att)) / (maxms(att) - minms(att));

    end
end

end





