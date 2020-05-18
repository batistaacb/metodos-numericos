clear all ; close all ; clc
a = input ('inicio do conjunto dominio :');
b = input ('fim do conjunto dominio:') ;
% Cáculo de y(x),w(x),b(x),f(x)
x = linspace(a,b,1000);
y = 2*x ;
b = 3*x/2;
w = 4*x.^2+4*x;
f = 5*x.^3;

subplot(221),plot(x,y,'r')
subplot(222),plot(x,b,'b')
subplot(223),plot(x,w,'k')
subplot(224),plot(x,f,'g')




