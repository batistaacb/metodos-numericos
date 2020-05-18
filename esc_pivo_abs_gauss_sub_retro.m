% =====================================================================================================================
%                 Escalonamento, obtendo como pivo o numero de maior modulo
% =====================================================================================================================
clear all;close all;clc;
M=input('Entre com a matriz aumentada do sistema M: ');                    % Matriz aumentada do sistema.
dim=input('Entre com numero de linhas da matriz M: ');                     % Numero de linhas igual a dimensão da matriz A.
A1=M(1:dim,1:dim);B1=M(1:dim,1+dim);% Matriz A e B originais
Variavel=0;                                   % matriz variavel para armazenar dados de "abs(M(i,j)"
I=eye(dim);                                                                % matriz identidade que vai identificar mudanças de colunas.
% =====================================================================================================================
% ASSEGURANDO QUE O PIVO SERA O NUMERO DE MAIOR MODULO E PODENDO ESCALONAR MATRIZ CUJO ELEMENTO A(1,1)=0
% =====================================================================================================================
for i=1:dim                                                                % laço para identificar qual ponto possui maior modulo.
    for j=1:dim                                                            % laço para identificar qual ponto possui maior modulo.
        if abs(M(i,j))> Variavel                                           % se modulo deste ponto for o maior numero, ele vai ficar
        Variavel=abs(M(i,j));                                              % armazenado na variavel, e também vai ficar armazenado
        a=i;b=j;                                                           % qual é o ponto esse numero de maior modulo pertence.
        end    
    end    
end
disp('o numero de maior modulo foi encontrado na linha'),disp(a);
disp('o numero de maior modulo foi encontrado na coluna'),disp(b);
M_l=M(1,:);M(1,:)=M(a,:);M(a,:)=M_l;   % efetuando mudança de linhas de acordo com "a".
M_c=M(:,1);M(:,1)=M(:,b);M(:,b)=M_c;   % efetuando mudança de colunas de acordo com "b".
I_c=I(:,1);I(:,1)=I(:,b);I(:,b)=I_c;   % identificando mudanças de colunas.
L(1:dim,1:dim)=eye(dim); % ***********************Atribuindo diagonal a Matriz  Lower *****************************************
% ======================================================================================================================
%                  METODO PIVOTAL DE GAUSS COM MATRIZ LOWER ARMAZENANDO OS MULTIPLICADORES
% ======================================================================================================================
for j=1:dim-1                                                              % não ha necessidade de escalonar a ultima linha.
      for i=(j+1):dim                                                      % (n+1) para iniciar com 2 e M(i,n)≃M(n,n)
          L(i,j)=M(i,j)/M(j,j);                                            % Armazenando multiplicadores(LOWER).
          M(i,:)=(-L(i,j))*(M(j,:))+(M(i,:));                              % pivoteamento para matriz arbitrária.
      end
end  
U=M(1:dim,1:dim);                                                          % Matriz triangular superior
D=M(1:dim,dim+1);                                                          % Matriz B alterada pelas operações elementares.
% =====================================================================================================================
%                                      METODO DAS SUBSTITUIÇÕES RETROATIVAS                           
% =====================================================================================================================
x(dim)=(D(dim))/(U(dim,dim));                                              % ja conseguimos o ultimo elemento do vetor resposta.
for i=dim:-1:1                                                             % passo decrescente ate chegar em 1
    soma=0;                                                                % zerando, pois sua funcao cumulativa é no laço interno
    for j=i+1:dim                                                          % j varia de um digito acima de i até o maximo 
        soma=soma+(U(i,j))*(x(j));                                         % variavel cumulativa, elementos a direita da igualdade
    end                                                                    % evidente abaixo,pelo sinal negativo e o denominador
    x(i)=(D(i)-soma)/(U(i,i));                                             %  denominador é o numero que multiplica x(i) na equação
end 
% ===========================================================================================================================
X=I*x';                          % REORGANIZANDO DEVIDO A MUDANÇAS DE COLUNAS, USANDO A MATRIZ IDENTIDADE 
% ============================================================================================================================
R(1:dim,1)=0;                      % Matriz dos residuos recebe ZERO.
R=B1-A1*X;
disp('Solução do Sistema'),disp(num2str(X)); 




