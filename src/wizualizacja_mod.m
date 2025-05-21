function wizualizacja_mod(f, n, S)
    figure('Name', 'Moduł - Gęstość Widmowa Mocy', 'Position', [100, 100, 1000, 1000]);
    tiledlayout(n, n, 'Padding', 'compact');

    for i = 1:n
        for j = 1:n
            nexttile
            if i == j
                plot(f, abs(squeeze(S(:, i, j))), 'Color', [1, 0.5, 0]);  % Pomarańczowy
            else
                plot(f, abs(squeeze(S(:, i, j))), 'b');  % Niebieski
            end
            title(sprintf('Kanał %d vs %d', i, j));
        end
    end

    sgtitle('Moduł - Gęstość Widmowa Mocy');
end