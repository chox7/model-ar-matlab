function wizualizacja_dtf(f, n, dtf, labels)
    figure('Name', 'DTF', 'Position', [100, 100, 1200, 1200]);  % Większa figura
    tiledlayout(n, n, 'Padding', 'tight', 'TileSpacing', 'compact');  % Kompaktowy układ

    for i = 1:n
        for j = 1:n
            nexttile;
            ax = gca;  % Pobranie uchwytu osi

            dtf_ij = dtf(:, i, j);

            if i == j
                plot(f, dtf_ij, 'Color', [1, 0.5, 0]);  % Pomarańczowy
            else
                plot(f, dtf_ij, 'b');  % Niebieski
            end
            ylim([0, 1.1]);

            if i == 1
                title(labels{j}, 'FontSize', 12);
            end

            % Etykiety wierszy (z lewej)
            if j == 1
                ylabel(labels{i}, 'FontSize', 12);  % Nazwa kanału jako etykieta osi Y
            end

            if i ~= n
                set(ax, 'XTickLabel', []);
            end

            if j ~= 1
                set(ax, 'YTickLabel', []);
            end
        end
    end

    sgtitle('DTF');
end
