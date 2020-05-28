%% Init FIG

clear
clc
close all;

open('BRDF_GUI_Viewer.fig');

%% Load Path

ppath = which('BRDF_GUI_Viewer.m');
ppath = ppath(1:end-18);
addpath(genpath(ppath));
scripts_path = [ppath '\Core\Python_scripts'];
render_path = [ppath '\BRDF_Explorer'];

%% Init handles

pum_att = findobj(gcf,'Tag','pum_att');
pum_alphay = findobj(gcf,'Tag','pum_alphay');
pum_alphax = findobj(gcf,'Tag','pum_alphax');

ax_m_axes = findobj(gcf,'Tag','m_axes');
ax_axes_a1 = findobj(gcf,'Tag','axes_a1');
ax_axes_a2 = findobj(gcf,'Tag','axes_a2');
ax_axes_a3 = findobj(gcf,'Tag','axes_a3');
ax_axes_a4 = findobj(gcf,'Tag','axes_a4');
ax_axes_a5 = findobj(gcf,'Tag','axes_a5');
ax_axes_scl = findobj(gcf,'Tag','axes_scl');

lab_log = findobj(gcf,'Tag','lab_log');

s1 = findobj(gcf,'Tag','slider1');
s2 = findobj(gcf,'Tag','slider2');
s3 = findobj(gcf,'Tag','slider3');
s4 = findobj(gcf,'Tag','slider4');
s5 = findobj(gcf,'Tag','slider5');
s6 = findobj(gcf,'Tag','slider6');
s7 = findobj(gcf,'Tag','slider7');
s8 = findobj(gcf,'Tag','slider8');
s9 = findobj(gcf,'Tag','slider9');
s10= findobj(gcf,'Tag','slider10');
s11= findobj(gcf,'Tag','slider11');
s12= findobj(gcf,'Tag','slider12');
s13= findobj(gcf,'Tag','slider13');
s14= findobj(gcf,'Tag','slider14');

lab1 = findobj(gcf,'Tag','disp1');
lab2 = findobj(gcf,'Tag','disp2');
lab3 = findobj(gcf,'Tag','disp3');
lab4 = findobj(gcf,'Tag','disp4');
lab5 = findobj(gcf,'Tag','disp5');
lab6 = findobj(gcf,'Tag','disp6');
lab7 = findobj(gcf,'Tag','disp7');
lab8 = findobj(gcf,'Tag','disp8');
lab9 = findobj(gcf,'Tag','disp9');
lab10 = findobj(gcf,'Tag','disp10');
lab11 = findobj(gcf,'Tag','disp11');
lab12 = findobj(gcf,'Tag','disp12');
lab13 = findobj(gcf,'Tag','disp13');
lab14 = findobj(gcf,'Tag','disp14');

bt_render = findobj(gcf,'Tag','bt_render');
bt_pick = findobj(gcf,'Tag','bt_pick');

cb_arender = findobj(gcf,'Tag','checkbox1');
cb_sliders_range = findobj(gcf,'Tag','checkbox2');

%% Init values

att = 1;
alphax = 1;
alphay = 2;

%Just for initialization purposes
load blue-metallic-paint2_pcL;

%% Adjust sliders

att_val = zeros(1,14);
refresh_sliders;

%% Init Plots

colormap(jet);
color_scale = [0,1];
axes(ax_axes_scl);
xrange = [-1.5:0.01:0.5];
z_plot = repmat(linspace(0,1,201),201,1);
h = surf(xrange,xrange,z_plot);
set(h, 'edgecolor','none');
set(ax_axes_scl,'xticklabel',[]);
set(ax_axes_scl,'yticklabel',[]);
axis([-1.5 0.5 -1.5 0.5]);
view([0 90]);
caxis(color_scale);

[z_plot,xrange] = calc_slice(pcL,att,alphax,alphay);
draw_slice;

refresh_maps;

%% Log

set(lab_log,'str','Ready!');

%% BRDF Explorer

dos(['cd ' render_path ' && ' 'render_init.vbs']);














