% =====================================================================================================================
%                 Escalonamento, obtendo como pivo o numero de maior modulo
% =====================================================================================================================
clear all;close all;clc;
M=input('Entre com a matriz aumentada do sistema M: ');                    % Matriz aumentada do sistema.
dim=input('Entre com numero de linhas da matriz M: ');                     % Numero de linhas igual a dimensão da matriz A.
A1=M(1:dim,1:dim);B1=M(1:dim,1+dim);% Matriz A e B originais
L(1:dim,1:dim)=eye(dim); % ***********************Atribuindo diagonal a Matriz  Lower *****************************************
Variavel=0;                                   % matriz variavel para armazenar dados de "abs(M(i,j)"
I=eye(dim);                                   % matriz identidade que vai identificar mudanças de colunas.
% =====================================================================================================================
% ASSEGURANDO QUE O PIVO SERA O NUMERO DE MAIOR MODULO E PODENDO ESCALONAR MATRIZ CUJO ELEMENTO A(1,1)=0
% =====================================================================================================================
for i=1:dim                                      % laço para identificar qual ponto possui maior modulo.
    for j=1:dim                                  % laço para identificar qual ponto possui maior modulo.
        if abs(M(i,j))> Variavel                 % se modulo deste ponto for o maior numero, ele vai ficar
           Variavel=abs(M(i,j));                 % armazenado na variavel, e também vai ficar armazenado
           a=i;b=j;                              % qual é o ponto esse numero de maior modulo pertence.
        end
    end
end 
M_l=M(1,:);M(1,:)=M(a,:);M(a,:)=M_l;   % efetuando mudança de linhas de acordo com "a".
M_c=M(:,1);M(:,1)=M(:,b);M(:,b)=M_c;   % efetuando mudança de colunas de acordo com "b".
I_c=I(:,1);I(:,1)=I(:,b);I(:,b)=I_c;   % identificando mudanças de colunas.
A=M(1:dim,1:dim);  % Matriz A recebe seus dados modificados por operações elementares de linhas e/ou colunas.
B=M(1:dim,dim+1);  % Matriz B recebe seus dados modificados por operações elementares de linhas e/ou colunas.
% ======================================================================================================================
%  METODO PIVOTAL DE GAUSS COM MATRIZ LOWER (TRIANGULAR INFEIROR) QUE POSSUI OS MULTIPLICADORES ABAIXO DA DIAGONAL PRINCIPAL
%  >>>>>>>>>> SEM ESCALONAR MATRIZ AUMENTADA, POIS "B" NÃO SE MODIFICA NESTA METODO <<<<<<<<<<<<<<                
% ======================================================================================================================
for n=1:dim-1                                 % não ha necessidade de escalonar a ultima linha.
      for m=(n+1):dim                         % (n+1) para iniciar com 2 e M(i,n)≃M(n,n)
          L(m,n)=A(m,n)/A(n,n);               % Armazenando multiplicadores(LOWER).
          A(m,:)=(-L(m,n))*(A(n,:))+(A(m,:)); % pivoteamento para matriz arbitrária.
      end
end 
disp('MATRIZ LOWER, MULTIPICADORES ABAIXO DA DIAGONAL PRINCIPAL'),disp(L);
U=A(1:dim,1:dim);  % ******************************** MATRIZ UPPER ********  
% =====================================================================================================================
% METODO DAS SUBSTITUIÇÕES SUCESSIVAS (Temos como objetivo encontrar a Matriz "y" por L*y=B) ONDE "L" É A MATRIZ LOWER                          
% =====================================================================================================================
 y(1)=(B(1))/(L(1,1));                       % ja temos o valor de x1
for i=2:dim                                  % i inicia em 2 pois ja temos x1
    soma=0;                                  % variavel recebe 0 pois é incrementada no laço interno
    for j=1:i-1                              % j varia uma casa a menos que i 
        soma=soma+(L(i,j))*(y(j));           % variavel soma que consiste nos termos que mudamos de lado na igualdade.
    end                                      % isso fica mais evidente deido ao sinal negativo na linha abaixo.
    y(i)=(B(i)-soma)/(L(i,i));               % termos a direita da igualdade em um sistema
end
    Y=y';                                    % Matriz coluna de "y".
% =====================================================================================================================
% METODO DAS SUBSTITUIÇÕES REGRESSIVAS (Temos como objetivo encontrar a Matriz "X" por U*X=Y) ONDE "U" É A MATRIZ UPPER                                           
% =====================================================================================================================
x(dim)=(Y(dim))/(U(dim,dim));      % ja conseguimos o ultimo elemento do vetor resposta.
for i=dim:-1:1                     % passo decrescente ate chegar em 1
    soma=0;                        % variavel soma recebe zero, pois sua funcao cumulativa é no laço interno
    for j=i+1:dim                  % j varia de um digito acima de i até o maximo 
        soma=soma+(U(i,j))*(x(j)); % variavel cumulativa que são os elementos deslocados a direita da igualdade
    end                            % isto fica mais evidente na linha abaixo, onde temos o sinal negativo e o denominador
    x(i)=(Y(i)-soma)/(U(i,i));     %  denominador é o numero que multiplica x(i) na equação 
end                                % escrevendo o resultado, usando a funcao de matriz transposta, pois a resposta é 
% ===========================================================================================================================
X=I*x';                          % REORGANIZANDO DEVIDO A MUDANÇAS DE COLUNAS, USANDO A MATRIZ IDENTIDADE 
% ============================================================================================================================
R(1:dim,1)=0;                      % Matriz dos residuos recebe ZERO.
R=B1-A1*X;
disp('Solução do Sistema'),disp(num2str(X)); 



