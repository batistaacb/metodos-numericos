function varargout = interface_grafica(varargin)
% INTERFACE_GRAFICA M-file for interface_grafica.fig
%      INTERFACE_GRAFICA, by itself, creates a new INTERFACE_GRAFICA or raises the existing
%      singleton*.
%
%      H = INTERFACE_GRAFICA returns the handle to a new INTERFACE_GRAFICA or the handle to
%      the existing singleton*.
%
%      INTERFACE_GRAFICA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE_GRAFICA.M with the given input arguments.
%
%      INTERFACE_GRAFICA('Property','Value',...) creates a new INTERFACE_GRAFICA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_grafica_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interface_grafica_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface_grafica

% Last Modified by GUIDE v2.5 12-Apr-2013 22:34:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_grafica_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_grafica_OutputFcn, ...
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


% --- Executes just before interface_grafica is made visible.
function interface_grafica_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface_grafica (see VARARGIN)

% Choose default command line output for interface_grafica
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface_grafica wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface_grafica_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
