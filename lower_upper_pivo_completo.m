% =====================================================================================================================
%                 Escalonamento, obtendo como pivo o numero de maior modulo
% =====================================================================================================================
clear all;close all;clc;
M=input('Entre com a matriz aumentada do sistema M: ');                    % Matriz aumentada do sistema.
dim=input('Entre com numero de linhas da matriz M: ');                     % Numero de linhas igual a dimensão da matriz A.
A1=M(1:dim,1:dim);B1=M(1:dim,1+dim);% Matriz A e B originais
Variavel=0;    % matriz variavel para armazenar dados de "abs(M(i,j)"
I=eye(dim);    % matriz identidade que vai identificar mudanças de colunas.
L(1:dim,1:dim)=eye(dim); % Atribuindo diagonal a Matriz  Lower  
% =====================================================================================================================
% ASSEGURANDO QUE O PIVO SERA O NUMERO DE MAIOR MODULO E PODENDO ESCALONAR MATRIZ CUJO ELEMENTO A(1,1)=0
% =====================================================================================================================
var=1;
for t=1:(dim-1)
for i=var:dim                                                                % laço para identificar qual ponto possui maior modulo.
    for j=var:dim                                                            % laço para identificar qual ponto possui maior modulo.
        if abs(M(i,j))> Variavel                                           % se modulo deste ponto for o maior numero, ele vai ficar
        Variavel=abs(M(i,j));                                              % armazenado na variavel, e também vai ficar armazenado
        a=i;b=j;                                                           % qual é o ponto esse numero de maior modulo pertence.
        M_l=M(var,:);M(var,:)=M(a,:);M(a,:)=M_l;                               % efetuando mudança de linhas de acordo com "a".
        M_c=M(:,var);M(:,var)=M(:,b);M(:,b)=M_c;                               % efetuando mudança de colunas de acordo com "b".
        I_c=I(:,var);I(:,var)=I(:,b);I(:,b)=I_c;                               % identificando mudanças de colunas.
        end    
    end    
end 
% ======================================================================================================================
%                  METODO PIVOTAL DE GAUSS COM MATRIZ LOWER ARMAZENANDO OS MULTIPLICADORES
% ======================================================================================================================
for n=var:var                                                              % não ha necessidade de escalonar a ultima linha.
      for m=(n+1):dim                                                      % (n+1) para iniciar com 2 e M(i,n)≃M(n,n)
          L(m,n)=M(m,n)/M(n,n);                                            % Armazenando multiplicadores(LOWER).
          M(m,1:dim)=(-L(m,n))*(M(n,1:dim))+(M(m,1:dim));                  % pivoteamento para matriz arbitrária.
          Variavel=0;
      end
end 
var=var+1;
end
