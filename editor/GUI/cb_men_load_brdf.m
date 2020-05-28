%%

clc

delete([ppath '\Core\Python_scripts\brdf_data\*.mat']);
delete([ppath '\Core\Python_scripts\brdf_data\*.binary']);

[inputfile_name, inputfile_path] = uigetfile('*.binary','Select a .binary file',[ppath '\_Save\brdf_0.binary']);

if inputfile_path ~= 0
    
    display('Loading BRDF ...')
    set(lab_log,'str','Loading BRDF ...'); 
    drawnow;
    
    target_file = [ppath '\Core\Python_scripts\brdf_data\brdf.binary'];
    copyfile([inputfile_path inputfile_name],target_file);
   
    [status, ~] = dos(['cd ' scripts_path ' && ' 'python bin2lab.py ' target_file]);
    if status == 1
        set(lab_log,'str','Error loading BRDF');
        error('Error loading BRDF')        
    else
        display('Done!')
        set(lab_log,'str','Load BRDF  : Done!');
    end
    
    load([scripts_path '\brdf_data\brdf.mat']);

    pcL = pcL/100;
    pca = pca/100;
    pcb = pcb/100;
   
end

clear inputfile_name inputfile_path commandstr status target_file ans;

%% Plots

[z_plot,xrange] = calc_slice(pcL,att,alphax,alphay);
draw_slice;
refresh_maps;
refresh_sliders;



