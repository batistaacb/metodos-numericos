% M�todo de Runge-Kutta de Quarta ordem
% Aula de Laborat�rio do dia 12/04/2013
% k=(k1+k2+k3+k4)/6
close all;clear all;clc
syms x y
a=0;%input('entre com o limite inferior de integra��o  :');
b=1;%input('entre com o limite superior de integra��o  :');
m=10;%input('entre com o numero de pontos no intervalo  :');
y_0=1;%input('entre4 com o valor inicial  :');
f=x-2*y+1;%input('entre com uma fun��o de duas vari�veis  :');
f=inline(f);
h=(b-a)/m;
xt=a;
yt=b;
Fxy=feval(f,x,y);%{avaliar f(x,y) em x=x_0 e y=y_0}
Vet_x(1)=x;
Vet_y(1)=y;
z={ 'i'        'xt'             'yt'  };
% {C�lculos necess�rios}
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
    x=xt+h;
    y=yt+h*k3;
    k4=feval(f,x,y); % k4
    xt=a+i*h;
    yt=yt+h/6*(k1+2*(k2+k3)+k4)
    saida(1+i,1)=i;
    saida(1+i,2)=xt;
    saida(1+i,3)=yt;
end    % {Fim i}
disp(z);
disp(saida);
% Fim Algoritmo