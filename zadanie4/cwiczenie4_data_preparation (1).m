% Parametry
Fs = 128;              % Częstotliwość próbkowania
t = 0:1000 - 1;        % Wektor czasu (w próbkach, nie sekundach)
T = t/Fs;              % Wektor czasu [s]

% Kanał 1: Sinusoida bez przesunięcia fazowego
sin_1 = sin(2*pi*32*(t/Fs));  % 32 Hz, phi = 0

% Kanał 2:
sin_2 = 0.4 * [0, sin_1(1:end-1)];
sin_2 = sin_2 + 0.4 * randn(1, 1000);

% Kanał 3: 
sin_3 = 0.3 * [0, 0, sin_1(1:end-2)];
sin_3 = sin_3 + 0.4 * randn(1, 1000);

% Utworzenie sygnału dwukanałowego
sinuses = zeros(2, 1000);
sinuses(1, :) = sin_1;
sinuses(2, :) = sin_2;
sinuses(3, :) = sin_3;

% Wykres obu kanałów
figure;
plot(T, sinuses(1, :), 'b', 'LineWidth', 1.5); hold on;
plot(T, sinuses(2, :), 'r', 'LineWidth', 1.5);
plot(T, sinuses(3, :), 'g', 'LineWidth', 1.5);
grid on;
xlabel('Czas [s]');
ylabel('Amplituda');
title('Porównanie trzech sygnałów sinusoidalnych');
legend('Kanał 1: Sinus(32 Hz)', 'Kanał 2: 0.4 * Kanał 1(t-1) + Szum', 'Kanał 3: 0.3 * Kanał 1(t-2) + Szum');
