function Lnew = new_pcL(L,att,yobj,ppath)
    
    %Load convex hull 
    load([ppath '\Core\Python_scripts\precompData\hull_new.mat']);
    %Load values for normalizing att. values inside hull
    load([ppath '\Core\Python_scripts\precompData\hull_normalize.mat']);
      
    %Calculate inequalities for fmincon (and other params)
    [A, bx] = vert2con(P);
    options = optimoptions('fmincon', 'Algorithm', 'sqp', 'TolFun', 0.007,'TolX', 0.01, 'Display', 'off');
    Aeq = [];
    beq = [];
    lb = [];
    ub = [];
    nonlcon = [];    
    
    yobj = str2double(sprintf('%.2f',yobj));
    xini = L;
    %Edit
    load(sprintf('Python_scripts/RBF/trained_RBF/RBFN_att_%02d_N_010_sigma_010_09-Feb-2017.mat',att));
    fun = @(x) sum((   (sum(Theta(1:end).* [1;(exp(-betas.*sum((repmat(x, numRBFNeurons,1)-Centers).^2,2))/sum(exp(-betas.*sum((repmat(x, numRBFNeurons,1)-Centers).^2,2))))]) - minms(att)) / (maxms(att) - minms(att)) - yobj).^2);
    Lnew = fmincon(fun,xini,A,bx,Aeq,beq,lb,ub,nonlcon,options);
    
end