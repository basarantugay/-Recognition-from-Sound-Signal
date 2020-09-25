function varargout = my_project(varargin)

%
%      MY_PROJECT('Property','Value',...) creates a new MY_PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before my_project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to my_project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help my_project

% Last Modified by GUIDE v2.5 18-Apr-2017 22:17:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @my_project_OpeningFcn, ...
                   'gui_OutputFcn',  @my_project_OutputFcn, ...
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


% --- Executes just before my_project is made visible.
function my_project_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

% UIWAIT makes my_project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = my_project_OutputFcn(hObject, eventdata, handles) 
    

% Get default command line output from handles structure
varargout{1} = handles.output;
guidata(hObject, handles);


% --- Executes on button press in kayit_al.
function kayit_al_Callback(hObject, eventdata, handles)
% hObject    handle to kayit_al (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

voice_obj = audiorecorder;
k = get(handles.edit1, 'String')
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


% --- Executes on button press in cizdir_kelimeyi_bul.
function cizdir_kelimeyi_bul_Callback(hObject, eventdata, handles)
% hObject    handle to cizdir_kelimeyi_bul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sound(handles.my_voice);
set(handles.text2, 'String', 'Ses Cizdirildi!');
threshold=0.01;
axes(handles.axes1);
handles.my_voice = handles.my_voice(1000:end);
plot(handles.my_voice);
hold on

E = find(abs(handles.my_voice)>threshold);
E = E';
k = 0;
for i=2:length(E)
    if (E(i)>E(i-1)+2000)
        k = i; break;
    end
end
l = length(E);
 
a=E(1);
b=E(k-1);
c=E(k);
d=E(l);
 
 kelime_bir = handles.my_voice(a:b);
 kelime_bir = kelime_bir';
 kelime_iki = handles.my_voice(c:d);
 kelime_iki = kelime_iki';

 plot(a:b ,kelime_bir, 'r');
 hold on
 plot(c:d ,kelime_iki, 'r');
 hold on
handles.kelime_bir = kelime_bir;
handles.kelime_iki = kelime_iki;
guidata(hObject, handles);
% --- Executes on button press in pencereleme.
function pencereleme_Callback(hObject, eventdata, handles)
    load 'Data.mat'
    
 kelime1 = resample(handles.kelime_bir,4000,length(handles.kelime_bir));
 kelime2 = resample(handles.kelime_iki,4000,length(handles.kelime_iki));
 
 pencere_uzunlugu1 = (8000 * 0.02);
 pencere_uzunlugu2 = (8000 * 0.02);
 
 no_samp1 = pencere_uzunlugu1;
 no_samp2 = pencere_uzunlugu2;
 
 b1 = 2*(length(kelime1)/no_samp1)-1;  %kelime içinde kaç tane 20ms var
 b2 = 2*(length(kelime2)/no_samp2)-1;
 
 task1 = zeros(1, b1); %her 20ms.deki verileri attýðýmýz matrix
 task2 = zeros(1, b2);
 
 half1 = 0;
 half2 = 0;
 
 pencere1 = [];
 pencere2 = [];
 
 katsayi1 = [];
 katsayi2 = [];
 
 for t1=1:b1
     pencere1 = [pencere1; kelime1(1+half1:no_samp1+half1)];
     task1(t1) = max(abs(fft(kelime1(1+half1:no_samp1+half1))));
     half1 = (no_samp1/2)+half1;
     
     katsayi1 = [katsayi1, task1(t1), lpc(pencere1(t1, :), 11)];
 end
 
 for t2=1:b2
     pencere2 = [pencere2; kelime2(1+half2:no_samp2+half2)];
     task2(t2) = max(abs(fft(kelime2(1+half2:no_samp2+half2))));
     half2 = (no_samp2/2)+half2;
  
     katsayi2 = [katsayi2, task2(t2), lpc(pencere2(t2, :), 11)];
 end
 struct = svmtrain(Data, [ones(25,1); zeros(225, 1)]);
 group = svmclassify(struct, katsayi1);
 

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
