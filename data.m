function varargout = data(varargin)
% DATA MATLAB code for data.fig
%      DATA, by itself, creates a new DATA or raises the existing
%      singleton*.
%
%      H = DATA returns the handle to a new DATA or the handle to
%      the existing singleton*.
%
%      DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATA.M with the given input arguments.
%
%      DATA('Property','Value',...) creates a new DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help data

% Last Modified by GUIDE v2.5 19-Apr-2017 18:00:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @data_OpeningFcn, ...
                   'gui_OutputFcn',  @data_OutputFcn, ...
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


% --- Executes just before data is made visible.
function data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to data (see VARARGIN)

% Choose default command line output for data
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in seskaydet.
function seskaydet_Callback(hObject, eventdata, handles)
% hObject    handle to seskaydet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

voice_obj = audiorecorder;
k = get(handles.sure, 'String')
k = str2double(k);
if(~isnan(k))
    set(handles.text2, 'String', 'Kayit aliyor!');
    recordblocking(voice_obj, k);
    set(handles.text2, 'String', 'Kayit bitti!');
    my_voice = getaudiodata(voice_obj);
    handles.my_voice = my_voice;
    handles.fs=length(my_voice)/k;
    guidata(hObject, handles);
end

% --- Executes on button press in diskekaydet.
function diskekaydet_Callback(hObject, eventdata, handles)
% hObject    handle to diskekaydet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

kelime = resample(handles.kelime_bir,4000,length(handles.kelime_bir));
name = get(handles.isim, 'String');
audiowrite(strcat(name, '.wav'), kelime, 8000);

function sure_Callback(hObject, eventdata, handles)
% hObject    handle to sure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sure as text
%        str2double(get(hObject,'String')) returns contents of sure as a double


% --- Executes during object creation, after setting all properties.
function sure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function isim_Callback(hObject, eventdata, handles)
% hObject    handle to isim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of isim as text
%        str2double(get(hObject,'String')) returns contents of isim as a double


% --- Executes during object creation, after setting all properties.
function isim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cizdir.
function cizdir_Callback(hObject, eventdata, handles)
% hObject    handle to cizdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sound(handles.my_voice);
axes(handles.axes1);
handles.my_voice = handles.my_voice(1000:end);
plot(handles.my_voice);

threshold = 0.01;
E = find(abs(handles.my_voice)>threshold);
E = E';
% k = 0;
% for i=2:length(E)
%     if (E(i)>E(i-1)+2000)
%         k = i; break;
%     end
% end
% l = length(E);
 
a=E(1);
b=E(end);
% c=E(k);
% d=E(l);
%  
 kelime_bir = handles.my_voice(a:b);
 kelime_bir = kelime_bir';
%  kelime_iki = handles.my_voice(c:d);
%  kelime_iki = kelime_iki';
hold on
 plot(a:b, kelime_bir, 'r');
 hold off
%  hold on
%  plot(c:d ,kelime_iki, 'r');
%  hold on
handles.kelime_bir = kelime_bir;
% handles.kelime_iki = kelime_iki;
guidata(hObject, handles);
