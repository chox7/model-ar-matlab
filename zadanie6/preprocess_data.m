function [preprocessed_data, fs_down] = preprocess_data(data, channels, channels_to_pick, Fs)
    % Get indices of the selected channels
    [~, selected_indices] = ismember(channels_to_pick, channels);

    % Remove any channels not found
    selected_indices = selected_indices(selected_indices > 0);

    num_selected = length(selected_indices);
    num_pnts = size(data, 2);
    
    % Preallocate output
    preprocessed_data = zeros(num_selected, floor(num_pnts / 2));

    % Design bandpass filter
    [B, A] = butter(3, [1, 40] / (Fs / 2), 'bandpass');

    % M1 and M2 are assumed to be the last two channels
    M1 = data(end-1, :);
    M2 = data(end, :);
    avg_M1_M2 = (M1 + M2) / 2;

    % Loop over selected channels
    for i = 1:num_selected
        idx = selected_indices(i);
        tmp = data(idx, :) - avg_M1_M2;
        tmp = filtfilt(B, A, tmp);
        tmp = tmp(1:2:end);  % Downsample by 2
        preprocessed_data(i, :) = tmp;
    end

    fs_down = floor(Fs / 2);
end
