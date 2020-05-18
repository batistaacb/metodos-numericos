close all
clear all;
clc
barreira=25;
max=901;
iteracao=2e5;
n_amostra=100;
int_amostra=10;
maxp=20;
dim=max*max*n_amostra;
simulacao='001';
D2X=2*1.0;
D2Y=2*1.0;
D2Z=2*1.0;
arquivo ='depressao_exe15_alastrante_4_teste_';                                      
path ='/media/DADOS/Adilson_Fortran/teste_4/';                             
%narq_saida=input('Entre com um nome para o arquivo da rota: ','s');

nzeros='0000000';
arq1=1;arq2=1;3
cont=1;
%----------------------------------------------------
%centro do retangulo inicial para encontrar o olho
%xc=508; % linhas
%yc=142; % colunas
%----------------------------------------------------
%tamanho do retangulo(metade do lado)
dd=50;

%Distancia temporal entre as ondas
dj=50;
if dj>n_amostra
    j2=dj/n_amostra;
    j2=fix(j2);
else
    j2=2;
end
u=dj;
while (u>n_amostra)
    u=u-n_amostra;
end
%u3
%j2
%----------------------------------------------------
%tecnica para detectar rotas descontinuas
pare=399;%input('Entre com o valor para parar o arquivo da rota: ');
contador=barreira;
fid=fopen('/media/DADOS/Adilson_Fortran/teste_4/depressao_exe15_alastrante_4_teste_00000025.dat','r','n');
f=fread(fid,[1,dim],'integer*2');
fclose(fid);
fo=reshape(f,max,max,n_amostra)/32000;clear f;
       % fo(m2)=1;                                                          
figure(1),imagesc(fo(:,:,10)); colormap jet;
title(num2str(cont));
p=ginput(1);
p=fix(p)

pa=p;
p(1)=pa(2);
p(2)=pa(1);
xc=p(1);
yc=p(2);
tc=500;
tempo=500;
pacote=399;
nome='depressao_exe15_alastrante_4_teste_';
%----------------------------------------------------
for i=barreira:pacote
    contador=contador+1;
    if i<10;nzeros='0000000';end
    if (i>=10 & i<100);nzeros='000000';end
    if (i>=100 & i<1000);nzeros='00000';end
    if (i>=1000 & i<10000);nzeros='0000';end
    if (i>=10000 & i<100000);nzeros='000';end
    if (i>=100000 & i<1000000);nzeros='00';end
    arq1=i;
    arq2=i+j2;
    i
    arquivo=[path nome nzeros num2str(arq1) '.dat'];
    fid=fopen(arquivo,'r');
    ko=fread(fid,[1,dim],'integer*2');fclose(fid);
    ko=ko/32000;
    k1=reshape(ko,max,max,n_amostra);
    
    if arq2<10;nzeros='0000000';end
    if (arq2>=10 & arq2<100);nzeros='000000';end
    if (arq2>=100 & arq2<1000);nzeros='00000';end
    if (arq2>=1000 & arq2<10000);nzeros='0000';end
    if (arq2>=10000 & arq2<100000);nzeros='000';end

    arquivo=[path nome nzeros num2str(arq2) '.dat'];
    fid=fopen(arquivo,'r');
    ko_1=fread(fid,[1,dim],'integer*2');fclose(fid);
    ko_1=ko_1/32000;
    k1_1=reshape(ko_1,max,max,n_amostra);

    novoarquivo='nao';
    for j=1:5:n_amostra
        j1=u;
        j3=j+dj;
        
        tempo=tempo+1;
        
         if (j1==n_amostra);
            novoarquivo='nao';
            u=0;            
         end
        
        if(j3>n_amostra) & novoarquivo=='nao';
           arq2=i+j2;
           if arq2<10;nzeros='0000000';end
           if (arq2>=10 & arq2<100);nzeros='000000';end
           if (arq2>=100 & arq2<1000);nzeros='00000';end
           if (arq2>=1000 & arq2<10000);nzeros='0000';end
           if (arq2>=10000 & arq2<100000);nzeros='000';end
            arquivo=[path nome nzeros num2str(arq2) '.dat'];
            fid=fopen(arquivo,'r');
            ko_1=fread(fid,[1,dim],'integer*2');fclose(fid);
            ko_1=ko_1/32000;
            k1_1=reshape(ko_1,max,max,n_amostra);
            novoarquivo='sim';
        end       
            
        k2(1:max,1:max)=k1(1:max,1:max,j);
         posicoes_zeros=find(k2(:,:)<0.4);
         k2(posicoes_zeros)=0;
        posicoes_ones=find(k2~=0);
        k2(posicoes_ones)=1;
         k4=k2;%edge(k2);
        
        k2(1:max,1:max)=k1_1(1:max,1:max,j1);
         posicoes_zeros=find(k2(:,:)<0.4);
         k2(posicoes_zeros)=0;
        posicoes_ones=find(k2~=0);
        k2(posicoes_ones)=1;
        k4_1=k2;%edge(k2);
        
        k5=zeros(max+dd*2,max+2*dd);
        
        k5(dd+1:max+dd,dd+1:max+dd)=k4(1:max,1:max)-k4_1(1:max,1:max);%k4+k4_1;
%        C=zeros(max,max);C(2:max-1,2:max-1)=k5(2:max-1,2:max-1);
%        GRAD=zeros(max,max,2);
%        GRAD(2:max-1,:,1) = (C(3:max,:)-C(1:max-2,:))/D2X;
%        GRAD(:,2:max-1,2) = (C(:,3:max)-C(:,1:max-2))/D2Y;
%        GRAD(1,:,1) =(C(2,:)-C(1,:))/(D2X);
%        GRAD(max,:,1) =-(C(max,:)-C(max-1,:))/(D2X);
%        GRAD(:,1,2) =(C(:,2)-C(:,1))/(D2Y);
%        GRAD(:,max,2) =-(C(:,max)-C(:,max-1))/(D2Y);
%        MOD=sqrt(GRAD(:,:,1).^2+GRAD(:,:,2).^2);
%        ppp=find(MOD~=0);MOD(ppp)=MOD(ppp)/max(max(MOD(ppp)));

        px1=0;
        MOD=zeros(dd,dd);
        k6=k5;
        for z1=1:dd*2+1
            for q1=1:dd*2+1
                z=(z1+(xc-dd));q=(q1+(yc-dd));
%                k5(q-dd:q+dd,z-dd:z+dd)=k4(q-dd:q+dd,z-dd:z+dd)-k4_1(q-dd:q+dd,z-dd:z+dd);
%                hold on; h1=plot(z,q,'*b');set(h1,'markersize',12);hold off
                ppp_1=find(k5(z-10:z+10,q-10:q+10)==-1);
                n_1=length(ppp_1);
                if n_1 == 0
                    n_1=NaN;
                end
                ppp1=find(k5(z-10:z+10,q-10:q+10)== 1);
                n1=length(ppp1);
                if n1 == 0
                    n1=NaN;
                end
                MOD(z1,q1)=abs(n1-n_1);
                k6(z,q)=k5(z,q)+5;
                    
            end
        end
%         figure(2),imagesc(k6);colormap gray;axis image;axis off;colorbar
        if min(min(MOD))~=NaN
            [px1,py1]=find(MOD==min(min(MOD)));
            tx1=tempo;
        else
            px1=xc;py1=yc;tx1=tc;
        end
        px=(px1+(xc-dd));py=(py1+(yc-dd));
        pxaux=mean(px);clear px;px=pxaux;
        pyaux=mean(py);clear py;py=pyaux;
        tx=tx1;
        
%         px,py
%         hold on; h1=plot(py,px,'*b');set(h1,'markersize',12);hold off
%         pause
%         
        k6=zeros(max+dd*2,max+2*dd);
        
        k6(dd+1:max+dd,dd+1:max+dd)=k1_1(1:max,1:max,j1);
        %figure(1),imagesc(k6*(-1));colormap jet;axis image;axis off
        figure(1),imagesc(k5*(1));
        title(num2str(contador));
        colormap jet;axis image;axis off
        hold on; h1=plot(yc,xc,'*r');set(h1,'markersize',12);hold off
        caxis([-1 0]);
        colorbar
        if length(px)>0 & length(px1>0);
            if(MOD(px1(1),py1(1))>=0)
                pxaux=round(mean(px));clear px;px=pxaux;
                pyaux=round(mean(py));clear py;py=pyaux;
                if cont==1
                    p_y=py(length(py));p_x=px(length(px));t_x=tx(length(tx));            
                elseif cont>1
                    p_y=[p_y py(length(py))];
                    p_x=[p_x px(length(px))];
                    t_x=[t_x tx(length(tx))];
                end
                %save([narq_saida '.mat'],'p_y','p_x');
                cont=cont+1;
                hold on; h1=plot(py,px,'*w');set(h1,'markersize',12);
                hold off;
                xc=px(length(px));
                yc=py(length(py));
                txc=tx(length(tx));
%                 disp('passe aqui')
            end
            if(cont>1)
                if cont>11
                    p_x1=[p_x1 mean(p_x(cont-10:cont-1))];
                    p_y1=[p_y1 mean(p_y(cont-10:cont-1))];                    
                else
                    clear p_x1 p_y1
                    p_x1=p_x(1:cont-1);
                    p_y1=p_y(1:cont-1);                                             
                end
                t_x1=t_x;
                hold on;
                plot(p_y1,p_x1,'w','linewidth',2)
                                
                save('rota15_4_teste.mat','p_y1','p_x1','t_x1')
                %print -dtiff -r300 Fig2ura_Alfa025_Beta0030
                                      
                hold off;
            end
        end
        u=u+1;
        clc                      
    end
    if(i==pare)
        %i
        %pare=input('Entre com o valor para parar o arquivo da rota: ');
        pause
    end
end
