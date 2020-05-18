%                           PROGRAMA deprecao_alastrante
% Este programa consiste em fazer a leitura dos dados binarios calculados no Fortram, bem como redimensionar os dados apos a leitura em uma matriz
%  Aluno:Adilson Carlos Batista     graduando:Engenharia Eletrica local:UFSJ/LANEC   Data:novembro de 2012
%close all;clear all;clc    
num_amostra=100;                                                               % numero de num_amostra.
max=901;                                                                   % resolucao da matriz(obrigatoriamente  a mesma utilizada no Fortran.
iteracao=200000;                                                           % o numero de iteracoes utilizado no calculo no Fortran(parametro para o eixo do dominio)
u=0;
path ='/media/DADOS/Adilson_Fortran/teste_5/';                             % caminho do arquivo. 
arquivo ='deprecao_exe11_alastrante_5_teste_';                             % nome do arquivo.  
disp(arquivo); disp(' ');                                                  % Saida de dados do cabecalho da tabela e linha de titulo
fprintf('Saida de Dados com avanço em linhas \n');                         % Obtendo cabeçalho para saída de dados.
rotulo = 'cont  filme     REC1     pacote      a      b  \n';
fprintf(rotulo)
rotulo = '%3i ';                                                           % formato especial para função "fprintf".
rot = '%8.3f';                                                             % formato fixo, com com numero de digitos a direita do ponto.
for I=1:3
    rot = [rot ' %8.3f'];                                                  % campo com 10 digitos sendo 5 a direita do ponto.
end
rotulo = [rotulo rot ' \n'];                                               % imprime valores da matriz com avanço de linhas. 
rotulo2 = ['%3i ' rot ' \n'];                                              % "\n é new line".
% Inicio da leitura dos dados
M10=zeros(max,max);
for i=124:124
    if(i<10);simulacao=['0000000' num2str(i)];end
    if(i>=10 && i<100);simulacao=['000000' num2str(i)];end
    if(i>=100 && i<1000);simulacao=['00000' num2str(i)];end
    if(i>=1000 && i<10000);simulacao=['0000' num2str(i)];end
    if(i>=10000 && i<100000);simulacao=['000' num2str(i)];end
    if(i>=100000 && i<1000000);simulacao=['00' num2str(i)];end
    file=[path arquivo simulacao '.dat'];                                  % endereco do arquivo dado utilizando concatenacao.
    dim=max*max*num_amostra;                                                   % N contem a dimensao do banco de dados
    fid=fopen(file,'r');                                                   % identificador de arquivo, retorna um numero inteiro se correto, ou -1 se incorreto.
    M_i=fread(fid,[1,dim],'integer*2')/32000;                              % tamanho e precisão, dados a conversao de real para inteiro
    fclose(fid);                                                           % fecha o dado lido.
    M_f=reshape(M_i,max,max,num_amostra);                                      % uma matriz final recbe os dados [1,N] e redimensiona na forma de banco de dados.
    REC1=100;                                                                % identificador de banco de dados recebe 1.
%    for filme=1:50:num_amostra                                                    % abrindo um pacote individualmente.
        u=u+1;
        M(1:max,1:max)=M_f(1:max,1:max,REC1);%-M_f(1:max,1:max,REC1-70);                              % M do tipo bidimensional recebe matriz banco de dados
        pp=find(M<-0.2);M(pp)=0;
        %pp=find(M~=0);M(pp)=1;
        REC1=REC1+1;                                                       % reditribuindo banco de dados em matriz bidimensional
        M10=M10+M;
%        pp=find(M10>1);M10(pp)=1;
        %P(u)=M(200,400);
        % pp=find(M>0.01);M1=M;M1(pp)=0;M1=M1/0.1;
        % figure(1),subplot(2,1,1);imagesc(M);colorbar ;hold off;caxis([0 1]);axis image
        %figure(1),subplot(2,1,2);imagesc(M1);colorbar ;hold off;caxis([0 1]);axis image
        %figure(1),%subplot(2,1,1);imagesc(M);axis image;colorbar
        %subplot(1,1,1),imagesc(M10);axis image;colorbar
        figure(1),,imagesc(M10);
        title(num2str(i));
        colorbar;
        % fprintf(rotulo,cont,filme,REC1,i,a,b); 
%    end    
end
%it_dominio=linspace(0,3.0e4,3000);                                          
%figure(2),plot(it_dominio,P,'-r'); 
%axis([0 3.0e4 0 1.1])                                     
%ylabel('tempo(s)','Fontsize',14);                                         
%ylabel('concentracao[mM]','Fontsize',14);                                 
%print('-djpeg','-r1000',[arquivo 'concentracao'])
axis tight
hold on


