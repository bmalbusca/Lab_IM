

Npontos = 10000;
famostragem=10000;
freq = 100;
k=0:1:Npontos-1;
t=k/famostragem;
sk= 0.8*cos(2*pi*freq*t)+ 0.002*randn(size(t));
sk1=cos(2*pi*freq*t -pi/2);

[freqs,spectrum,freq_estim] = meas_freq(sk,t,famostragem,Npontos);
[~,~,s_rms1]=meanf(sk,t,famostragem,Npontos,freq_estim);

[freqs1,spectrum1,freq_estim1] = meas_freq(sk1,t,famostragem,Npontos);
[~,~,s_rms2]=meanf(sk,t,famostragem,Npontos,freq_estim1);

%calcula o modulo da impedancia
Z_rms = (s_rms2/(s_rms2-s_rms1))*100  %impedacia conhecida de 100 ohm
%calcula o angulo da impedancia
angle = phase((sk- sk1), sk1) 
