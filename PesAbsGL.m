% Program PesAbsGL
% Programa para calcular pesos e abscissas para a equacao de Gauss-Legendre
%
% Parametros de entrada : N
%     numero de pontos
%
% Parametros de saida : Avet, Tvet , condErro
%       Vetor peso , Vetor abscissas e condicao de erro, sendo
%     CondErro = 0 se nao houve erro ( n >= 1) 
%     CondErro = 1 se N < 1
%
%           { DECLARAR VARIAVEIS }
% declare I , J , N , M inteiro
% declare CondErro logico
% declare P1 , P2 , P3 , Z , Z1 , PP  real
% declare Avet[1:N] , Tvet[1:N] real
%
clear all; close all; clc;
%
%           { ENTRADA DE DADOS } 
N = input('Entre com o numero de pontos (N >= 1): ');
disp(' ');
%
% Saida dos dados informados
clc;
disp('O parametro de entrada');
disp(['n = ' num2str(N)]); disp(' ');
%
%     { INICIAR VARIAVEIS }
% Constantes dos coeficientes de Cotes
CondErro = 0; 
M = fix(0.5 * (N + 1));
Avet = zeros (1,M);
Tvet = zeros (1,M);
Z = 1;
Z1 = 0;
%
% Saida de dados do cabecalho da tabela e linha de titulo
disp('produz os resultados'); disp(' ');
%
%    { CALCULOS NECESSARIOS }
for I = 1:M
    Z = cos(pi * (I - 0.25) / (N + 0.5));
    while abs(Z - Z1) >= 1e-15
        P1 = 1;
        P2 = 0;
        for J = 1:N
            P3 = P2;
            P2 = P1;
            % { polinomio de Legendre no ponto Z }
            P1 = ((2 * J - 1) * Z * P2 - (J - 1) * P3) / J;
        end   % { J }
        % { derivada do polinomio de Legendre no ponto Z }
        PP = N * (Z * P1 - P2) / (Z^2 - 1);
        Z1 = Z;
        % { metodo de Newton para calcular os zeros do polinomio }
        Z = Z1 - P1 / PP;
    end   % { while }
    Tvet(M + 1 - I) = Z;  % { abscissa }
    Avet(M + 1 - I) = 2 / ((1 - Z^2) * PP^2);  % { peso }
    % { somente as raizes nao negativas sao calculadas devido a simetria }
end  % { I }
%
%           { SAIDA DE DADOS }                                     
disp(['Avet = ' num2str(Avet,15)]);
disp(['Tvet = ' num2str(Tvet,15)]);
disp(' ');
disp (['Condição de erro = ' num2str(CondErro)]); 
disp(' ');
%
%Fim do programa