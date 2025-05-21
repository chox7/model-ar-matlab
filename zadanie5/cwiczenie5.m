addpath("../src/")

k = 7;
[dtf, ndtf, freqs] = DTF(filteredEEGsignal, k, fs_down);
wizualizacja_ndtf(freqs, num_channels, ndtf, channels);
wizualizacja_dtf(freqs, num_channels, dtf, channels);
