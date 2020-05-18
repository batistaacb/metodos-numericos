% =====================================================================================================================
%                 Escalonamento, obtendo como pivo o numero de maior modulo
% =====================================================================================================================
clear all;close all;clc;
disp('Exemplo : [1 -2 3 2;8 -9 10 9;5 -4 -3 -2] ');
M=input('Entre com a matriz aumentada do sistema :  '); % Matriz dos aumentada do sistema. 
aux = size(M);                            % oferece a dimensão da matriz aumentada do sistema
max_l = aux(1);                           % o numero de linhas da matriz aumentada.
I=eye(max_l);                             % Matriz identidade que vai corrigir permutações de colunas.
cont=1;                                   % na proxima iteração  o laço (i e j) vai verificar a coluna e a linha seguinte 
A(1:max_l,1:max_l) = M(1:max_l,1:max_l) ; % matriz A utilizada no calculo do erro, denominado resíduo.
B(1:max_l,1) = M(1:max_l,aux(2)) ;        % matriz B utilizada no calculo do erro, denominado resíduo.
% =====================================================================================================================
% ASSEGURANDO QUE O PIVO SERA O NUMERO DE MAIOR MODULO E PODENDO ESCALONAR MATRIZ CUJO ELEMENTO A(1,1)=0
% =====================================================================================================================
for int=1:(max_l-1)                % Laço interage o pivoteamento com o escalonamento.
    pivo=0;                      % Variavel para armazenar dados de "abs(M(i,j)"  tem que ser zerada após uma escalonamento.
    for i=cont:max_l               % Percorrendo linhas para encontrar termo de maior modulo.
        for j=cont:max_l           % Percorrendo colunas para encontrar termo de maior modulo.
           if abs(M(i,j))> pivo  % Identificando o maio termo de maior modulo. 
           pivo=abs(M(i,j));     % Armazenando o termo de maior modulo.
           linha=i;              % Identificando a linha onde se encontra o termo de maior modulo.
           coluna=j;             % Identificando a coluna onde se encontra o termo de maior modulo. 
           end                   % Abaixo vai ocorrer as permutações de linhas
        end   
    end
M_l=M(cont,:);                   % Uma variavel armazena a linha para onde vai ser deslocado a linha cujo elemento possui maior modulo.
M(cont,:)=M(linha,:);            % Linha pivotal recebe a linha onde se encontra o termo de maior modulo.
M(linha,:)=M_l;                  % A linha armazenada na variavel é deslocada para linha onde se encontrava o termo de maior modulo  
M_c=M(:,cont);                   % Uma variavel armazena a coluna para onde vai ser deslocado a coluna cujo elemento possui maior modulo.
M(:,cont)=M(:,coluna);           % coluna pivotal recebe a coluna onde se encontra o termo de maior modulo.
M(:,coluna)=M_c;                 % A coluna armazenada na variavel é deslocada para coluna onde se encontrava o termo de maior modulo  
I_c=I(:,cont);                   % Os procedimentos realizados 
I(:,cont)=I(:,coluna);           % nas colunas da matriz M
I(:,coluna)=I_c;                 % são repetidos para uma matriz identidade
% ======================================================================================================================
%                  METODO PIVOTAL DE GAUSS COM MATRIZ LOWER ARMAZENANDO OS MULTIPLICADORES
% ======================================================================================================================
j=cont;                          % O escalonamento é uma coluna da cada vez.
for i=(j+1):max_l                  % "i" esta um passo a frente de "pois" não se escalona a linha que contém o pivo.                  
    L=M(i,j)/M(j,j);             % Obetendo o termo que vai escalonar a linha.
    M(i,:)=-L*(M(j,:))+(M(i,:)); % Escalonando a linha da matriz       
end
cont=cont+1;
end
U=M(1:max_l,1:max_l);                 % Matriz triangular superior modificada por operações elementares e permutações de colunas.
D=M(1:max_l,max_l+1);                 % Matriz B alterada pelas operações elementares.
% =============================================================================================================================
% Utilazando o metodo das substituições retroativas  resolver  U*x=D    
% ==========================================================================================================================
x(max_l)=(D(max_l))/(U(max_l,max_l));     % ja conseguimos o ultimo elemento do vetor resposta.
for i=max_l:-1:1                    % passo decrescente ate chegar em 1
    soma=0;                       % variavel soma recebe zero, pois sua funcao cumulativa é no laço interno
    for j=i+1:max_l                 % j varia de um digito acima de i até o max_limo 
        soma=soma+(U(i,j))*(x(j));% variavel cumulativa que são os elementos deslocados a direita da igualdade
    end                           % isto fica mais evidente na linha abaixo, onde temos o sinal negativo e o denominador
    x(i)=(D(i)-soma)/(U(i,i));    %  denominador é o numero que multiplica x(i) na equação
end                               % escrevendo o resultado, usando a funcao de matriz transposta, pois a resposta é 
R=B-(A*I)*x';                         % Efetuando o calculo de residuo
% ===========================================================================================================================
X=I*x';                           % REORGANIZANDO DEVIDO A MUDANÇAS DE COLUNAS, USANDO A MATRIZ IDENTIDADE 
% ============================================================================================================================
disp('Solução do Sistema'),disp(num2str(X)); 
disp('Residuo ou propagação de erro nos calculos.'),disp(R);



