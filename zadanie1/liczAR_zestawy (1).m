disp("Kanal 1 zestaw 1")
[ARr11,Vr11]=licz_wsp_AR(zestaw1(1, :) ,1)

disp("Kanal 2 zestaw 1")
[ARr12,Vr12]=licz_wsp_AR(zestaw1(2, :) ,1)

disp("Zestaw 1")
[ARr1,Vr1]=licz_wsp_AR(zestaw1 ,1)

disp("Kanał 1 jest przyczynowy w sensie Grangera dla kanału 2")
disp("Kanal 1 -> Kanal 2; czemu? dla kanalu 2 wariancja jest bardziej zmniejszona + analizy wspolczynnikow pozadiagonalych")

disp("Kanal 1 zestaw 2")
[ARr21,Vr21]=licz_wsp_AR(zestaw2(1, :) ,1)

disp("Kanal 2 zestaw 2")
[ARr22,Vr22]=licz_wsp_AR(zestaw2(2, :) ,1)

disp("Zestaw 2") 
[ARr2,Vr2]=licz_wsp_AR(zestaw2 ,1)

disp("Kanały nie są wzajemnie przyczynowe w sensie Grangera")
disp("Kanal 1 -/- Kanal 2; czemu? wariancje się nie zmieniły, bardzo małe współczyynniki pozadiagonalne (wzajemnego wpływu)")
