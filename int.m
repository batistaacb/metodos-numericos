clear all
close all
clc
a = input('Entre com o limite inferior de integração  :');
b = input('Entre com o limite superior de integração  :');
syms x
f_x = x^2 ;
f_x = inline(f_x);
area = quad(f_x,a,b) ;
