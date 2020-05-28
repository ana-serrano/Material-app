%%

axes(ax_m_axes);
[pcL(alphax),pcL(alphay)] = ginput(1);

hold on;
delete(slice_marker);
slice_marker = scatter3(pcL(alphax),pcL(alphay),10,100,'k','filled');
hold off;

refresh_maps;
refresh_sliders;




