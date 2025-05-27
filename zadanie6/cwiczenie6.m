addpath("../src/")
addpath("../data/mati_ruch/")

[data, fs, channels, tags] = download_signal("mati_ruch.obci.raw", "mati_ruch.obci.xml", "mati_ruch.obci.tag");

channels_to_pick = ["C3", "Cz", "C4", "F3", "F4"];
[preprocessed_data, fs_down] = preprocess_data(data, channels, channels_to_pick, fs);

[lewa_przed, prawa_przed] = cut_signal(preprocessed_data, tags, fs_down, -4, -2);
[lewa_po, prawa_po] = cut_signal(preprocessed_data, tags, fs_down, 0.5, 2.5);

rank = 9;
[dtf_lewa_przed, ndtf_lewa_przed, freqs] = process_dtf(lewa_przed, rank, fs_down);
[dtf_prawa_przed, ndtf_prawa_przed, freqs] = process_dtf(prawa_przed, rank, fs_down);

wizualizacja_dtf(freqs, length(channels_to_pick), dtf_lewa_przed, channels_to_pick, "lewa przed");
wizualizacja_ndtf(freqs, length(channels_to_pick), ndtf_lewa_przed, channels_to_pick, "lewa przed");

wizualizacja_dtf(freqs, length(channels_to_pick), dtf_prawa_przed, channels_to_pick, "prawa przed");
wizualizacja_ndtf(freqs, length(channels_to_pick), ndtf_prawa_przed, channels_to_pick, "prawa przed");


[dtf_lewa_po, ndtf_lewa_po, freqs] = process_dtf(lewa_po, rank, fs_down);
[dtf_prawa_po, ndtf_prawa_po, freqs] = process_dtf(prawa_po, rank, fs_down);

wizualizacja_dtf(freqs, length(channels_to_pick), dtf_lewa_po, channels_to_pick, "lewa po");
wizualizacja_ndtf(freqs, length(channels_to_pick), ndtf_lewa_po, channels_to_pick, "lewa po");

wizualizacja_dtf(freqs, length(channels_to_pick), dtf_prawa_po, channels_to_pick, "prawa po");
wizualizacja_ndtf(freqs, length(channels_to_pick), ndtf_prawa_po, channels_to_pick, "prawa po");
