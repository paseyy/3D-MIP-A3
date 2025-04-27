function A = create_laplacian(f, v)
    A = create_adjacencies(f);
    
    % compute the distances between all adjacent vertices
    [ii, jj] = find(A);
    distances_vec = vecnorm(v(ii,:) - v(jj,:), 2, 2);
    % distances = sparse(ii, jj, distances_vec);
    
    % convert distances to gaussian weight
    std = mean(distances_vec);
    weights_vec = exp(-(distances_vec.^2) / (2 * std^2));
    weights = sparse(ii, jj, weights_vec, size(A,1), size(A,2));

    % normalize the rows
    row_sums = full(sum(weights, 2));
    A = weights ./ row_sums;
    
    % assert that the rows are properly normalized
    assert(all(sum(A, 2) - ones(size(A, 1), 1) < 0.001));
    % assert that the diagonal is zero
    assert(all(diag(A) == 0));
end