function varargout = pivotal_de_gauss(varargin)
% PIVOTAL_DE_GAUSS M-file for pivotal_de_gauss.fig
%      PIVOTAL_DE_GAUSS, by itself, creates a new PIVOTAL_DE_GAUSS or raises the existing
%      singleton*.
%
%      H = PIVOTAL_DE_GAUSS returns the handle to a new PIVOTAL_DE_GAUSS or the handle to
%      the existing singleton*.
%
%      PIVOTAL_DE_GAUSS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIVOTAL_DE_GAUSS.M with the given input arguments.
%
%      PIVOTAL_DE_GAUSS('Property','Value',...) creates a new PIVOTAL_DE_GAUSS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pivotal_de_gauss_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pivotal_de_gauss_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pivotal_de_gauss

% Last Modified by GUIDE v2.5 22-Feb-2013 12:12:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pivotal_de_gauss_OpeningFcn, ...
                   'gui_OutputFcn',  @pivotal_de_gauss_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before pivotal_de_gauss is made visible.
function pivotal_de_gauss_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pivotal_de_gauss (see VARARGIN)

% Choose default command line output for pivotal_de_gauss
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pivotal_de_gauss wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pivotal_de_gauss_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=get(handles.uitable1,'value');
b=get(handles.uitable3,'value');
M=[A b];                                                                   % Matriz aumentada do sistema obtida através de concatenação.
max=length(b);                                                             % Numero de linhas igual a dimensão do vetor b.
I=eye(max);                                                                % Matriz identidade que vai corrigir permutações de colunas.
cont=1;                                                                    % Garantir que na proxima iteração, não vamos passar por uma linha escalonada.
% =========================================================================
%     ASSEGURANDO QUE O PIVO SERA O NUMERO DE MAIOR MODULO E PODENDO 
% =========================================================================
for int=1:(max-1)                                                          % Laço interage o pivoteamento com o escalonamento.
    pivo=0;                                                                % Variavel para armazenar dados de "abs(M(i,j)"  tem que ser zerada após uma escalonamento.
    for i=cont:max                                                         % Percorrendo linhas para encontrar termo de maior modulo.
        for j=cont:max                                                     % Percorrendo colunas para encontrar termo de maior modulo.
           if abs(M(i,j))> pivo                                            % Identificando o maio termo de maior modulo. 
           pivo=abs(M(i,j));                                               % Armazenando o termo de maior modulo.
           linha=i;                                                        % Identificando a linha onde se encontra o termo de maior modulo.
           coluna=j;                                                       % Identificando a coluna onde se encontra o termo de maior modulo. 
           end                                                             % Abaixo vai ocorrer as permutações de linhas
        end   
    end
M_l=M(cont,:);                                                             % Uma variavel armazena a linha para onde vai  elemento de maior modulo.
M(cont,:)=M(linha,:);                                                      % Linha pivotal recebe a linha onde se encontra o termo de maior modulo.
M(linha,:)=M_l;                                                            % A linha armazenada na variavel é deslocada para linha onde se encontrava o termo de maior modulo  
M_c=M(:,cont);                                                             % Uma variavel armazena a coluna para onde vai ser deslocado a coluna cujo elemento possui maior modulo.
M(:,cont)=M(:,coluna);                                                     % coluna pivotal recebe a coluna onde se encontra o termo de maior modulo.
M(:,coluna)=M_c;                                                           % A coluna armazenada na variavel é deslocada para coluna onde se encontrava o termo de maior modulo  
I_c=I(:,cont);                                                             % Os procedimentos realizados 
I(:,cont)=I(:,coluna);                                                     % nas colunas da matriz M
I(:,coluna)=I_c;                                                           % são repetidos para uma matriz identidade
% =========================================================================
%  METODO PIVOTAL DE GAUSS COM MATRIZ LOWER ARMAZENANDO OS MULTIPLICADORES
% =========================================================================
j=cont;                                                                    % O escalonamento é uma coluna da cada vez.
for i=(j+1):max                                                            % "i" esta um passo a frente de "pois" não se escalona a linha que contém o pivo.                  
    L=M(i,j)/M(j,j);                                                       % Obetendo o termo que vai escalonar a linha.
    M(i,:)=-L*(M(j,:))+(M(i,:));                                           % Escalonando a linha da matriz       
end
cont=cont+1;                                                               % na próxima iteracao vamos escalonar a proxima linha.
end
U=M(1:max,1:max);                                                          % Matriz triangular superior modificada por operações elementares e permutações de colunas.
D=M(1:max,max+1);                                                          % Matriz b alterada pelas operações elementares.
% =========================================================================
% Utilazando o metodo das substituições retroativas  resolver  U*x=D    
% =========================================================================
x(max)=(D(max))/(U(max,max));                                              % ja conseguimos o ultimo elemento do vetor resposta.
for i=max:-1:1                                                             % passo decrescente ate chegar em 1
    soma=0;                                                                % variavel soma recebe zero, pois sua funcao cumulativa é no laço interno
    for j=i+1:max                                                          % j varia de um digito acima de i até o maximo 
        soma=soma+(U(i,j))*(x(j));                                         % variavel cumulativa que são os elementos deslocados a direita da igualdade
    end                                                                    % isto fica mais evidente na linha abaixo, onde temos o sinal negativo e o denominador
    x(i)=(D(i)-soma)/(U(i,i));                                             %  denominador é o numero que multiplica x(i) na equação
end                                                                        % escrevendo o resultado, usando a funcao de matriz transposta, pois a resposta é 
X=I*x';                                                                    % REORGANIZANDO DEVIDO A MUDANÇAS DE COLUNAS, USANDO A MATRIZ IDENTIDADE 
set(handles.uitable3,'value',X)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
