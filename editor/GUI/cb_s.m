%%

clc

display('Working ...');
set(lab_log,'str','Working ...');
drawnow;

switch att
    case 1 
        csl = s1;
    case 2 
        csl = s2;
    case 3 
        csl = s3;
    case 4 
        csl = s4;
    case 5 
        csl = s5;
    case 6 
        csl = s6;
    case 7 
        csl = s7;
    case 8 
        csl = s8;
    case 9 
        csl = s9;
    case 10 
        csl = s10;
    case 11 
        csl = s11;
    case 12 
        csl = s12;
    case 13 
        csl = s13;
    case 14 
        csl = s14;    
end

yobj = get(csl,'value');
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
