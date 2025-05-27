function [lewa_array, prawa_array] = cut_signal(syg, tags, fs, t_start, t_end)
    dlugosc = round((t_end - t_start) * fs);
    lewa_list = {};
    prawa_list = {};

    for i = 1:length(tags)
        tag = tags{i};
        t0 = round(tag.position * fs) + 1;
        idx_start = t0;
        idx_end = t0 + dlugosc - 1;

        if idx_start >= 1 && idx_end <= size(syg, 2)
            segment = syg(: , idx_start : idx_end);

            if isfield(tag, 'strona')
                if strcmp(tag.strona, 'lewa')
                    lewa_list{end+1} = segment;
                elseif strcmp(tag.strona, 'prawa')
                    prawa_list{end+1} = segment;
                end
            end
        end
    end

    if ~isempty(prawa_list)
        prawa_array = cat(3, prawa_list{:});
    else 
        prawa_array = [];
    end

    if ~isempty(lewa_list)
        lewa_array = cat(3, lewa_list{:});
    else 
        lewa_array = [];
    end
end