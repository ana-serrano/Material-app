%%

selection = questdlg('Exit?',' ','Yes','No','No');             

switch selection, 
    case 'Yes',
         delete(gcf)         
    case 'No'
    clear selection;
    return 
end

if strcmp(selection,'Yes')

selection = questdlg('Clear Console and Workspace?',' ','Yes','No','No');             

switch selection, 
    case 'Yes',
        clear all;
        clc;       
    case 'No'
    return 
end

end

close all;


