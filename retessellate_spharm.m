function [H_new, v_new] = retessellate_mesh_spharm(v)
    % load the meshes
    H = load('lh.white.H.txt');
    [v_white, ~] = read_vtk('lh.white.vtk');
    % [v_sphere, f_sphere] = read_vtk('lh.sphere.vtk');

    % compute the spharm bases
    bases_white = [];
    bases_ico = [];
    for L=0:40
       base = spharm_real(v, L);
       bases_white = [bases_white, base];
    
       base = spharm_real(v, L);
       bases_ico = [bases_ico, base];
    end

    % compute the spharm coefficients
    H_coeffs = bases_white \ H;
    xyz_coeffs = bases_white \ v_white;
    
    % reconstruct the data
    H_recon = bases_ico * H_coeffs;
    xyz_recon = bases_ico * xyz_coeffs;

    % return the reconstruction
    H_new = H_recon;
    v_new = xyz_recon;
end

% ICO 4
[v_ico4, f_ico4] = read_vtk('icosphere_mesh/icosphere_4.vtk');
[H_new, v_new] = retessellate_mesh_spharm(v_ico4);

write_vtk('lh.spharm.vtk', v_new, f_ico4, struct('H', H_new));


