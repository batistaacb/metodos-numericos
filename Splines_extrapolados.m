% Program Splines_extrapolados
% programa para calcular as segundas derivadas para os splines cubicos extrapolados
%
% Parametros de entrada : N , X , Y  
%    { numero de pontos dados , abscissas em ordem crescente e ordenadas } 
%
% Parametros de saida : S2 , CondErro
%  { segundas derivadas e condicao de erro }
%
%       { DECLARAR VARIAVEIS }
% declare N , M , I inteiro
%
% declare X[1:M] , Y[1:M] , C[1:M] , D[1:M] , E[1:M] , S2[1:M] , T ,
%         Ha , Hb , Deltaa , Deltab , R , U real
%
clear all; close all; clc; 
%
%       { ENTRADA DE DADOS }
N = input('Entre com numero de pontos da tabela: ');
disp(' ');
%
if N < 4
    CondErro = 1;
    disp(' ');
    disp('Numero de pontos DEVE SER maior que 4');
    break;
end
%
disp('Entre com valores (ordem crescente) da abscissa no formato [x0 x1 x2 ... xn]');
X = input(' '); disp(' ');
disp('Entre com valores da ordenada no formato [y0 y1 y2 ... yn]');
Y = input(' ');
disp(' ');

%  Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['n = ' num2str(N)]);
disp(['x = ' num2str(X)]);
disp(['y = ' num2str(Y)]);
disp(' ');
%
%       { INICIAR VARIAVEIS }
%
CondErro = 0;
M = N - 2;
D = zeros(1,M);
C = D;
E = D;
S2 = zeros(1,N);
%
%       { CALCULOS NECESSARIOS }
%  { construcao do sistema tri diagonal simetrico }
Ha = X(2) - X(1);
Deltaa = (Y(2) - Y(1)) / Ha;
Hb = X(3) - X(2);
Deltab = (Y(3) - Y(2)) / Hb;
D(1) = (Ha + Hb) * (Ha + 2*Hb) / Hb;
C(2) = (Hb^2 - Ha^2) / Hb;
S2(2) = 6 * (Deltab - Deltaa);
%
for I = 2:(M-1)
    Ha = Hb;
    Deltaa = Deltab;
    Hb = X(I + 2) - X(I + 1);
    Deltab = (Y(I + 2) - Y(I + 1)) / Hb;
    D(I) = 2 * (Ha + Hb);
    E(I-1) = Ha;
    C(I+1) = Hb;
    S2(I + 1) = 6 * (Deltab - Deltaa);
end
%
Ha = Hb;
Deltaa = Deltab;
Hb = X(N) - X(N-1);
Deltab = (Y(N) - Y(N-1)) / Hb;
D(M) = (Ha + Hb) * (Hb + 2*Ha) / Ha;
E(M-1) = (Ha^2 - Hb^2) / Ha;
S2(M+1) = 6 * (Deltab - Deltaa);
%
% { eliminacao de Gauss }
for I = 2:M
    T = E(I - 1) / D(I - 1);
    D(I) = D(I) - T * C(I);
    S2(I + 1) = S2(I + 1) - T * S2(I);
end
%
% { solucao por substituicoes retroativas }
S2(M + 1) = S2(M + 1) / D(M);
for I = M:-1:2
    S2(I) = (S2(I) - C(I) * S2(I + 1)) / D(I - 1);
end
Ha = X(2) - X(1);
Hb = X(3) - X(2);
S2(1)= ((Ha + Hb) * S2(2) - Ha * S2(3)) / Hb;
Ha = X(N-1) - X(N-2);
Hb = X(N) - X(N-1);
S2(M+2) = ((Ha + Hb) * S2(M+1) - Hb * S2(M)) / Ha;
%
%           { SAIDA DE DADOS }
disp('produzem os resultados'); 
disp(' ');
disp (['s2 = ' num2str(S2)]);
disp(' ');
disp(['CondErro = ' num2str(CondErro)]);
disp(' ');
%
% Fim algoritmo
