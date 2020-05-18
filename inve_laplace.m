%                   Transformada Inversa de Laplace
% Professor: Humberto Mazzini
% Curso: Engenharia Elétrica       Período:Quinto         Turno: Integral
% Aluno: Adilson Carlos Batista    Matricula: 110950055
% =========================================================================
% =========================================================================
close all                   % fechando as todas as janelas de gráfico.
clear all                   % limpando todo resíduos de calculo anteriores.
clc                         % limpando a tela principal.
syms s
Ns=input('Entre com um numerador da funcao em S de Laplace: Ex: (6*s^2+26*s+26)');
Ds=input('Entre com um denominador da funcao em S de Laplace: Ex: ((s+1)*(s+2)*(s+3)) ');
Fs = Ns / Ds;              % Funcao em S de Laplace.
ft = ilaplace(Fs) ;        % Funcao inversa de Laplace.
pretty(ft);