%%

clc

if ~(exist('pca','var') && exist('pcb','var') && exist ('pcL','var'))
    
    set(lab_log,'str','Error : Load a base BRDF First !');
    error('Load a base BRDF First !')
    
end

delete([ppath '\Core\Python_scripts\brdf_data\*.mat']);
delete([ppath '\Core\Python_scripts\brdf_data\*.binary']);

[outputfile_name, outputfile_path] = uiputfile({'*.binary'},'Save as .binary file',[ppath '\_Save\brdf_0.binary']);

if outputfile_path ~= 0
    
    display('Saving BRDF ...')
    set(lab_log,'str','Saving BRDF ...');
    drawnow;
    
    pcL = pcL*100;
    pca = pca*100;
    pcb = pcb*100;
    
    target_file = [ppath '\Core\Python_scripts\brdf_data\brdf.mat'];
        
    save(target_file,'pcL','pca','pcb');
       
    [status, ~] = dos(['cd ' scripts_path ' && ' 'python lab2bin.py ' target_file]);
    if status == 1
        set(lab_log,'str','Error saving BRDF');
        error('Error saving BRDF')        
    else
        display('Done!')
        set(lab_log,'str','Save BRDF  : Done!');
    end
    
    copyfile([ppath '\Core\Python_scripts\brdf_data\brdf.binary'],[outputfile_path outputfile_name]);
    
    pcL = pcL/100;
    pca = pca/100;
    pcb = pcb/100;
   
end

clear inputfile_name inputfile_path target_file ans;




