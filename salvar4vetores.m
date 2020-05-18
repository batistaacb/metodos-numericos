clear all ; close all ; clc
file = 'vetor_' ;
%  carregar todos os arquivos .mat sálvos com o nome 'vetor_' ,
%  concatená-los e plotar o resultado das imagens e conjuntos concatenados
for i = 1:4
name = [file num2str(i) '.mat'] ;
load(name);
if i == 1
    px = x ;
    py = y ;
else px = [px x];
     py = [py y];
end
end

save('somavetores.mat','px','py')

plot(px,py)









                  