function wizualizacja_fazy_coh_partial(f, n, C)
    figure('Name', 'Faza - Koherencja cząstkowa', 'Position', [100, 100, 1000, 1000]);
    tiledlayout(n, n, 'Padding', 'compact');

    for i = 1:n
        for j = 1:n
            nexttile

            faza =angle(squeeze(C(:, i, j)));
            if i == j
                plot(f, faza, 'Color', [1, 0.5, 0]);  % Pomarańczowy
            else
                plot(f, faza, 'b');
                xline(32, '-', {'f_{sinus} = 32'});
            end

            ylim([-pi, pi]);
            title(sprintf('Kanał %d vs %d', i, j));
        end
    end

    sgtitle('Faza - Koherencja cząstkowa');
end
