% Método de Runge-Kutta de Terceira ordem
close all;clear all;clc
syms y1 y2 y3           % variaveis simbolicas
a=0;                    % limite inferior do dominio.
b=1;                    % limite superior do dominio.
m=100;                  % numero de compartimentos que e dividido o intervalo do dominio.
% =========================================================================
%           Codicoes Iniciais Dada no Exercicio Analitico
y1_0=1;
y2_0=1;
y3_0=1;
f1_0=y1_0 + y3_0;
f2_0=-y1_0 - y3_0;
f3_0=y1_0 - y2_0;
% =========================================================================
f1=y1 + y3;             % primeira funcao.    
f1=inline(f1);
f2=-y1 - y3;            % segunda funcao.
f2=inline(f2);
f3=y1 - y2;             % terceira funcao.
f3=inline(f3);
h=(b-a)/m;              % limites de integracao dividido pelo passo.
x_t=a;                  % variavel recebe limite inferior do dominio.
y1_t=f1_0;
y2_t=f2_0;
y3_t=f3_0;
F1=feval(f1,y1,y3);
F2=feval(f2,y1,y3);
F3=feval(f3,y1,y2);
z={ 'i'      'x_t'          'y1_t'     'y2_t'       'y3_t' };
% {Calculos necessarios}
saida(1,1)=0;
saida(1,2)=x_t;
saida(1,3)=y1_t;
saida(1,4)=y2_t;
saida(1,5)=y3_t;
for t=1:m                     % {Para i}
    
    y1=x_t;
    y3=y1_t;
    k11=feval(f1,y1,y3);      % k11
    x1=x_t+h/2;
    y3=y1_t+h/2*k11;
    k12=feval(f1,y1,y3);      % k12
    y3=y1_t+h/2*k12;
    k13=feval(f1,y1,y3);      % k13
    y=y1_t+h*k13;
    y1_t=y1_t+h/6*(k11+4*k12+k13);
    xt=a+t*h
    saida(1+t,1)=t;
    saida(1+t,2)=x_t;
    saida(1+t,3)=y1_t;
    
end

for t=1:m                     % {Para i}
    y1=x_t;
    y=y_t;
    k1=feval(f,y1,y); % k1
    y1=x_t+h/2;
    y=y_t+h/2*k1;
    k2=feval(f,y1,y); % k2
    y=y_t+h/2*k2;
    k3=feval(f,y1,y); % k3
    y=y_t+h*k3;
    y_t=y_t+h/6*(k1+4*k2+k3);
     xt=a+t*h
end    
for t=1:m                     % {Para i}
    
    y1=x_t;
    y=y_t;
    k1=feval(f,y1,y); % k1
    y1=x_t+h/2;
    y=y_t+h/2*k1;
    k2=feval(f,y1,y); % k2
    y=y_t+h/2*k2;
    k3=feval(f,y1,y); % k3
    y=y_t+h*k3;
    y_t=y_t+h/6*(k1+4*k2+k3);
    
    xt=a+t*h;    % atualizando x_t com as iteracoes e e o passo do intervalo


    saida(1+t,4)=y2_t;
    saida(1+t,5)=y3_t;
end    % {Fim i}
disp(z);
disp(saida);
% Fim Algoritmo