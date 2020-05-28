function [att_val] = calc_slice(pcL,att)

    load('./Core/Python_scripts/precompData/hull_normalize.mat');
    load(sprintf('Python_scripts/RBF/trained_RBF/RBFN_att_%02d_N_010_sigma_010_09-Feb-2017.mat',att));
    att_val = (evaluateFuncApproxRBFN(Centers, betas, Theta, true, pcL) - minms(att)) / (maxms(att) - minms(att));
    att_val = str2double(sprintf('%.2f',att_val));
    
end

