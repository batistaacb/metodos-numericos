% Program Gauss_Legendre
% Programa para integrar uma funcao pelo metodo de Gauss-Legendre
%
% Parametros de entrada : A , B , N
%     Limite inferior ,limite superior, número de pontos
%
% Parametros de saida : Integral, condErro
%       Valor da integral e condicao de erro, sendo
%     CondErro = 0 se nao houve erro (N >= 1)
%     CondErro = 1 se N < 1 
%
%           { DECLARAR VARIAVEIS } 
% declare I , J , K , N , M inteiro
% declare CondErro logico
% declare P1 , P2 , P3 , Z , Z1 , PP , E1 , E2 , 
%          C , T , C1 , C2 , X , Y , A , B  Integral real
% declare Avet[1:N] , Tvet[1:N] real
%
clear all; close all; clc;
%
%           { ENTRADA DE DADOS } 
A = input('Entre com o limite INFERIOR do intervalo de integracao: ');
B = input('Entre com o limite SUPERIOR do intervalo de integracao: ');
disp(' ');
N = input('Entre com o numero de pontos ( N >= 1 ): ');
disp(' ');
%
disp('Expressao da FUNCAO usando FUNCOES MATEMATICAS DO MATLAB');
VarF = input(' ','s');
% Transformar informacao da expressao em funcao 
Aux = ['@(x) ' VarF];
f = str2func(Aux);
disp(' ');
%
% Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['a = ' num2str(A)]);
disp(['b = ' num2str(B,6)]);
disp(['n = ' num2str(N)]);
disp(' ');
%
%     { INICIAR VARIAVEIS }
%  pesos e abscissas
CondErro = 0; 
M = fix(0.5 * (N + 1));
Avet = zeros (1,M);
Tvet = zeros (1,M);
Z = 1;
Z1 = 0;
%
%  integracao
Integral = 0;
E1 = (B - A) / 2;
E2 = (A + B) / 2;
%
%  Saida de dados do cabecalho da tabela e linha de titulo
disp('produzem os resultados'); disp(' ');
fprintf(' Integracao numerica pelo metodo Gauss-Legendre \n');
fprintf(' i \t\t t(i) \t\t x(i) \t  f(x(i)) \t  A(i) \n');
%
%           { CALCULOS NECESSARIOS }
%  { calculo dos pesos e abscissas }
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
if CondErro ~= 0
    break
end
%
%  { Calculo da Integral }
if rem(N,2) == 0
    C1 = 1;
    C2 = 0.5;
else
    C1 = 0;
    C2 = 1;
end
%
for I = 1:N
    K =fix(I - 0.5 * (N + 1) + sign(I - 0.5 * (N + C1)) * C2);
    T = sign(K) * Tvet(abs(K));
    X = E1 * T + E2;
    Y = f(X);     % avaliando a funcao f(x).
    C = Avet(abs(K));
    Integral = Integral + Y * C;
    fprintf('%2i \t %10.5f %10.5f %10.5f %10.5f \n',I,T,X,Y,C);
end
%
Integral = E1 * Integral;
%
disp ' ';
disp(['Integral = ' num2str(Integral,11)]);
disp(' ');
disp (['Condicao de erro = ' num2str(CondErro)]); 
disp(' ');
%
%Fim do programa