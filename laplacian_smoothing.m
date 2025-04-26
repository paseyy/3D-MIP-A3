[v_white, f_white] = read_vtk('lh.white.vtk');
% readjust vertex indices for matlab convention
f_white = f_white + 1;

A = create_laplacian(f_white, v_white);
H = load('lh.white.H.txt');

[v_inf, f_inf] = read_vtk('lh.inflated.vtk');
% carry out the smoothing process
for i=1:10
    % smooth the curvature data...
    H = A * H;
    % ...and the original vertex coordinates
    v_white = A * v_white;
end
write_vtk('lh.inflated.H.10.vtk', v_inf, f_inf, struct('H', H));
write_vtk('lh.white.10.vtk', v_white, f_white-1);

for i=1:10
    H = A * H;
    v_white = A * v_white;
end
write_vtk('lh.inflated.H.20.vtk', v_inf, f_inf, struct('H', H));
write_vtk('lh.white.20.vtk', v_white, f_white-1);

for i=1:20
    H = A * H;
    v_white = A * v_white;
end
write_vtk('lh.inflated.H.40.vtk', v_inf, f_inf, struct('H', H));
write_vtk('lh.white.40.vtk', v_white, f_white-1);

