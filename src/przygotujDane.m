function [sygnalO1, fs_down] = przygotujDane(eegSignal, Fs)

    num_channels = size(eegSignal, 1);
    num_pnts = size(eegSignal, 2);
    filteredEEGsignal = zeros((num_channels-2), floor(num_pnts/2));
    
    [B, A] = butter(3, [1, 40] / (Fs / 2), 'bandpass');

    % Odjêcie œredniej z M1 i M2, filtracja i downsampling
    for i = 1:(num_channels - 2)
        tmp = eegSignal(i,:) - (eegSignal(num_channels,:) + eegSignal(num_channels-1,:)) ./ 2;
        tmp = filtfilt(B, A, tmp);
        tmp = tmp(1:2:end);
        filteredEEGsignal(i,:) = tmp;
    end

    % Wyciêcie 15 sekund z elektrody O1 (od 3 minuty)
    sygnalO1 = filteredEEGsignal(num_channels - 3, round(3 * 60 * 128) : round(3.25 * 60 * 128));
    fs_down = floor(Fs/2);
end
