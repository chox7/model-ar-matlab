function [ARr,Vr]=licz_wsp_AR(dat,p)
% dat - macierz danych wejsciowych rozmiaru (kanaly, probki)
% p - rzad modelu

% funkcja zwraca macierz wspolczynnikow modelu rozmiaru (kanaly, kanaly, rzad)
% oraz macierz wariancji szumu resztkowego rozmiaru (kanaly, kanaly)

chans=size(dat,1);

[AR,RCF,V] = mvar(dat', p, 1);
ARr=reshape(AR,[chans chans p]);
Vr=reshape(V,[chans chans p+1]);
Vr=squeeze(Vr(:,:,p+1));
