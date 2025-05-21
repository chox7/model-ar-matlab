function wykresGestosciWidmaMocy(s, Fs)
    % Obliczenie gêstoœci widmowej mocy za pomoc¹ metody Welcha
    window = hamming(256);  % Okno Hamming'a o d³ugoœci 256
    noverlap = 128;         % 128/256=50% nak³adanie
    nfft = 1024;            % liczba punktów FFT
    [P, F] = pwelch(s, window, noverlap, nfft, Fs);

    % Normalizacja gêstoœci widmowej mocy (wzglêdna moc)
    totalPower = sum(P);    % Ca³kowita moc sygna³u
    P_norm = P / totalPower;  % Normalizacja

    figure;    
    % Subplot 1: Gêstoœæ widmowa mocy bez normalizacji
    subplot(1, 2, 1);
    plot(F, P);
    xlabel('f [Hz]');
    ylabel('PSD [V^2/Hz]');
    title('Power Spectral Density');
    xlim([0 40]);
    grid on;
    
    % Subplot 2: Gêstoœæ widmowa mocy z normalizacj¹
    subplot(1, 2, 2);
    plot(F, P_norm);
    xlabel('f [Hz]');
    ylabel('Normalized PSD [1]');
    title('Normalized Power Sepctral Density');
    xlim([0 40]);
    grid on;
end
