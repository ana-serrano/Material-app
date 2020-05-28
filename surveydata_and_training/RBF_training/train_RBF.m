clear;
close all;
clc;

addpath('kMeans');
addpath('RBF');

load('_final_mtx.mat');
%Each row is a BRDF
%Columns 1 to 14 are the answers for the 14 attributes for that particular BRDF
%Columns 15 to 19 are the 5 PCA components of that particular BRDF
x = MTX(:,15:19);

output_folder = 'trained_RBF_test';
mkdir(output_folder);
for att=1:14   
    y = MTX(:,att);   
    numRBFNeurons = 10;
    normalize = true;
    sigma = 10;
    beta = 1 ./ (2 .* sigma.^2);
    disp('Training the RBFN on the data...');
    [Centers, betas, Theta] = trainFuncApproxRBFN(x, y, numRBFNeurons, normalize, beta, true);
    save(sprintf('%s/RBFN_att_%02d_N_%03d_sigma_%03d_%s.mat',output_folder,att,numRBFNeurons,sigma,date),'Centers','betas','Theta','numRBFNeurons','sigma');
end
 


