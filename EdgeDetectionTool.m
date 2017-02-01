function varargout = EdgeDetectionTool(varargin)
% EDGEDETECTIONTOOL MATLAB code for EdgeDetectionTool.fig
%      EDGEDETECTIONTOOL, by itself, creates a new EDGEDETECTIONTOOL or raises the existing
%      singleton*.
%
%      H = EDGEDETECTIONTOOL returns the handle to a new EDGEDETECTIONTOOL or the handle to
%      the existing singleton*.
%
%      EDGEDETECTIONTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDGEDETECTIONTOOL.M with the given input arguments.
%
%      EDGEDETECTIONTOOL('Property','Value',...) creates a new EDGEDETECTIONTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EdgeDetectionTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EdgeDetectionTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EdgeDetectionTool

% Last Modified by GUIDE v2.5 28-Jan-2017 20:32:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EdgeDetectionTool_OpeningFcn, ...
                   'gui_OutputFcn',  @EdgeDetectionTool_OutputFcn, ...
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


% --- Executes just before EdgeDetectionTool is made visible.
function EdgeDetectionTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EdgeDetectionTool (see VARARGIN)

% Choose default command line output for EdgeDetectionTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EdgeDetectionTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EdgeDetectionTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
clear;
Ieval;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global Ieval;
    filename=uigetfile({'*.png;*.jpg;*.jpeg'},'Select an Image');
    Irgb = imread(filename);
    Igray = rgb2gray(Irgb);
    %Fuzzy logic toolbox operates on double precision matrices.
    I = double(Igray)/255;
    % fuzzy logic edge-detection algorithm for this example relies on the image
    % gradient to locate breaks in uniform regions
    Gx = [-1 1];
    Gy = Gx';
    Ix = conv2(I,Gx,'same');
    Iy = conv2(I,Gy,'same');
    fis = readfis('edgeDetection.fis');
    Ieval = I;   % Preallocate the output matrix
    for ii = 1:size(I,1)
        Ieval(ii,:) = evalfis([(Ix(ii,:));(Iy(ii,:));]',fis);
    end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %plotting the result
    global Ieval;
    figure; imagesc(255-Ieval); colormap('gray');
    title('Edge Detection Using Fuzzy Logic')