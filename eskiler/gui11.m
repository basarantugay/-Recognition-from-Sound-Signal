function varargout = gui1(varargin)
% GUI1 MATLAB code for gui1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui1

% Last Modified by GUIDE v2.5 01-Mar-2017 16:43:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui1_OutputFcn, ...
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


% --- Executes just before gui1 is made visible.
function gui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui1 (see VARARGIN)

% Choose default command line output for gui1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in kayital.
function kayital_Callback(hObject, eventdata, handles)
voice_obj = audiorecorder;
k = get(handles.edit1, 'String')
k = str2double(k);
if(~isnan(k))
    
    recordblocking(voice_obj, k);
    
    my_voice = getaudiodata(voice_obj);
    handles.my_voice = my_voice;
    handles.fs=length(my_voice)/k;
    guidata(hObject, handles);
end


% --- Executes on button press in cizdir.
function cizdir_Callback(hObject, eventdata, handles)

sound(handles.my_voice);
threshold=0.05;
axes(handles.axes1);
handles.my_voice = handles.my_voice(1000:end);
plot(handles.my_voice);
hold on
% k=0;
% l = 0;
% for i=1:length(handles.my_voice)
%     if (handles.my_voice(i)>threshold)
%         k = i; break;
%     end
% end
% 
% for i=length(handles.my_voice):-1:1
%     if (handles.my_voice(i)>threshold)
%         l = i; break;
%     end
% end
% 

% 
% kelime = handles.my_voice(k:l);
% 
% plot(k:l ,kelime, 'r');
% hold off
% 
% handles.my_voice = resample(handles.my_voice,24000,length(handles.my_voice));
% kelime = resample(kelime,8000,length(kelime) );
% 
% pencere_uzunlugu = (8000 * 0.02);

% no_samp = pencere_uzunlugu;

% b = 2*(length(kelime)/no_samp)-1;  %kelime içinde kaç tane 20ms var


% task = zeros(1, b); %her 20ms.deki verileri attýðýmýz matrix

% half = 0;

% for t=1:b
%     task(t) = max(abs(fft(kelime(1+half:no_samp+half))));
%     half = (no_samp/2)+half;
%     
% end
 E = find(abs(handles.my_voice)>0.05);
 o=E(1);
 l=zeros(1,length(E));
 m=1;
 for r=1:length(E)
     if(E(r+1)>E(r)+200)
         l(1,m)=r;
         m=m+1;
     end
 end
 t
 p=0;
% c = 2*(length(handles.my_voice)/no_samp)-1;
% k=1;
% word_start = zeros(1, c);
% for t=1:c
%     if(mean(abs(handles.my_voice(1+half:no_samp+half)))>0.05)
%        word_start(k) = handles.my_voice(1+half:no_samp+half);   
%        k=k+1;
%     end
%     half = (no_samp/2)+half;
% 
% end






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
