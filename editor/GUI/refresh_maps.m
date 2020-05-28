%%

axes(ax_axes_a1);
[z_plot,xrange] = calc_map(pcL,att,1);
h = surf(xrange,xrange,z_plot);
set(h, 'edgecolor','none');
set(ax_axes_a1,'xticklabel',[]);
set(ax_axes_a1,'yticklabel',[]);
axis([-1.5 0.5 -1.5 0.5]);
view([0 90]);
caxis(color_scale);
hold on;
scatter3(pcL(1),-0.30,max(max(z_plot)),100,'k','filled');
hold off;

axes(ax_axes_a2);
[z_plot,xrange] = calc_map(pcL,att,2);
h = surf(xrange,xrange,z_plot);
set(h, 'edgecolor','none');
set(ax_axes_a2,'xticklabel',[]);
set(ax_axes_a2,'yticklabel',[]);
axis([-1.5 0.5 -1.5 0.5]);
view([0 90]);
caxis(color_scale);
hold on;
scatter3(pcL(2),-0.30,max(max(z_plot)),100,'k','filled');
hold off;

axes(ax_axes_a3);
[z_plot,xrange] = calc_map(pcL,att,3);
h = surf(xrange,xrange,z_plot);
set(h, 'edgecolor','none');
set(ax_axes_a3,'xticklabel',[]);
set(ax_axes_a3,'yticklabel',[]);
axis([-1.5 0.5 -1.5 0.5]);
view([0 90]);
caxis(color_scale);
hold on;
scatter3(pcL(3),-0.30,max(max(z_plot)),100,'k','filled');
hold off;

axes(ax_axes_a4);
[z_plot,xrange] = calc_map(pcL,att,4);
h = surf(xrange,xrange,z_plot);
set(h, 'edgecolor','none');
set(ax_axes_a4,'xticklabel',[]);
set(ax_axes_a4,'yticklabel',[]);
axis([-1.5 0.5 -1.5 0.5]);
view([0 90]);
caxis(color_scale);
hold on;
scatter3(pcL(4),-0.30,max(max(z_plot)),100,'k','filled');
hold off;

axes(ax_axes_a5);
[z_plot,xrange] = calc_map(pcL,att,5);
h = surf(xrange,xrange,z_plot);
set(h, 'edgecolor','none');
set(ax_axes_a5,'xticklabel',[]);
set(ax_axes_a5,'yticklabel',[]);
axis([-1.5 0.5 -1.5 0.5]);
view([0 90]);
caxis(color_scale);
hold on;
scatter3(pcL(5),-0.30,max(max(z_plot)),100,'k','filled');
hold off;


