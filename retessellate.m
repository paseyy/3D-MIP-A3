function [H_new, v_new] = retessellate_mesh(v)
    % load the meshes
    H = load('lh.white.H.txt');
    [v_white, f_white] = read_vtk('lh.white.vtk');
    v_white_x = v_white(:, 1);
    v_white_y = v_white(:, 2);
    v_white_z = v_white(:, 3);
    [v_sphere, f_sphere] = read_vtk('lh.sphere.vtk');
    f_sphere = f_sphere + 1;

    [triangles, barys] = triangle_search(f_sphere, v_sphere, v);
    % interpolate the curvature data
    H_new = sum(H(f_sphere(triangles, :)) .* barys, 2);

    v_ico_x = sum(v_white_x(f_sphere(triangles, :)) .* barys, 2);
    v_ico_y = sum(v_white_y(f_sphere(triangles, :)) .* barys, 2);
    v_ico_z = sum(v_white_z(f_sphere(triangles, :)) .* barys, 2);
    v_new = [v_ico_x, v_ico_y, v_ico_z];
end



% ICO 4
[v_ico, f_ico] = read_vtk('icosphere_mesh/icosphere_4.vtk');
[H_ico, v_ico] = retessellate_mesh(v_ico);
write_vtk('lh.ico_4.vtk', v_ico, f_ico, struct('H', H_ico));

% ICO 5
[v_ico, f_ico] = read_vtk('icosphere_mesh/icosphere_5.vtk');
[H_ico, v_ico] = retessellate_mesh(v_ico);
write_vtk('lh.ico_5.vtk', v_ico, f_ico, struct('H', H_ico));

% ICO 6
[v_ico, f_ico] = read_vtk('icosphere_mesh/icosphere_6.vtk');
[H_ico, v_ico] = retessellate_mesh(v_ico);
write_vtk('lh.ico_6.vtk', v_ico, f_ico, struct('H', H_ico));
