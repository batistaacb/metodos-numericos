% Program Programa_Lagrange
% programa para interpolar valor em tabela usando polin�mio de Lagrange
%
% Par�metros de entrada : M , X , Y , Z 
%    { n�mero de pontos , abscissas , ordenadas e valor a interpolar } 
%
% Par�metros de sa�da : R
%  { valor interpolado }
%
% { Declarar vari�veis }
% declare M , I , J inteiro
%
% declare X[1:M] , Y[1:M] , Z real
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
%
% { C�lculos necess�rios }
for I = 1:M
    C = 1;
    D = 1;
    for J = 1:M
        if I ~= J
            C = C * (Z - X(J));
            D = D * (X(I) - X(J));
        end
    end
    %
    R = R + Y(I) * C / D;
    %
end
%   { Sa�da de dados }
disp('fornecem o resultado'); 
disp (['r = ' num2str(R)]);
disp(' ');
%
% Fim algoritmo
