addpath("../src/")
addpath("../data/mati_ruch/")

channels_to_pick = ["C3", "Cz", "C4", "P3", "Pz", "P4"];
[data, fs, channels, tags] = download_signal("mati_ruch.obci.raw", "mati_ruch.obci.xml", "mati_ruch.obci.tag");
[preprocessed_data, fs_down] = preprocess_data(data, channels, channels_to_pick, fs);


dtf_lewa_list = {};
ndtf_lewa_list = {};
psd_lewa_list = {};
dtf_prawa_list = {};
ndtf_prawa_list = {};
psd_prawa_list = {};

rank = 9;
for t_start = -5:0.5:4
    t_end = t_start + 1;
    [lewa_okno, prawa_okno] = cut_signal(preprocessed_data, tags, fs_down, t_start, t_end);
    [dtf_lewa, ndtf_lewa, psd_lewa, freqs] = process_dtf(lewa_okno, rank, fs_down);
    [dtf_prawa, ndtf_prawa, psd_prawa, freqs] = process_dtf(prawa_okno, rank, fs_down);
    dtf_lewa_list{end+1} = dtf_lewa;
    ndtf_lewa_list{end+1} = ndtf_lewa;
    psd_lewa_list{end+1} = psd_lewa;
    dtf_prawa_list{end+1} = dtf_prawa;
    ndtf_prawa_list{end+1} = ndtf_prawa;
    psd_prawa_list{end+1} = psd_prawa;
end

if ~isempty(dtf_lewa_list)
    dtf_lewa_array = cat(4, dtf_lewa_list{:});
else
    dtf_lewa_array = [];
end

if ~isempty(ndtf_lewa_list)
    ndtf_lewa_array = cat(4, ndtf_lewa_list{:});
else
    ndtf_lewa_array = [];
end

if ~isempty(psd_lewa_list)
    psd_lewa_array = cat(4, psd_lewa_list{:});
else
    psd_lewa_array = [];
end

if ~isempty(dtf_prawa_list)
    dtf_prawa_array = cat(4, dtf_prawa_list{:});
else
    dtf_prawa_array = [];
end

if ~isempty(ndtf_prawa_list)
    ndtf_prawa_array = cat(4, ndtf_prawa_list{:});
else
    ndtf_prawa_array = [];
end

if ~isempty(psd_prawa_list)
    psd_prawa_array = cat(4, psd_prawa_list{:});
else
    psd_prawa_array = [];
end



