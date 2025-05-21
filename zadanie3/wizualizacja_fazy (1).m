function wizualizacja_fazy(f, n, S)
    figure('Name', 'Fazy - Gęstość Widmowa Mocy', 'Position', [100, 100, 1000, 1000]);
    tiledlayout(n, n, 'Padding', 'compact');

    for i = 1:n
        for j = 1:n
            nexttile
            faza = angle(squeeze(S(:, i, j)));
            if i == j
                plot(f, faza, 'Color', [1, 0.5, 0]);  % Pomarańczowy
                ylim([-pi, pi]);
            else
                plot(f, faza, 'b');  % Niebieski
                %xlim([0, 62]);
                ylim([-pi, pi]);
                xline(32, '-', {'f_{sinus} = 32'});
            end
            title(sprintf('Kanał %d vs %d', i, j));
        end
    end

    sgtitle('Faza - Gęstość Widmowa Mocy');
end