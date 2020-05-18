% Program Regressao_linear_EN
% programa para calcular parametros de quadrados minimos de modelo linear multiplo
%          via equacoes normais
%
% Parametros de entrada : N , V , P , X , Y  
%    { numero de pontos , numero de variaveis , numero de parametros } 
%    { variaveis independentes , variaveis dependentes } 
%
% Parametros de saida : B , R2 , Sigma2 , CondErro
%  { coeficientes de regressao , coeficiente de determinacao } 
%  { variancia residual , condicao de erro }
%
%       { DECLARAR VARIAVEIS }
%
% declare I , J , K , Jp1 , Vp1 , V , P , N inteiro
%
% declare X[1:N , 1:P] , Y[1:N] , Sxx[1:P , 1:P] , Sxy[1:P] U[1:P , 1:P] ,
%         T[1:N] , Soma , U1 , Dm , D , Det , Sy2 , Tt ,
%         R2 , Sigma2 , B , Di   real
%
clear all; close all; clc; 
%

%       { ENTRADA DE DADOS }
%
%  { Informacoes sobre valores para interpolacao }
N = input('Entre com numero de pontos tabelados: '); disp(' ');
V = input('Entre com numero de variaveis independentes: '); disp(' ');
P = input('Entre com numero de coeficientes a serem determinados: '); 
disp(' '); disp(' '); disp(' ');
%
if (V > 1) && (V+1 ~= P)
    clc;
    CondErro = 1;
    break;
end
%
X = zeros(N,V+1);
Y = zeros(1,N);
disp('Entre com variavel independente no formato [x11 x12 ... x1p ; x21 x22 ... xpp] ');
X = input(' '); disp(' ');
disp('Entre com variavel dependente no formato [y1 y2 ... yp] ');
Y = input(' ')'; disp(' ');
%
%  Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['n = ' num2str(N)]);
disp(['v = ' num2str(V)]);
disp(['p = ' num2str(P)]);
disp(' e ');
disp(['x = ']); disp(X);
disp(['y = ']); disp(Y);
disp(' ');
%
%  montando estrutura para impressao dos resultados
Cabecalho = [' b(%i) = ' '%7.5e \n'];
disp(' ');
%
%       { INICIAR VARIAVEIS }
CondErro = 0;
Vp1 = V + 1;
Pm1 = P - 1;
Sxx = zeros(P);
U = Sxx;
Sxy = zeros(1,P);
T = zeros(1,P);
%
%       { CALCULOS NECESSARIOS }
%  { inclusao de uma coluna de 1's relativa aa b0 }
for I = 1:N
    for J = Vp1:-1:2
        X(I,J) = X(I,J-1);
    end
    X(I,1) = 1;
end
if (V == 1) && (P > 2)
    for J = 2:Pm1
        Jp1 = J + 1;
        for I = 1:N
            X(I,Jp1) = X(I,2)^J;
        end
    end
end
%
%  { Equacoes normais }
for I = 1:P
    for J = 1:P
        Soma = 0;
        for K = 1:N
            Soma = Soma + X(K,I) * X(K,J);
        end
        Sxx(I,J) = Soma;   %  { matriz dos coeficientes }
    end
    Soma = 0;
    for K = 1:N
        Soma = Soma + X(K,I) * Y(K);
    end
    Sxy(I) = Soma;         %  { vetor dos termos independentes }
end
%
%   { Decomposicao de Cholesky }
%  [L,Det,CondErro] = Cholesky(P,Sxx)  -->  Essa chamada de subrotina foi substituida por:
Det = 1;
L = Sxx;
for J = 1:P
    Soma = 0;
    for K = 1:(J-1)
        Soma = Soma + L(J,K)^2;
    end
    Tt = L(J,J) - Soma;
    if Tt > 0
        L(J,J) = sqrt(Tt);
        R = 1 / L(J,J);
        Det = Det * Tt;
    else
        CondErro = 1;
        clc; disp('a matriz nao eh definida positiva');
        break;
    end
    for I = (J + 1):P
        Soma = 0;
        for K = 1:(J - 1)
            Soma = Soma + L(I,K) * L(J,K);
        end
        L(I,J) = (L(I,J) - Soma) * R;
    end
end
%
%   { Substituicoes Sucessivas }
%  T = Substituicoes_Sucessivas(P,L,Sxy)  -->  Essa chamada de subrotina foi substituida por:
T(1) = Sxy(1) / L(1,1);
for I = 2:P
    Soma = 0;
    for J = 1:(I - 1)
        Soma = Soma + L(I,J) * T(J);
    end
    T(I) = (Sxy(I) - Soma) / L(I,I);
end
%
%  { Matriz U recebe a transposta de L }
for I = 1:P
    for J = 1:I
        U(J,I) = L(I,J);  %  { U = transposta de L }
    end
end
%
%   { Substituicoes Retroativas para determinacao dos coeficientes }
%  B = Substituicoes_retroativas(P,U,T)  -->  Essa chamada de subrotina foi substituida por:
B(P) = T(P) / U(P,P);
for I = (P-1):-1:1
    Soma = 0;
    for J = (I+1):P
        Soma = Soma + U(I,J) * B(J);
    end
    B(I) = (T(I) - Soma) / U(I,I);
end
%
Dm = 0;
Sy2 = 0;
for I = 1:N
    U1 = 0;
    for J = 1:P
        U1 = U1 + B(J) * X(I,J);
    end
    D = Y(I) - U1;
    Dm = Dm + D^2;
    Sy2 = Sy2 + Y(I)^2;
end
%
%       { SAIDA DE DADOS }
R2 = 1 - Dm / (Sy2 - Sxy(1)^2/N);   %  { coeficiente de determinacao }
Sigma2 = Dm / (N - P);              %  { variancia residual }
%
%       { SAIDA DE DADOS FINAL }
%     Saida de dados do cabecalho da tabela e linha de titulo
disp('Produzem os resultados '); 
disp(' ');
fprintf('Coeficientes de regressao \n');
for I=1:P
    fprintf(Cabecalho,(I-1),B(I));
end
disp(' ');
fprintf('Coeficiente de determinacao = %7.5f \n',R2);
fprintf('Variancia residual = %5.5e \n',Sigma2); disp(' ');
fprintf('Condicao de erro = %i \n',CondErro); disp(' ');
%
% Fim algoritmo
