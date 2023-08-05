function varargout = SimpleGUI(varargin)
% SIMPLEGUI MATLAB code for SimpleGUI.fig
%      SIMPLEGUI, by itself, creates a new SIMPLEGUI or raises the existing
%      singleton*.
%
%      H = SIMPLEGUI returns the handle to a new SIMPLEGUI or the handle to
%      the existing singleton*.
%
%      SIMPLEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLEGUI.M with the given input arguments.
%
%      SIMPLEGUI('Property','Value',...) creates a new SIMPLEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimpleGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimpleGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimpleGUI

% Last Modified by GUIDE v2.5 09-Jun-2021 17:15:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimpleGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SimpleGUI_OutputFcn, ...
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


% --- Executes just before SimpleGUI is made visible.
function SimpleGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimpleGUI (see VARARGIN)

% Choose default command line output for SimpleGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SimpleGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SimpleGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Generate Keys.
function pushbutton1_Callback(hObject, eventdata, handles)

if(strcmp(handles.edit1.String,'Path'))
    str='You should Select Image first';
    set(handles.text8,'String',str);
else
disp('ECC parameters a=-7, b=10, p=487 and G= (13,46)');
[x]=pso(handles.SelectedImage);
[peaksnr,R,C,N]=Pso_Fitness(x,handles.SelectedImage);
str= 'private Key is= '+string(x)+ ' and public key = ('+string(R(1))+','+string(R(2))+')';
axes(handles.axes2); 
imshow(uint8(C));
axes(handles.axes3); 
imshow(uint8(N));
set(handles.text8,'String',str);
set(handles.text5,'String',peaksnr);
end
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[output,peaksnr] =MainAlg(handles.SelectedImage);
axes(handles.axes2);
set(handles.text5,'String',peaksnr);
set(handles.text6,'String','The embedding process is done!');
imshow(uint8(output));
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
close all;

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in choose image.
function pushbutton4_Callback(hObject, eventdata, handles)
[File,Path] = uigetfile('*.jpg','Select Image');
if isequal(File,0)
   disp('User selected Cancel')
else
   handles.eximg=1;
   guidata(hObject,handles);
   path = strcat(Path,File);
   handles.SelectedImage= imread(path);
   handles.SelectedImage=Read_Imag(handles.SelectedImage);
   axes(handles.axes1); 
   imshow(uint8(handles.SelectedImage));
   guidata(hObject,handles);
   set(handles.edit1,'String',path);
end

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clear 
function pushbutton5_Callback(hObject, eventdata, handles)
cla(handles.axes1)
cla(handles.axes2)
cla(handles.axes3)
set(handles.edit1,'String','Path');
set(handles.text5,'String','.');
set(handles.text8,'String','.');
handles.cimg=0;
guidata(hObject,handles);
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
