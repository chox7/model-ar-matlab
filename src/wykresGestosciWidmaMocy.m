function wykresGestosciWidmaMocy(s, Fs)
    % Obliczenie g�sto�ci widmowej mocy za pomoc� metody Welcha
    window = hamming(256);  % Okno Hamming'a o d�ugo�ci 256
    noverlap = 128;         % 128/256=50% nak�adanie
    nfft = 1024;            % liczba punkt�w FFT
    [P, F] = pwelch(s, window, noverlap, nfft, Fs);

    % Normalizacja g�sto�ci widmowej mocy (wzgl�dna moc)
    totalPower = sum(P);    % Ca�kowita moc sygna�u
    P_norm = P / totalPower;  % Normalizacja

    figure;    
    % Subplot 1: G�sto�� widmowa mocy bez normalizacji
    subplot(1, 2, 1);
    plot(F, P);
    xlabel('f [Hz]');
    ylabel('PSD [V^2/Hz]');
    title('Power Spectral Density');
    xlim([0 40]);
    grid on;
    
    % Subplot 2: G�sto�� widmowa mocy z normalizacj�
    subplot(1, 2, 2);
    plot(F, P_norm);
    xlabel('f [Hz]');
    ylabel('Normalized PSD [1]');
    title('Normalized Power Sepctral Density');
    xlim([0 40]);
    grid on;
end
