function wizualizacja_mod_coh_partial(f, n, C)
    figure('Name', 'Moduł - Koherencja cząstkowa', 'Position', [100, 100, 1000, 1000]);
    tiledlayout(n, n, 'Padding', 'compact');

    for i = 1:n
        for j = 1:n
            nexttile

            modul = abs(squeeze(C(:, i, j)));
            if i == j
                plot(f, modul, 'Color', [1, 0.5, 0]);  % Pomarańczowy
            else
                plot(f, modul, 'b');
                xline(32, '-', {'f_{sinus} = 32'});
            end

            ylim([0, 1.2]);
            title(sprintf('Kanał %d vs %d', i, j));
        end
    end

    sgtitle('Moduł - Koherencja cząstkowa');
end
