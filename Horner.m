% Program Horner
% programa para avaliar um polinomio de grau n no ponto a
% Parametros de entrada : n , c , a
%    grau , coeficientes e ponto a ser avaliado, onde "c" eh tal que 
%    P(x)= c(1) x^n + c(2) x^(n-1) + ? + c(n) x + c(n+1)
%
% Parametros de saida : y
%       ordenada P(a)
%
% { Declarar variaveis }
% declare I, N inteiro
% declare A , Y real
% declare C[1:N+1] real
%
clear all; close all; clc;
%
% { Entrada de dados }
N = input('Entre com o grau do polinomio P(x) '); disp(' ');
disp('Entre com os coeficientes na forma [c(n) c(n-1) ... c(1) c(0)]');
C = input(' ');
A = input('Entre com o ponto a ser avaliado : ');
%
%Saida dos dados informados
clc;
disp('Os valores de entrada');
disp(['n = ' num2str(N)]);
disp(['c = ' num2str(C)]);
disp(['ponto a = ' num2str(A)]); disp(' ');
%
% { Iniciar variaveis }
Y = C(1);
%
% { Calculos necessarios }
for I = 2:(N+1)
    Y = Y * A + C(I);
end
%
% { Saida de dados }
disp('produzem o resultado ');
disp(['y = ' num2str(Y)]);
% Fim algoritmo