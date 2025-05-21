function wizualizacja_ndtf(f, n, ndtf)
    figure('Name', 'NDTF', 'Position', [100, 100, 1000, 1000]);
    tiledlayout(n, n, 'Padding', 'compact');

    for i = 1:n
        for j = 1:n
            nexttile

            ndtf_ij = ndtf(1:end, i, j);

            if i == j
                plot(f, ndtf_ij, 'Color', [1, 0.5, 0]);  % Pomarańczowy
            else
                plot(f, ndtf_ij, 'b');  % Niebieski
            end

            ylim([0, max(ndtf, [], "all")]);

            title(sprintf('Z kanału %d do %d', j, i));
        end
    end

    sgtitle('NDTF');
end
