% Escalonamento obtendo como pivo o numero de maior modulo
clear all;close all;clc;
M=input('Entre com a matriz aumentada do sistema M: ');                    % Matriz aumentada do sistema.
dim=input('Entre com numero de linhas da matriz M: ');                     % Numero de linhas igual a dimensão da matriz A.
Variavel(1:dim,1:dim)=0;                      % matriz variavel para armazenar dados de "abs(M(i,j)"
I=eye(dim);                                   % matriz identidade que vai identificar mudanças de colunas.
for i=1:dim                                   % laço para identificar qual ponto possui maior modulo.
    for j=1:dim                               % laço para identificar qual ponto possui maior modulo.
        if abs(M(i,j))> Variavel              % se modulo deste ponto for o maior numero, ele vai ficar
        Variavel=abs(M(i,j));                 % armazenado na variavel, e também vai ficar armazenado
        a=i;b=j;                              % qual é o ponto esse numero de maior modulo pertence.
        M_l=M(1,:);M(1,:)=M(a,:);M(a,:)=M_l;  % efetuando mudança de linhas de acordo com "a".
        M_c=M(:,1);M(:,1)=M(:,b);M(:,b)=M_c;  % efetuando mudança de colunas de acordo com "b".
        I_c=I(:,1);I(:,1)=I(:,b);I(:,b)=I_c;  % identificando mudanças de colunas.
        end    
    end    
end 
A=M(1:dim,1:dim);  % Matriz A recebe seus dados modificados por operações elementares de linhas e/ou colunas.
B=M(1:dim,dim+1);  % Matriz B recebe seus dados modificados por operações elementares de linhas e/ou colunas.
