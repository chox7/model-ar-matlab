function compare_tf_map(t, f, dtf, psd, channels, title_plot, dtf_type)
    %COMPARE_DTF Wizualizacja porównawcza miar kierunkowej łączności (DTF/NDTF) i widm mocy.
    %
    %   compare_dtf(f, dtf, psd, channels, title_plot, dtf_type)
    %
    %   Funkcja tworzy siatkę wykresów miar DTF/NDTF oraz widm mocy (PSD)
    %   dla każdego kierunku interakcji między parami kanałów EEG.
    %
    %   Argumenty:
    %       t          - Wektor czasu (1 x T)
    %       f          - Wektor częstotliwości [1 x F]
    %       dtf        - Macierz DTF/NDTF [F x n x n X T]
    %       psd        - Macierz widm mocy dla kanałów [F x n x T]
    %       channels   - Komórka z nazwami kanałów {1 x n}
    %       title_plot - Tytuł całej figury (string)
    %       dtf_type   - Typ zastosowanej miary (np. 'DTF', 'NDTF')
    %
    %   Dla każdej pary kanałów i oraz j, tworzony jest wykres:
    %       - dla i ≠ j: DTF/NDTF od j do i (wpływ z j na i)
    %       - dla i == j: widm mocy dla kanału i
    %
    %   Wyniki prezentowane są w formie siatki n x n, gdzie n to liczba kanałów.

    n = length(channels);
    figure('Name', title_plot, 'Position', [100, 100, 1200, 1200]);  % Większa figura
    tiledlayout(n, n, 'Padding', 'tight', 'TileSpacing', 'compact');  % Kompaktowy układ
    c_max = max(abs(psd(:)));
    for i = 1:n
        for j = 1:n
            nexttile;
            ax = gca;  % Pobranie uchwytu osi

            dtf_ij = squeeze(dtf(:, i, j, :));

            if i == j
                imagesc('XData', t, 'YData', f, 'CData', squeeze(abs(psd(:, i, j, :))));
            else
                imagesc('XData', t, 'YData', f, 'CData', dtf_ij);
            end
            set(gca, 'YDir', 'normal');  % lub 'reverse'
            %caxis([0, c_max]);
            %xlim([min(f), max(f)]);

            if i == 1
                title("Z " + channels{j}, 'FontSize', 12);
            end

            % Etykiety wierszy (z lewej)
            if j == 1
                ylabel("Do "+ channels{i}, 'FontSize', 12);  % Nazwa kanału jako etykieta osi Y
            end

            if i ~= n
                set(ax, 'XTickLabel', []);
            end

            if j ~= 1
                set(ax, 'YTickLabel', []);
            end
        end
    end
    sgtitle(title_plot);
end