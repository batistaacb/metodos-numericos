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
var=1;% Variavel que assegura que na proxima iteração de t, o laço (i e j)vai verificar a coluna e a linha seguinte 
for t=1:(dim-1) % Laço onde se tem a matriz atualizada após o primeiro pivoteamento
    for i=var:dim                                    % laço para identificar qual ponto possui maior modulo.
       for j=var:dim                                 % laço para identificar qual ponto possui maior modulo.
           if abs(M(i,j))> Variavel                  % se modulo deste ponto for o maior numero, ele vai ficar
           Variavel=abs(M(i,j));                     % armazenado na variavel, e também vai ficar armazenado
           a=i;b=j;                                  % qual é o ponto esse numero de maior modulo pertence.
           M_l=M(var,:);M(var,:)=M(a,:);M(a,:)=M_l;  % efetuando mudança de linhas de acordo com "a".
           M_c=M(:,var);M(:,var)=M(:,b);M(:,b)=M_c;  % efetuando mudança de colunas de acordo com "b".
           I_c=I(:,var);I(:,var)=I(:,b);I(:,b)=I_c;  % identificando mudanças de colunas.
           end    
       end    
    end 
% ======================================================================================================================
%                  METODO PIVOTAL DE GAUSS COM MATRIZ LOWER ARMAZENANDO OS MULTIPLICADORES
% ======================================================================================================================
 n=var; % pivoteando uma coluna a cada evolução do laço "t"
for m=(n+1):dim                                % (n+1) para iniciar com 2 e M(i,n)≃M(n,n)
    L(m,n)=M(m,n)/M(n,n);                      % Armazenando multiplicadores(LOWER).
    M(m,:)=(-L(m,n))*(M(n,:))+(M(m,:));        % pivoteamento para matriz arbitrária.
    Variavel=0;% variavel deve ser zerada assim que uma coluna acaba de ser escalonada, pois o laço vai reorganizar a nova matriz
end
var=var+1;
end
disp('Matriz Lower, multiplicadores abaixo da diagonal principal são menores que 1,se pivoteamento completo');
disp(L);            % Lower não é utilizada apenas armazena os multiplicadores para conferir                                
U=M(1:dim,1:dim);   % Matriz triangular superior
D=M(1:dim,dim+1);   % Matriz B alterada pelas operações elementares.
% =============================================================================================================================
% Utilazando o metodo das substituições retroativas  resolver  U*x=D    
% ==========================================================================================================================
x(dim)=(D(dim))/(U(dim,dim));      % ja conseguimos o ultimo elemento do vetor resposta.
for i=dim:-1:1                     % passo decrescente ate chegar em 1
    soma=0;                        % variavel soma recebe zero, pois sua funcao cumulativa é no laço interno
    for j=i+1:dim                  % j varia de um digito acima de i até o maximo 
        soma=soma+(U(i,j))*(x(j)); % variavel cumulativa que são os elementos deslocados a direita da igualdade
    end                            % isto fica mais evidente na linha abaixo, onde temos o sinal negativo e o denominador
    x(i)=(D(i)-soma)/(U(i,i));     %  denominador é o numero que multiplica x(i) na equação
end                                % escrevendo o resultado, usando a funcao de matriz transposta, pois a resposta é 
% ===========================================================================================================================
X=I*x';                            % REORGANIZANDO DEVIDO A MUDANÇAS DE COLUNAS, USANDO A MATRIZ IDENTIDADE 
% ============================================================================================================================
R=B1-A1*X;
disp('Solução do Sistema'),disp(num2str(X)); 

