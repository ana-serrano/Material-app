%%

clc

display('Working ...');
set(lab_log,'str','Working ...');
drawnow;

switch att
    case 1 
        csl = lab1;
    case 2 
        csl = lab2;
    case 3 
        csl = lab3;
    case 4 
        csl = lab4;
    case 5 
        csl = lab5;
    case 6 
        csl = lab6;
    case 7 
        csl = lab7;
    case 8 
        csl = lab8;
    case 9 
        csl = lab9;
    case 10 
        csl = lab10;
    case 11 
        csl = lab11;
    case 12 
        csl = lab12;
    case 13 
        csl = lab13;
    case 14 
        csl = lab14;    
end

yobj = str2double(get(csl,'string'));
pcL = new_pcL(pcL,att,yobj,ppath);

%%

att = get(pum_att,'value');
[z_plot,xrange] = calc_slice(pcL,att,alphax,alphay);
draw_slice;
refresh_maps;
refresh_sliders;

%%

if (get(cb_arender,'value') == 1)
    cb_render;
end

display('Done!');
set(lab_log,'str','Done!');

clear csl;
