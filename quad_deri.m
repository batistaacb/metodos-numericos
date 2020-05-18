clear all
close all
clc
a = input('Entre com o limite inferior de integração  :') ;
b = input('Entre com o limite superior de integração  :') ;
syms t
f_t = input('Entre com uma funcao de t   :') ;
deri = diff(f_t) ;
f_t = inline(f_t);
area = quad(f_t,a,b) ;
pretty(deri);