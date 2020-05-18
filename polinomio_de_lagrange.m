% Aula de laboratório do dia 8 de março
% Polinomio de Lagrange
clear all;close all;clc
% Atribuindo valores as variaveis e vetores.
m=input('Entre com o valor de m=3: ');
x=input('Entre com o vetor x=[0.1  0.6  0.8]');
y=input('Entre com o vetor y=[1.211 3.320 4.953]');
z=input('Entre com o parâmetro z=0.2');
r=0;
% Efetuando calculos
for i=1:m
    c=1;
    d=1;
    for j=1:m
        if i~= j
            c=c*(z-x(j));
            d=d*(x(i)-x(j));
        end   
    end 
    r=r+y(i)*c/d;
end    
disp(r);