% creates an adjacency matrix from a list of faces
function adjacency = create_adjacencies(faces)
    n = size(faces, 1);

    list = zeros(6*n, 2);
    for row = 1:n
        face = faces(row, :);
        
        % generate all pairings of vertices (= edges) using nchoosek
        % also flip them to guarantee bidirectionality
        nck = nchoosek(face, 2);
        new_adjacencies = [nck; flip(nck, 2)];
        list(6*row-5:6*row, :) = new_adjacencies;
    end

    % remove duplicates
    list = unique(list, "rows");

    % crate the sparse binary adjacency matrix
    adjacency = sparse(list(:, 1), list(:, 2), ones(size(list, 1), 1));
    assert(issymmetric(adjacency));
end