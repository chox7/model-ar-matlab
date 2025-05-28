function compare_dtf(f, dtf1, dtf2, psd1, psd2, channels, title_plot, labels, dtf_type)
    %COMPARE_DTF Wizualizacja porównawcza miar kierunkowej łączności (DTF/NDTF) i widm mocy.
    %
    %   compare_dtf(f, dtf1, dtf2, psd1, psd2, channels, title_plot, labels, dtf_type)
    %
    %   Funkcja tworzy siatkę wykresów porównujących dwa zestawy miar DTF/NDTF oraz widm mocy (PSD)
    %   dla każdego kierunku interakcji między parami kanałów EEG/MEG/innych sygnałów.
    %
    %   Argumenty:
    %       f          - Wektor częstotliwości [1 x F]
    %       dtf1       - Macierz DTF/NDTF pierwszego warunku [F x n x n]
    %       dtf2       - Macierz DTF/NDTF drugiego warunku [F x n x n]
    %       psd1       - Macierz widm mocy dla kanałów w pierwszym warunku [n x n]
    %       psd2       - Macierz widm mocy dla kanałów w drugim warunku [n x n]
    %       channels   - Komórka z nazwami kanałów {1 x n}
    %       title_plot - Tytuł całej figury (string)
    %       labels     - Etykiety opisujące porównywane warunki {1 x 2}
    %                    (np. lewa/prawa, przed/po)
    %       dtf_type   - Typ zastosowanej miary (np. 'DTF', 'NDTF')
    %
    %   Dla każdej pary kanałów i oraz j, tworzony jest wykres:
    %       - dla i ≠ j: porównanie DTF/NDTF od j do i (wpływ z j na i)
    %       - dla i == j: porównanie widm mocy dla kanału i
    %
    %   Wyniki prezentowane są w formie siatki n x n, gdzie n to liczba kanałów.
    %   Legenda zbiorcza przedstawia oznaczenia kolorów dla obu warunków.

    n = length(channels);
    figure('Name', title_plot, 'Position', [100, 100, 1200, 1200]);  % Większa figura
    tiledlayout(n, n, 'Padding', 'tight', 'TileSpacing', 'compact');  % Kompaktowy układ
  
    for i = 1:n
        for j = 1:n
            nexttile;
            ax = gca;  % Pobranie uchwytu osi

            dtf1_ij = dtf1(:, i, j);
            dtf2_ij = dtf2(:, i, j);


            if i == j
                plot(f, abs(psd1(:, i, j)), 'Color', [135, 206, 235] / 255);  hold on % Błękitny
                plot(f, abs(psd2(:, i, j)), 'Color', [1, 0.5, 0]);  % Pomarańczowy

                plot(NaN, NaN, 'b');
                plot(NaN, NaN, 'r');

            else
                plot(f, dtf1_ij, 'b'); hold on % Niebieski
                plot(f, dtf2_ij, 'r');  %Czerwony
                if dtf_type == "DTF"
                    ylim([0, 1.1]);
                end
            end
            xlim([min(f), max(f)]);

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

    lgd = legend(["Widmo mocy: " + labels(1), "Widmo mocy: " + labels(2), ...
        dtf_type + ": " + labels(1), dtf_type + ": " + labels(2)], ...
        'Location', 'eastoutside', 'Orientation','vertical');
    lgd.Layout.Tile = 'east';
end