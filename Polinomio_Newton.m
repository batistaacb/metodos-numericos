% Program Programa_Newton
% programa para interpolar valor em tabela usando polin�mio de Newton
%
% Par�metros de entrada : M , X , Y , Z 
%    { n�mero de pontos , abscissas , ordenadas e valor a interpolar } 
%
% Par�metros de sa�da : R
%  { valor interpolado }
%
% { Declarar vari�veis }
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
%            Sa�da dos dados informados
clc;
disp('Os parametros de entrada');
disp(['m = ' num2str(M)]);
disp(['x = ' num2str(X)]);
disp(['y = ' num2str(Y)]);
disp(['z = ' num2str(Z)]);
disp(' ');
%
% { Iniciar vari�veis }
%     Avaliar a fun��o e sua derivada em X0
R = 0;
Dely = Y;
%
% { C�lculos necess�rios }
%         { constru��o das diferen�as divididas }
for K = 1:(M - 1)
   for I = M:-1:K+1
       Dely(I) = (Dely(I) - Dely(I - 1)) / (X(I) - X(I - K));
   end
end
%
%    { avalia��o do polin�mio pelo processo de Horner }
R = Dely(M);
for I = (M-1):-1:1
    R = R * (Z - X(I)) + Dely(I);
end
%
%   { Sa�da de dados }
disp('produzem o resultado'); 
disp (['r = ' num2str(R)]);
disp(' ');
%
% Fim algoritmo
