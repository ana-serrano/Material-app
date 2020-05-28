%%
load([ppath '\Core\Python_scripts\precompData\hull_new.mat']);
axes(ax_m_axes);

h = surf(xrange,xrange,z_plot);
caxis (color_scale);
set(h, 'edgecolor','none');
xlabel(sprintf('Alpha %d',alphax));
ylabel(sprintf('Alpha %d',alphay));
set(gca,'xlim',[-1.5,0.5]);
set(gca,'ylim',[-1.5,0.5]);
view([0 90]);
hold on;
slice_marker = scatter3(pcL(alphax),pcL(alphay),10,100,'k','filled');
k = boundary(P(:,alphax),P(:,alphay),0);
plot3(P(k,alphax),P(k,alphay),2*ones(length(k)),'LineWidth',2,'Color',[0.5 0.2 0.7])
hold off;

if (alphax == alphay)
   
    ylabel('');
    
end
