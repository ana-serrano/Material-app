%%

clc
display('Working...')
drawnow;

att = get(pum_att,'value');
alphax = get(pum_alphax,'value');
alphay = get(pum_alphay,'value');

axes(ax_m_axes);
[z_plot,xrange] = calc_slice(pcL,att,alphax,alphay);
draw_slice;

refresh_maps;

clc
display('Done!')
