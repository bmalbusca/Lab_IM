% Autores: Bruno Figueiredo
%          Tarcisio Silva
%
% Turno: Terca-feira 17h
%

function  DAQ_parte1a( device, channel, fs, n, range)

%adquire o sinal 
[ S, t ] = acquire( device, channel, fs, n, range);

%calcula a frequencia e faz a DFT do sinal 
[ freqs, spectrum, freq_pesada, deltaf]= meas_freq( S, t, fs, n);

%Calcula o valor do medio e rms
[ s_mean ,s_alt, s_rms ] = meanf( S, t ,fs, n, freq_pesada);

deltatempo=(1/deltaf)*n

thd =meas_THD(n,spectrum);
thd_db = db2mag(thd);

%Usa 5 periodos para fazer fazer o grafico
if n > ceil((freq_pesada/fs)*5)
    x = S(1:ceil((freq_pesada/fs)*5));
    y = t(1:ceil((freq_pesada/fs)*5));
else
    x=S;
    y=t;
end

figure;
%figura 1
subplot(2,1,1);
plot(x,y);
title(['frequencia=',num2str(freq_pesada),'Hz Valor m?dio=',num2str(s_alt),'V Valor eficaz=',...
    num2str(s_rms),' N? amostras=',num2str(n),' f? amostragem=',num2str(fs),...
    'Hz low range=',num2str(-range),'V high range=',num2str(range),'V']);
xlabel('Tempo (s)');
ylabel('A [V]');
%figura 2
subplot(2,1,2);
semilogy(freqs,spectrum);
xlabel('f [Hz]');
ylabel('A [V]');
end