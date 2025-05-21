function p_aic_result = AIC_kryterium(p_max, signal)
    
    ch_num = size(signal, 1);          %Liczba kanałów
    N = size(signal, 2);             % Liczba próbek
    p_aic_result = zeros(1, p_max);  % Wyniki AIC dla rzędów 0:p_max
    
    for i = 1:p_max
        [~, Vr] = licz_wsp_AR(signal, i);  % Estymacja modelu AR
        if isscalar(Vr)
            % Jednowymiarowy sygnał
            val = log(Vr);
        else
            % Wielokanałowy – macierz kowariancji
            val = log(det(Vr));
        end
        p_aic_result(i) = val + (2/N) * (i * ch_num^2);  % AIC formula
    end
end

