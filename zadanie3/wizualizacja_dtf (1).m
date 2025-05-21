function wizualizacja_dtf(f, n, dtf)
    figure('Name', 'DTF', 'Position', [100, 100, 1000, 1000]);
    tiledlayout(n, n, 'Padding', 'compact');

    for i = 1:n
        for j = 1:n
            nexttile

            dtf_ij = dtf(1:end, i, j);

            if i == j
                plot(f, dtf_ij, 'Color', [1, 0.5, 0]);  % Pomarańczowy
            else
                plot(f, dtf_ij, 'b');  % Niebieski
            end
            ylim([0, 1.1]);

            title(sprintf('Z kanału %d do %d', j, i));
        end
    end

    sgtitle('DTF');
end
