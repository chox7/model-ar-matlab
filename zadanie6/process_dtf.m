function [mean_dtf, mean_ndtf, freqs] = process_dtf(data, rank, fs)
    dtf_list = {};
    ndtf_list = {};

    for i = 1:size(data, 3)
        [dtf, ndtf, freqs] = DTF(data(:, :, i), rank, fs);
        dtf_list{end+1} = dtf;
        ndtf_list{end+1} = ndtf;
    end

    if ~isempty(dtf_list)
        dtf_array = cat(4, dtf_list{:});
    else
        dtf_array = [];
    end

    if ~isempty(ndtf_list)
        ndtf_array = cat(4, ndtf_list{:});
    else
        ndtf_array = [];
    end

    mean_dtf = mean(dtf_array, 4);
    mean_ndtf = mean(ndtf_array, 4);

end