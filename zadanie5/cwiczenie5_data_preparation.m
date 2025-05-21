addpath("../src/")
% Data, fs = ...

eegSignal = Data;
num_channels = size(eegSignal, 1);
num_pnts = size(eegSignal, 2);
filteredEEGsignal = zeros((num_channels-2), floor(num_pnts/2));

[B, A] = butter(3, [1, 40] / (fs / 2), 'bandpass');

% Odjęcie sredniej z M1 i M2, filtracja i downsampling
for i = 1:(num_channels - 2)
    tmp = eegSignal(i,:) - (eegSignal(num_channels,:) + eegSignal(num_channels-1,:)) ./ 2;
    tmp = filtfilt(B, A, tmp);
    tmp = tmp(1:2:end);
    filteredEEGsignal(i,:) = tmp;
end
fs_down = floor(fs/2);
num_channels = num_channels-2;


for i = 1:num_channels
    filteredEEGsignal(i, :) = filteredEEGsignal(i, :) / std(filteredEEGsignal(i, :));
end

filteredEEGsignal = filteredEEGsignal(:, floor(3 * 60 * fs_down):floor(4 * 60 * fs_down));

%wybieramy minutę sygnału gdzie alfa jest widoczna
%standaryzujemy wariancję dzieląc przez odchylenie standarowe