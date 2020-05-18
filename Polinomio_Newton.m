% Program Programa_Newton
% programa para interpolar valor em tabela usando polinômio de Newton
%
% Parâmetros de entrada : M , X , Y , Z 
%    { número de pontos , abscissas , ordenadas e valor a interpolar } 
%
% Parâmetros de saída : R
%  { valor interpolado }
%
% { Declarar variáveis }
% declare M , I , K inteiro
%
% declare X[1:M] , Y[1:M] , Dely[1:M] , Z , R real
%
clear all; close all; clc; 
%
% { Entrada de dados }
M = input('Entre com numero de pontos da tabela: ');
disp(' ');
disp('Entre com valores da abscissa no formato [x0 x1 x2 ... xm]');
X = input(' ');
disp(' ');
disp('Entre com valores da ordenada no formato [y0 y1 y2 ... ym]');
Y = input(' ');
disp(' ');
%
Z = input('Entre com o valor a ser interpolado: ');
disp(' ');
%
%            Saída dos dados informados
clc;
disp('Os parametros de entrada');
disp(['m = ' num2str(M)]);
disp(['x = ' num2str(X)]);
disp(['y = ' num2str(Y)]);
disp(['z = ' num2str(Z)]);
disp(' ');
%
% { Iniciar variáveis }
%     Avaliar a função e sua derivada em X0
R = 0;
Dely = Y;
%
% { Cálculos necessários }
%         { construção das diferenças divididas }
for K = 1:(M - 1)
   for I = M:-1:K+1
       Dely(I) = (Dely(I) - Dely(I - 1)) / (X(I) - X(I - K));
   end
end
%
%    { avaliação do polinômio pelo processo de Horner }
R = Dely(M);
for I = (M-1):-1:1
    R = R * (Z - X(I)) + Dely(I);
end
%
%   { Saída de dados }
disp('produzem o resultado'); 
disp (['r = ' num2str(R)]);
disp(' ');
%
% Fim algoritmo
