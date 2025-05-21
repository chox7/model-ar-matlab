function wizualizacja_mod_coh(f, n, S)
    figure('Name', 'Moduł - Koherecja', 'Position', [100, 100, 1000, 1000]);
    tiledlayout(n, n, 'Padding', 'compact');

    for i = 1:n
        for j = 1:n
            nexttile

            % Liczenie modułu spójności: |S_ij| / sqrt(S_ii * S_jj)
            S_ij = squeeze(S(:, i, j));
            S_ii = squeeze(S(:, i, i));
            S_jj = squeeze(S(:, j, j));
            m = sqrt(S_ii .* S_jj);
            coh = abs(S_ij ./ m);

            if i == j
                plot(f, coh, 'Color', [1, 0.5, 0]);  % Pomarańczowy
            else
                plot(f, coh, 'b');  % Niebieski
            end

            title(sprintf('Kanał %d vs %d', i, j));
            ylim([0, 1.1]);
        end
    end

    sgtitle('Moduł - Koherecja');
end
