%                  Processo de Horner
clear all;close all;clc
c=input('Entre com os indices "c" do polinomio  :');
a=input('Entre com uma possivel raiz desse sistema  :');
max=length(c);                                                             % indice do polinomio mais um.
y=c(1);                                                                    % aplicando o ponto "a" no termo de maior grau do polinomio.
toler=1e-2;                                                                % tolerância para raiz aproximada.
for i=2:max                                                                % a primeira termo de "c" já foi atribuido a y fora do laço.
    y=y*a+c(i); 
end    
if abs(y) <=toler
   disp('sim');
else
   disp('não'); 
end    