% Aula de Laborat�rio do dia 12/04/2012
% Parametro de entrada
clear all;close all;clc
syms x y
a=0;%input('entre com o limite inferior de integra��o  :');
b=1;%input('entre com o limite superior de integra��o  :');
m=10;%input('entre com o numero de pontos no intervalo  :');
y_0=1;%input('entre4 com o valor inicial  :');
f=x-2*y+1;%input('entre com uma fun��o de duas vari�veis  :');
f=inline(f);
h=(b-a)/m;
x=a;
y=y_0;
Fxy=feval(f,x,y);%{avaliar f(x,y) em x=x_0 e y=y_0}
%Vet_x(1)=x;
%Vet_y(1)=y;
% {C�lculo necess�rios }
z={ 'i'        'x'             'y'           'f(x,y)'};
format short
saida(1,1)=0;
saida(1,2)=x;
saida(1,3)=y;
saida(1,4)=Fxy;
for i=1:m % {Para i}
    x=a+i*h;
    y=y+h*Fxy;
    Fxy=feval(f,x,y);
    saida(1+i,1)=i;
    saida(1+i,2)=x;
    saida(1+i,3)=y;
    saida(1+i,4)=Fxy;
   % Vet_x(i+1)=x;
   % Vet_y(i+1)=y;
end       % { Fim i}
disp(z);
disp(saida);
% Fim algoritmo