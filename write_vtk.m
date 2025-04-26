% write_vtk for legacy vtk
% Ilwoo Lyu, ilwoolyu@gmail.com
% Release: Apr 4, 2020
% Update: Apr 4, 2020

function write_vtk(fn, v, f, attr)
    fp = fopen(fn, 'w');
    fprintf(fp, '# vtk DataFile Version 3.0\nvtk output\nASCII\nDATASET POLYDATA\n');
    fprintf(fp, 'POINTS %d float\n', size(v, 1));
    fprintf(fp, '%f %f %f\n', v');
    fprintf(fp, 'POLYGONS %d %d\n', size(f, 1), size(f, 1) * 4);
    fprintf(fp, '3 %d %d %d\n', f');

    if nargin == 4
        fprintf(fp, 'POINT_DATA %d\n', size(v, 1));
        fprintf(fp, 'FIELD ScalarData %d\n', numel(fieldnames(attr)));
        names = fieldnames(attr);
        for i = 1: numel(fieldnames(attr))
            fprintf(fp, '%s 1 %d float\n', names{i}, size(v, 1));
            fprintf(fp, '%f\n', getfield(attr, names{i}));
        end
    end

    fclose(fp);
end