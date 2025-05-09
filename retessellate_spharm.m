function [H_new, v_new] = retessellate_mesh_spharm(v, max_L)
    % load the meshes
    H = load('lh.white.H.txt');
    [v_white, ~] = read_vtk('lh.white.vtk');
    [v_sphere, ~] = read_vtk('lh.sphere.vtk');

    % compute the spharm bases
    bases_sphere = [];
    bases_ico = [];
    for L=0:max_L
       base = spharm_real(v_sphere, L);
       bases_sphere = [bases_sphere, base];
    
       base = spharm_real(v, L);
       bases_ico = [bases_ico, base];
    end

    % compute the spharm coefficients
    H_coeffs = bases_sphere \ H;
    xyz_coeffs = bases_sphere \ v_white;
    
    % reconstruct the data
    H_recon = bases_ico * H_coeffs;
    xyz_recon = bases_ico * xyz_coeffs;

    % return the reconstruction
    H_new = H_recon;
    v_new = xyz_recon;
end

% ICO 4
[v_ico4, f_ico4] = read_vtk('icosphere_mesh/icosphere_4.vtk');
[H_new, v_new] = retessellate_mesh_spharm(v_ico4, 10);
write_vtk('lh.spharm10.4.vtk', v_new, f_ico4, struct('H', H_new));
[H_new, v_new] = retessellate_mesh_spharm(v_ico4, 20);
write_vtk('lh.spharm20.4.vtk', v_new, f_ico4, struct('H', H_new));
[H_new, v_new] = retessellate_mesh_spharm(v_ico4, 40);
write_vtk('lh.spharm40.4.vtk', v_new, f_ico4, struct('H', H_new));

% ICO 5
[v_ico5, f_ico5] = read_vtk('icosphere_mesh/icosphere_5.vtk');
[H_new, v_new] = retessellate_mesh_spharm(v_ico5, 10);
write_vtk('lh.spharm10.5.vtk', v_new, f_ico5, struct('H', H_new));
[H_new, v_new] = retessellate_mesh_spharm(v_ico5, 20);
write_vtk('lh.spharm20.5.vtk', v_new, f_ico5, struct('H', H_new));
[H_new, v_new] = retessellate_mesh_spharm(v_ico5, 40);
write_vtk('lh.spharm40.5.vtk', v_new, f_ico5, struct('H', H_new));

% ICO 6
[v_ico6, f_ico6] = read_vtk('icosphere_mesh/icosphere_6.vtk');
[H_new, v_new] = retessellate_mesh_spharm(v_ico6, 10);
write_vtk('lh.spharm10.6.vtk', v_new, f_ico6, struct('H', H_new));
[H_new, v_new] = retessellate_mesh_spharm(v_ico6, 20);
write_vtk('lh.spharm20.6.vtk', v_new, f_ico6, struct('H', H_new));
[H_new, v_new] = retessellate_mesh_spharm(v_ico6, 40);
write_vtk('lh.spharm40.6.vtk', v_new, f_ico6, struct('H', H_new));


