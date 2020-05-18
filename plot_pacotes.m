%                           PROGRAMA deprecao_alastrante
% Este programa consiste em fazer a leitura dos dados binarios calculados no Fortram, bem como redimensionar os dados apos a leitura em uma matriz
%  Aluno:Adilson Carlos Batista     graduando:Engenharia Eletrica local:UFSJ/LANEC   Data:novembro de 2012
clear all
clc
close all  
abre = 19 ;
fecha = 498 ;
num_amostra = 100;                                                         % numero de num_amostra.
max = 901;                                                                 % resolucao da matriz(obrigatoriamente  a mesma utilizada no Fortran.
iteracao = 4e5;                                                            % o numero de iteracoes utilizado no calculo no Fortran(parametro para o eixo do dominio)
u = 0;
cont_lim = 0 ;
path = 'teste_2/';
arquivo ='depressao_alastrante_vsig_lim_02_ab';                            % nome do arquivo. 
nome_rota = [arquivo '.mat'];
for i = abre:fecha
    %i
    if(i<10);simulacao=['0000000' num2str(i)];end
    if(i>=10 && i<100);simulacao=['000000' num2str(i)];end
    if(i>=100 && i<1000);simulacao=['00000' num2str(i)];end
    if(i>=1000 && i<10000);simulacao=['0000' num2str(i)];end
    if(i>=10000 && i<100000);simulacao=['000' num2str(i)];end
    if(i>=100000 && i<1000000);simulacao=['00' num2str(i)];end
    file=[path arquivo simulacao '.dat'];                                  % endereco do arquivo dado utilizando concatenacao.
    dim=max*max*num_amostra;                                               % N contem a dimensao do banco de dados
    fid=fopen(file,'r');                                                   % identificador de arquivo, retorna um numero inteiro se correto, ou -1 se incorreto.
    M_i=fread(fid,[1,dim],'integer*2')/32000;                              % tamanho e precisão, dados a conversao de real para inteiro
    fclose(fid);                                                           % fecha o dado lido.
    M_f=reshape(M_i,max,max,num_amostra);                                  % uma matriz final recbe os dados [1,N] e redimensiona na forma de banco de dados.
    REC1=1;                                                                % identificador de banco de dados recebe 1.
%  for filme=1:num_amostra                                                  % abrindo um pacote individualmente.
        u=u+1;
        M(1:max,1:max)=M_f(1:max,1:max,REC1);                              % M do tipo bidimensional recebe matriz banco de dados
        REC1=REC1+1;                                                       % redistribuindo banco de dados em matriz bidimensional
        figure(1),imagesc(M(:,:));
        title(num2str(i));
        colorbar;
        concentracao(u) = M(501,501) ;
        if M(501,501)>= 0.41
           cont_lim = cont_lim +1;
        end    
        if cont_lim <= 300
            limiar(u) = 0.41 ;
        else
            limiar(u) = 0.377+1.645*(M(501,501))^2/2  ;
        end
        %x(1:max,u) = M(1:max,451) ;                                        % armazenando a concentração de uma coluna ao longo do tempo.
       
  %end
end
pa = 10* length(concentracao) ;
tempo = linspace(1,pa,length(concentracao));
save(nome_rota,'concentracao','limiar','tempo'); 
figure(2),plot(tempo,concentracao,'-r');
axis([0 length(concentracao) 0 1.1]);
xlabel('tempo(s)','Fontsize',14);                                         
ylabel('concentracao[mM]','Fontsize',14);                                 
axis tight
%hold on
%print('-djpeg','-r1000',arquivo )

