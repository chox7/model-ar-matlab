function [DTF, NDTF, freqs] = DTF(dane, p, Fs)

    % Przygotowanie wektora częstotliwości
    freqs = 0:(1/Fs):39;

    % Upewnij się, że dane są w formacie [kanały x próbki]
    if isvector(dane)
        dane = reshape(dane, 1, []);
    end

    [AR, Vr] = licz_wsp_AR(dane, p);  % Zakładamy, że mult_AR działa jak w Pythonie
    k = size(dane, 1);            % Liczba kanałów
    nf = length(freqs);          % Liczba punktów częstotliwości

    % Przygotuj macierze zespolone
    A_f = zeros(nf, k, k);
    H_f = zeros(nf, k, k);
    H_f_conj_hermit = zeros(nf, k, k);
    S_f = zeros(nf, k, k);

    % Transformacja Z dla każdej częstotliwości
    for i = 1:nf
        f = freqs(i);
        z = exp(1i * 2 * pi * f / Fs);
        A0 = eye(k);
        for j = 1:p
            A0 = A0 - squeeze(AR(:, :, j)) * z^(-j);
        end

        A_f(i, :, :) = A0;
        H = inv(A0);
        H_f(i, :, :) = H;
        H_f_conj_hermit(i, :, :) = H';  % Sprzężenie hermitowskie

        % Widmo mocy sygnału
        temp = H * Vr;
        S_f(i, :, :) = temp * H';
    end

    licznik = abs(H_f).^2;
   
    DTF = zeros(nf, k, k);
    for f = 1:nf
        for i = 1:k
            mianownik_sum = 0;
            for m = 1:k
                mianownik_sum = mianownik_sum + abs(H_f(f, i, m)).^2;
            end

            DTF(f, i, 1:end) = licznik(f, i, 1:end)./ mianownik_sum;
        end
    end



    NDTF = licznik;
    %DTF = licznik./mianownik;
end



