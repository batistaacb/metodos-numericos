% M�todo de Newton
close all
clear all
clc
%               {Par�metros de entrada}
eu = 2.718312812 ;                                                         % numero de Euller
iter=0;                                                                    % variavel que vai contar as itera��es recebe zero.
toler=1e-10;                                                                % tolerância para proximidade da raiz exata.
iter_max=500;                                                              % numero máximo de itera��es.
x_o= .5 ;                                                                  % um dado inicial que se aproxima da solu��o.
dom =[-1 2] ;                                                               % intervalo onde obter a raiz.
syms x;                                                                    % definroto "x" como variavel simbolica.
f= eu^(-x.^2) -cos(x) ;                                                          % inserindo fun��o em linguagem Matlab.
df=diff(f);                                                                % derivada de primeira ordem da fun��o "f(x)".
var=('eu^(-x.^2) -cos(x)');                                                       % fun��o "f" se torna caracter para rotular grafico.
f=inline(f);                                                               % contrói um objeto de fun��o interna para "f(x)".
df=inline(df);                                                             % contrói um objeto de fun��o interna para "df(x)".
Fx = feval(f,x);                                                           % utilizando feval para funções que possuuem 
DFx = feval(df,x);                                                         % variaveis simbolicas.
Fx = f(x_o);                                                               % variavel "Fx" recebe valor da fun��o em "x".
DFx = df(x_o);                                                             % variavel "DFx" recebe valor da fun��o em "x".
x=x_o;                                                                     %variavel simbolica "x" recebe valor numérico.
delta_x=-Fx/DFx;
disp('Produz os resultados'); disp(' ');                                   % Saida de dados do cabecalho da tabela e linha de titulo
fprintf('saida de dados \n');                                              % Obtendo cabe�alho para saida de dados.
rotulo = ' iter      x        DFx         Fx        delta_x \n';           % indices da saida dos dados numericos.
fprintf(rotulo)                                                            % escreva os indices fixos para saida dos dados 
rotulo = '%3i ';                                                           % formato especial para fun��o "fprintf".
rot = '%10.3f';                                                            % formato fixo, com com numero de digitos a direita do ponto.
for I=1:3
    rot = [rot ' %10.3f'];                                                 % campo com 10 digitos sendo 3 a direita do ponto.
end
rotulo = [rotulo rot ' \n'];                                               % imprime valores da matriz com avan�o de linhas. 
fprintf(rotulo,iter,x,DFx,Fx,delta_x);                                     % os indices da saida dos parâmetros.
rotulo2 = ['%3i ' rot ' \n'];                                              % "\n é new line", ou seja, os proximos valores serão na linha abaixo.
for t=1:iter_max                                                           % utilizando la�o "para faça" como "repita", pois vai ser abortado pelo comando break.
    iter=iter+1;                                                           % quantas itera��es formam necessarias ou se foi insuficiente.
    delta_x=-Fx/DFx;                                                       % o incremento é o negativo da fun��o no ponto dividido pela derivada no ponto.
    x=x+delta_x;                                                           % valor de x é atulizado somando o incremento no ponto de x anterior.
    Fx=f(x);                                                               % fun��o F recebe o valor da fun��o no novo ponto de x atualizado.
    DFx=df(x);                                                             % derivada DFx recebe o valor da fun��o no novo ponto de x atualizado. 
    if ((abs(delta_x)<=toler)&&(abs(Fx)<=toler)||(DFx==0)||(iter==iter_max)) % teste logico que determina se o la�o repita vai prosseguir ou não
        break                 
    end   
    fprintf(rotulo2,iter,x,DFx,Fx,delta_x);                                % saida dos dados numericos.
end    
if((abs(delta_x)<=toler)&&(abs(Fx))<=toler)                                % TESTE DE CONVERGENCIA.
    cond_erro=0;
    disp('condi��o de erro'), disp(cond_erro);                             % houve CONVERGENCIA na solução do sistema nessas condições.    
else
    cond_erro=1;
    disp('condi��oo de erro'), disp(cond_erro);                             % houve DIVERGENCIA na solução do sistema nessas condições.
end    
raiz = x;                                                                  % raiz da equa��o no intervalo desejado.
disp('raiz'),disp(raiz);
int=linspace(min(dom),max(dom),1e3);                                       % obtendo vetor de "xmin" até "xmax" com 100 componentes.
y=f(int);                                                                  % "y" recebe a fun��o aplicada nos pontos do vetor "int".
figure(1),plot(int,y,'LineWidth',2);                                       % plotanto figura.
axis([min(dom) max(dom) -1 2]);                                            % delimitando a caixa dos eixos.
grid on;                                                                   % visualizar grades.
xlabel(' eixo das abicissas ');                                            % rotulo no eixo "x".
ylabel(' eixo das ordenadas ');                                            % rotulo no eixo "y".
title ( var );                                                            % titulo é a fun��o convertida em caracter.












