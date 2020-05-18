% Program Splines_avaliar
% programa para avaliar os splines cubicos naturais e extrapolados
%
% Parametros de entrada : N , X , Y , Np , Z , Ts 
%    { numero de pontos dados , abscissas em ordem crescente , ordenadas } 
%    { numero de pontos a interpolar , valores a interpolar e tipo de splines } 
%
% Parametros de saida : Sz , CondErro
%  { valores interpolados e condicao de erro }
%
%       { DECLARAR VARIAVEIS }
% declare N , M , I , J , Np , Ts inteiro
%
% declare X[1:M] , Y[1:M] , C[1:M] , D[1:M] , E[1:M] , S2[1:M] , Z[1:Np]
%         T , Ha , Hb , H , Inf , Sup , Deltaa , Deltab , R , U ,
%         Ai , Bi , Ci , Di   real
%
clear all; close all; clc; 
%
%       { ENTRADA DE DADOS }
%   { Informacoes sobre os dados tabelados   }
N = input('Entre com numero de pontos da tabela: ');
disp(' ');
%
disp('Entre com valores (ordem crescente) da abscissa no formato [x0 x1 x2 ... xn]');
X = input(' '); disp(' ');
disp('Entre com valores da ordenada no formato [y0 y1 y2 ... yn]');
Y = input(' ');
disp(' ');
%
%  { Informacoes sobre valores para interpolacao }
Np = input('Entre com numero de pontos a serem interpolados: ');
disp(' ');
disp('Entre com valores a serem interpolados no formato [z0 z1 z2 ... zm]');
Z = input(' ');
disp(' ');
%
%  { informacoes sobre o tipo de splines utilizada }
disp('Spline a ser utilizada: ( 0 ) natural  ( 1 ) extrapolada ');
Ts = input(' ');
disp(' ');
%
if Ts == 0
    if N < 3
        clc;
        disp('Para utilizar Spline natural, o');
        disp('numero de pontos DEVE SER maior que 3');
        break;
    end
end
%
if Ts ~= 0
    if N < 4
        clc;
        disp('Para utilizar Spline extrapolado, o');
        disp('numero de pontos DEVE SER maior que 4');
        break;
    end
end
%
% Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['n = ' num2str(N)]);
disp(['x = ' num2str(X)]);
disp(['y = ' num2str(Y)]);
disp(' e ');
disp(['m = ' num2str(Np)]);
disp(['z = ' num2str(Z)]);
disp(['ts = ' num2str(Ts)]);
disp(' ');
%
%  Saida de dados do cabecalho da tabela e linha de título
if Ts == 0
    disp('Produzem os resultados para splines naturais'); disp(' ');
else
    disp('Produzem os resultados para splines extrapolados'); disp(' ');
end
Cabecalho = 'Spline \t a_i \t\t\t b_i \t\t\t c_i \t\t\t d_i \t\t\t z_j \t\t\t sz_j \n';
fprintf(Cabecalho);
% montando estrutura para impressAo dos resultados
Cabecalho = ' s_%i:';
Cabec = '%10.5f';
for I=1:N
    Cabec = [Cabec ' %15.5f'];
end
Cabecalho = [Cabecalho Cabec ' \n'];
%
%           { INICIAR VARIAVEIS }
% 
CondErro = 0;
M = N - 2;
D = zeros(1,M);
C = D;
E = D;
S2 = zeros(1,N);
%
%       { CALCULOS NECESSARIOS }
% { construcao ddo sistema tri diagonal simetrico }
if Ts == 0
    Ha = X(2) - X(1);
    Deltaa = (Y(2) - Y(1)) / Ha;
    for I = 1:M
        Hb = X(I + 2) - X(I + 1);
        Deltab = (Y(I + 2) - Y(I + 1)) / Hb;
        E(I) = Hb;
        D(I) = 2 * (Ha + Hb);
        S2(I + 1) = 6 * (Deltab - Deltaa);
        Ha = Hb;
        Deltaa = Deltab;
    end
    %
    %    { eliminacao de Gauss }
    for I = 2:M
        T = E(I - 1) / D(I - 1);
        D(I) = D(I) - T * E(I - 1);
        S2(I + 1) = S2(I + 1) - T * S2(I);
    end
    %
    %  { solucao por substituicoes retroativas }
    S2(M + 1) = S2(M + 1) / D(M);
    for I = M:-1:2
        S2(I) = (S2(I) - E(I - 1) * S2(I + 1)) / D(I - 1);
    end
    S2(1) = 0;
    S2(M + 2)= 0;    
else
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
    %    { eliminacao de Gauss }
    for I = 2:M
        T = E(I - 1) / D(I - 1);
        D(I) = D(I) - T * C(I);
        S2(I + 1) = S2(I + 1) - T * S2(I);
    end
    %
    %  { solucao por substituicoes retroativas }
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
end
if CondErro ~= 0
    break
end
CondErro = 0;
for J = 1:Np
    if (Z(J) >= X(1)) && (Z(J) <= X(N))
        %  { pesquisa binaria para localizar o intervalo }
        Inf = 1;
        Sup = N;
        while (Sup - Inf) > 1
            Ind = fix((Inf + Sup)/2);
            if X(Ind) > Z(J)
                Sup = Ind;
            else
                Inf = Ind;
            end
        end
        % { avaliacao do spline pelo processo de Horner }
        H = X(Sup) - X(Inf);
        Ai = (S2(Sup) - S2(Inf)) / (6 * H);
        Bi = S2(Inf) / 2;
        Ci = (Y(Sup) - Y(Inf)) / H - (S2(Sup) + 2 * S2(Inf)) * H / 6;
        Di = Y(Inf);
        H = Z(J) - X(Inf);
        Sz(J) = ((Ai * H + Bi) * H + Ci) * H + Di;
        %
        %   { SAIDA DE DADOS }
        fprintf(Cabecalho,(Inf-1),Ai,Bi,Ci,Di,Z(J),Sz(J));
    else
        Sz(J) = 0;
        CondErro = CondErro + 1;
    end
end
%  { SAIDA DE DADOS FINAL }
disp(' ');
disp('Valores interpolados:');
disp(['Sz = ' num2str(Sz)]);
disp(' ');
disp('Numero de valores fora do intervalo x(0) a x(n):');
disp(['CondErro = ' num2str(CondErro)]);
disp(' ');
%
% Fim algoritmo
