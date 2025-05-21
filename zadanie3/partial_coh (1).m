function C = partial_coh(f, n, S)
    % Rozmiar danych: S(freq, n, n)
    [freq_len, ~, ~] = size(S);
    C = complex(zeros(freq_len, n, n));
    
    for k = 1:freq_len
        Sk = squeeze(S(k, :, :));  % Macierz n x n dla jednej częstotliwości
        Dk = inv(Sk);              % Odwrotność

        for i = 1:n
            for j = 1:n
                C(k, i, j) = ((-1)^(i + j)) * (Dk(j, i) / sqrt(Dk(i, i) * Dk(j, j)));
            end
        end
    end
end