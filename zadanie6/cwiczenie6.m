addpath("../src/")
addpath("../data/mati_ruch/")

[data, fs, channels, tags] = download_signal("mati_ruch.obci.raw", "mati_ruch.obci.xml", "mati_ruch.obci.tag");

channels_to_pick = ["C3", "Cz", "C4", "P3", "Pz", "P4"];
[preprocessed_data, fs_down] = preprocess_data(data, channels, channels_to_pick, fs);

[lewa_przed, prawa_przed] = cut_signal(preprocessed_data, tags, fs_down, -4, -2);
[lewa_po, prawa_po] = cut_signal(preprocessed_data, tags, fs_down, 0.5, 2.5);


% Obliczanie DTF, NDTF, PSD
rank = 9;
[dtf_lewa_przed, ndtf_lewa_przed, psd_lewa_przed, freqs] = process_dtf(lewa_przed, rank, fs_down);
[dtf_prawa_przed, ndtf_prawa_przed, psd_prawa_przed, freqs] = process_dtf(prawa_przed, rank, fs_down);
[dtf_lewa_po, ndtf_lewa_po, psd_lewa_po, freqs] = process_dtf(lewa_po, rank, fs_down);
[dtf_prawa_po, ndtf_prawa_po, psd_prawa_po, freqs] = process_dtf(prawa_po, rank, fs_down);

% Wykresy DTF
% Skala dla y:
% - dla dtf: 0 - 1.1
% - dla psd: 0 - max(psd)
compare_dtf(freqs, dtf_lewa_przed, dtf_prawa_przed, psd_lewa_przed, psd_prawa_przed, channels_to_pick, "DTF lewa/prawa przed", ["lewa", "prawa"], "DTF");
compare_dtf(freqs, dtf_lewa_po, dtf_prawa_po, psd_lewa_po, psd_prawa_po, channels_to_pick, "DTF lewa/prawa po", ["lewa", "prawa"], "DTF");

compare_dtf(freqs, dtf_lewa_przed, dtf_lewa_po, psd_lewa_przed, psd_lewa_po, channels_to_pick, "DTF lewa przed/po", ["przed", "po"], "DTF");
compare_dtf(freqs, dtf_prawa_przed, dtf_prawa_po, psd_prawa_przed, psd_prawa_po, channels_to_pick, "DTF prawa przed/po", ["przed", "po"], "DTF");

% Wykresy NDTF
% Skala dla y: 0 - max(psd)
compare_dtf(freqs, ndtf_lewa_przed, ndtf_prawa_przed, psd_lewa_przed, psd_prawa_przed, channels_to_pick, "NDTF lewa/prawa przed", ["lewa", "prawa"], "NDTF");
compare_dtf(freqs, ndtf_lewa_po, ndtf_prawa_po, psd_lewa_po, psd_prawa_po, channels_to_pick, "NDTF lewa/prawa po", ["lewa", "prawa"], "NDTF");

compare_dtf(freqs, ndtf_lewa_przed, ndtf_lewa_po, psd_lewa_przed, psd_lewa_po, channels_to_pick, "NDTF lewa przed/po", ["przed", "po"], "NDTF");
compare_dtf(freqs, ndtf_prawa_przed, ndtf_prawa_po, psd_prawa_przed, psd_prawa_po, channels_to_pick, "NDTF prawa przed/po", ["przed", "po"], "NDTF");
