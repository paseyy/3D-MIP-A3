% overlay H on the lh.white mesh
[v_white, f_white] = read_vtk('lh.white.vtk');
H = load('lh.white.H.txt');
write_vtk('lh.white.H.vtk', v_white, f_white, struct('H', H));

% overlay H on the inflated mesh
[v_white, f_white] = read_vtk('lh.inflated.vtk');
write_vtk('lh.inflated.H.vtk', v_white, f_white, struct('H', H));