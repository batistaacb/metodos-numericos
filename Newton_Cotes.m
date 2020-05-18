% Program Newton-Cotes
% Programa para integrar uma funcao pelo metodo de Newton-Cotes
%
% Parametros de entrada : A , B , N , M
%     Limite inferior ,limite superior, grau do polinomio, numero de subintervalos
%
% Parametros de saida : Integral, condErro
%       Valor da integral e condicao de erro, sendo
%     CondErro = 0 se nao houve erro de consistencia dos parametros dados
%     CondErro = 1 se N < 1 ou N > 8
%     CondErro = 2 se resto(M,N) diferente 0 e
%     CondErro = 3 se ambas as condicoes ocorrerem
%
%       { DECLARAÇÃO DE VARIAVEIS }
% declare I , J , N , M  inteiro
% declare CondErro logico
% declare A , B , H , P , Integral real
% declare C[1:N] , D[1:N] , B[1:N] real
%
clear all; close all; clc;
%
%       { ENTRADA DE DADOS }
disp('Expressao da FUNCAO usando FUNCOES MATEMATICAS DO MATLAB');
VarF = input(' ','s');
% Transformar informacao da expressao em funcao 
Aux = ['@(x) ' VarF];
f = str2func(Aux);
disp(' ');
%
A = input('Entre com o limite INFERIOR do intervalo de integração: ');
B = input('Entre com o limite SUPERIOR do intervalo de integração: ');
disp(' ');
N = input('Entre com o grau do polinômio desejado ( 1 =< N <=8 ): ');
M = input('Entre com o numero de subintervalos: ');
disp(' '); disp(' ');
%
% Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['a = ' num2str(A)]);
disp(['b = ' num2str(B)]);
disp(['n = ' num2str(N)]);
disp(['m = ' num2str(M)]);
disp(' ');
%
%     { INICIAR VARIAVEIS }
% Constantes dos coeficientes de Cotes
D(1)=2;    D(2)=6;    D(3)=8;      D(4)=90; 
D(5)=288;  D(6)=840;  D(7)=17280;  D(8)=28350;
%
C(1)=1;     C(2)=1;    C(3)=4;     C(4)=1;     C(5)=3;      C(6)=7;   
C(7)=32;    C(8)=12;   C(9)=19;    C(10)=75;   C(11)=50;    C(12)=41;   
C(13)=216;  C(14)=27;  C(15)=272;  C(16)=751;  C(17)=3577;  C(18)=1323; 
C(19)=2989; C(20)=989; C(21)=5888; C(22)=-928; C(23)=10496; C(24)=-4540;
%
CondErro = 0; Integral = 0;
%
% ConsistEncia dos parAmetros
if N < 1 || N > 8
    CondErro = CondErro + 1;
end
if rem(M,N) ~= 0 
    CondErro = CondErro + 2;
end
if CondErro ~= 0
    break
end
%
% Saida de dados do cabecalho da tabela e linha de titulo
disp('Produzem os resultados'); disp(' ');
fprintf(' Integracao por Newton-Cotes com polinomio de grau %2i \n', N);
fprintf(' i      x(i)       y(i)    c(i) \n');
%
%           { CALCULOS NECESSARIOS }
P = fix(0.25 * (N * (N + 2) + rem(N,2)));
H = (B - A)/M;
%
% Calculo da Integral
for I = 0:M
    X = A + I*H;
    Y = f(X); % avaliando a funcao f(x).
    J = P + fix(0.5 * N - abs(rem(I,N) - 0.5 * N));
    K = 1 + fix((N - rem(I,N)) / N) - fix((M - rem(I,M)) / M);
    Integral = Integral + Y * C(J) * K;
    fprintf('%2i %10.5f %10.5f   %2i \n',I,X,Y,C(J)*K);
end
%
Integral = N * H / D(N) * Integral;
%
disp ' ';
disp(['Integral = ' num2str(Integral,6)]);
disp(' ');
disp (['Condicao de erro = ' num2str(CondErro)]); 
disp(' ');
%
%Fim do programa