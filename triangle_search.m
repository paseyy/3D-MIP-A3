function [r_triangles, r_bary] = triangle_search(f_brain, v_brain, v_ico)
    % initialization
    Q = v_ico;
    Q_not_found = [];
    k = 1;
    MD = KDTreeSearcher(v_brain);
    tr = triangulation(f_brain, v_brain);
    N = faceNormal(tr);
    closest_triangles = zeros(size(Q, 1), 1);
    closest_triangles_coeffs = zeros(size(Q, 1), 3);

    % main loop
    while any(Q ~= 0)
        for i=1:size(Q, 1)
            q = Q(i, :);
            if q == 0
                continue
            end
            % find k nearest neighbors
            p = MD.knnsearch(q, 'k', k, 'distance', 'euclidean');
            T = tr.vertexAttachments(p'); % a set of triangles to p
            T = unique(horzcat(T{:}));

            for j=1:size(T, 2)
                triangle_idx = T(j);
                triangle = f_brain(triangle_idx, :);

                % project query point onto the triangle
                triangle_points = v_brain(triangle, :);
                normal = N(triangle_idx, :);
                q_proj = proj(q, triangle_points, normal);

                bary = tr.cartesianToBarycentric(triangle_idx, q_proj);
                if all(bary >= 0)
                    % store this triangle as closest one to q
                    closest_triangles(i) = triangle_idx;
                    % store barycentric coeffs
                    closest_triangles_coeffs(i, :) = bary;

                    Q(i, :) = 0;
                    break
                end
            end
        end
        % increase search range
        k = k+1;
    end

    r_triangles = closest_triangles;
    r_bary = closest_triangles_coeffs;
end

function projected = proj(q, triangle, normal)
    distance = (triangle(1, :) * normal') / (q * normal');
    projected = q * distance;
end
