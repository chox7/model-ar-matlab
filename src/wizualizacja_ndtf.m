function wizualizacja_ndtf(f, n, ndtf, labels)
    figure('Name', 'NDTF', 'Position', [100, 100, 1200, 1200]);  % Większa figura
    tiledlayout(n, n, 'Padding', 'tight', 'TileSpacing', 'compact');  % Kompaktowy układ

    for i = 1:n
        for j = 1:n
            nexttile;
            ax = gca;  % Pobranie uchwytu osi

            ndtf_ij = ndtf(:, i, j);

            if i == j
                plot(f, ndtf_ij, 'Color', [1, 0.5, 0]);  % Pomarańczowy
            else
                plot(f, ndtf_ij, 'b');  % Niebieski
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

    sgtitle('NDTF');
end
