addpath("../src/")


% Oblicz AIC dla modeli od rzędu 1 do 10
% Wykres

figure;
plot(1:10, AIC_kryterium(10, sinuses), '-o');
xlabel('Rząd modelu AR');
ylabel('Wartość AIC');
title('Kryterium AIC dla modeli AR');
grid on;

%Teoretycznie powinnieśmy wybrać minimum globalne funkcji - p=2 lecz wybór
%nieparzystego współczynnika pomaga zapobiec niebezpieczeństwo pominięcia
%pierwiastka rzeczywistego wśród wcześniej znalezionych residuów

%nie można zbyt "szaleć" ze zbyt wysokim rzędem żeby nie pojechać z nim za
%daleko 

%zatem wybieram p=3

[freqs, k, S_f, AR, Vr] = model_ar(sinuses, 3, 128);

wizualizacja_mod(freqs, k,S_f)
wizualizacja_fazy(freqs, k,S_f)
wizualizacja_mod_coh(freqs, k,S_f)
wizualizacja_fazy_coh(freqs, k,S_f)

% dodaliśmy jeszcze 3 kanał żeby obserwować wpływ większej fazy i większego
% szumu
% Komentarze do otrzymanych wykresów
% Gęstości mocy - cała moc w 32 Hz
% Koherencji - czym mniejsza różnica faz tym większa spójność (większa
% całka pod wykresem)
% Fazy - dodaliśmy pionową kreskę w f_sinus = 32 Hz żeby pokazać że
% widoczne są konkretne różnice w fazach między sinusami


C = partial_coh(freqs, k, S_f);
wizualizacja_mod_coh_partial(freqs, k, C)
wizualizacja_fazy_coh_partial(freqs, k, C)

%

[dtf, ndtf, freqs] = DTF(sinuses, 3, 128);
wizualizacja_ndtf(freqs, k, ndtf);
wizualizacja_dtf(freqs, k, dtf);

[dtf2, ndtf2, freqs] = DTF(sinuses(2:3, :), 3, 128);
wizualizacja_ndtf(freqs, 2, ndtf2);
wizualizacja_dtf(freqs, 2, dtf2);

% w naszej funkcji wizualizacyjnej sinus 2 i 3 nazywamy kanalem 1 i 2 
% w stosunku do DTF na wszystkich kanałach, mamy tu zjawisko że widać
% wzajemny wpływ między badanymi kanałami, ponieważ DTF traktuje jeden jako
% źródłowy