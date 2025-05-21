signal = signal_preprocessed/ std(signal_preprocessed);
szum = randn(1, length(signal));

zestaw1 = zeros(2, length(signal));
zestaw1(1, :) = signal;
zestaw1(2, 2:end) = signal(1:end-1).*0.6;
zestaw1(2, :) = zestaw1(2, :)  + szum .*0.15;


zestaw2 = zeros(2, length(signal));
zestaw2(1, :) = signal;
zestaw2(2, :) = szum;

zestaw3 = zeros(2, length(signal));
zestaw3(1, :) = signal;
zestaw3(2, 5:end) = signal(1:end-4).*0.6;
zestaw3(2, :) = zestaw3(2, :)  + szum .*0.15;
