% Método de Runge-Kutta de Terceira ordem
close all;clear all;clc
syms x y
a=0;%a=input('entre com o limite inferior de integração  :');
b=1;%b=input('entre com o limite superior de integração  :');
m=10;%m=input('entre com o numero de pontos no intervalo  :');
y_0=1;%y_0=input('entre4 com o valor inicial  :');
f=x-2*y+1;%f=input('entre com uma funo de duas variveis  :');
f=inline(f);
h=(b-a)/m;
xt=a;
yt=y_0;
Fxy=feval(f,x,y);%{avaliar f(x,y) em x=x_0 e y=y_0}
z={ 'i'        'xt'             'yt'  };
% {Calculos necessrios}
saida(1,1)=0;
saida(1,2)=xt;
saida(1,3)=yt;
for i=1:m   % {Para i}
    x=xt;
    y=yt;
    k1=feval(f,x,y); % k1
    x=xt+h/2;
    y=yt+h/2*k1;
    k2=feval(f,x,y); % k2
    y=yt+h/2*k2;
    k3=feval(f,x,y); % k3
    y=yt+h*k3;
    xt=a+i*h;
    yt=yt+h/6*(k1+4*k2+k3);
    saida(1+i,1)=i;
    saida(1+i,2)=xt;
    saida(1+i,3)=yt;
end    % {Fim i}
disp(z);
disp(saida);
% Fim Algoritmo