function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 28-May-2019 13:00:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

axes(handles.rawImage);
imshow('white.jpg');
axes(handles.newImage);
imshow('white.jpg');

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
[filename,filepath]=uigetfile({'*.bmp;*.jpg;*.png;*.jpeg;*.tif',...
    '文件类型 (*.bmp,*.jpg,*.png,*.jpeg,*.tif)';'*.*', '所有文件(*.*)'},...
    'Pick an image');
file=strcat(filepath,filename);
I=imread(file);
axes(handles.rawImage);
imshow(I);


% --- Executes on button press in store.
function store_Callback(hObject, eventdata, handles)
% hObject    handle to store (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.store_name,'Visible','on');


function store_name_Callback(hObject, eventdata, handles)
% hObject    handle to store_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of store_name as text
%        str2double(get(hObject,'String')) returns contents of store_name as a double
h=getframe(handles.newImage);
I=h.cdata;
name=get(handles.store_name,'Value');
%disp(name);



% --- Executes during object creation, after setting all properties.
function store_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to store_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sketch.
function sketch_Callback(hObject, eventdata, handles)
% hObject    handle to sketch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sketch_transfer,'Visible','on');

% --- Executes on button press in oilpaint.
function oilpaint_Callback(hObject, eventdata, handles)
% hObject    handle to oilpaint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in seal.
function seal_Callback(hObject, eventdata, handles)
% hObject    handle to seal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sharpen.
function sharpen_Callback(hObject, eventdata, handles)
% hObject    handle to sharpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sharpen_slider,'Visible','on');


% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
h=imrect;
pos=getPosition(h);
imCp=imcrop(I,pos);
axes(handles.newImage);
imshow(imCp);

% --- Executes on button press in magic.
function magic_Callback(hObject, eventdata, handles)
% hObject    handle to magic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
% sh = fspecial('sobel');
% P=imfilter(I,sh,'replicate');
[m,n]=size(I(:,:,1));
h=imrect;
pos=round(getPosition(h));
tolerance=10;
% thresh=graythresh(A);
% B=im2bw(A,thresh);
thresh=graythresh(A+tolerance);


% for ii=pos(1):pos(3)
%     for jj=pos(2):pos(4)
%         
% for ii=1:m
%     for jj=1:n
        



% --- Executes on button press in tool.
function tool_Callback(hObject, eventdata, handles)
% hObject    handle to tool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in coverage.
function coverage_Callback(hObject, eventdata, handles)
% hObject    handle to coverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sketch_transfer.
function sketch_transfer_Callback(hObject, eventdata, handles)
% hObject    handle to sketch_transfer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sketch_transfer,'Visible','off');
global I;
[VG,A,PPG] = colorgrad(I,200);  
ppg = im2uint8(PPG);  
ppgf = 255 - ppg;  
[M,N] = size(ppgf);T=200;  
ppgf1 = zeros(M,N);  
for ii = 1:M  
    for jj = 1:N  
        if ppgf(ii,jj)<T  
            ppgf1(ii,jj)=0;  
        else  
            ppgf1(ii,jj)=235/(255-T)*(ppgf(ii,jj)-T);  
        end
    end
end
ppgf1 = uint8(ppgf1);  
axes(handles.newImage);
imshow(ppgf1);


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function sharpen_slider_Callback(hObject, eventdata, handles)
% hObject    handle to sharpen_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global I;
%https://blog.csdn.net/cXiao_yue/article/details/80095173
value=get(handles.sharpen_slider,'value')
sh = fspecial('sobel');
P=imfilter(I,sh,'replicate');
Q=I-value*P;
axes(handles.newImage);
imshow(Q);


% --- Executes during object creation, after setting all properties.
function sharpen_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sharpen_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in next_operation.
function next_operation_Callback(hObject, eventdata, handles)
% hObject    handle to next_operation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
% getframe获取坐标轴中的一帧图像
%axes(handles.newImage);
% I =get(handles.newImage,'img_src');
% axes(handles.rawImage);
% imshow(I);

%h=getframe(handles.newImage);
%I=h.cdata;
axes(handles.newImage);
I=getimage(gcf)
axes(handles.rawImage);
imshow(I);

% newf = figure('visible','off');
% %产生不可见的figure对象 
% axes2 = copyobj(handles.newImage,gcf);
% %把GUI中的图复制到新figure中 
% set(axes2,'units','default','position','default');
% %对axes进行设置 
% hgexport(gcf,'-clipboard');
% %输出到剪贴板 
% delete(newf); %删除不可见的figure


% --- Executes on button press in smooth.
function smooth_Callback(hObject, eventdata, handles)
% hObject    handle to smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.smooth_box,'Visible','on');
set(handles.smooth_gaosi,'Visible','on');
set(handles.smooth_middle,'Visible','on');

% --- Executes on button press in smooth_box.
function smooth_box_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
[row,col]=size(I(:,:,1));
P=im2double(I);
for i=2:row-1
    for j=2:col-1
        SUM=0;
        for m=i-1:i+1
            for n=j-1:j+1
                SUM=SUM+P(m,n);
            end
        end
        P(i,j)=SUM/9;
    end
end
axes(handles.newImage);
imshow(P);


% --- Executes on button press in smooth_gaosi.
function smooth_gaosi_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_gaosi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
[row,col]=size(I(:,:,1));
Q=im2double(I);
for i=2:row-1
    for j=2:col-1
        SUM=0;
        for m=i-1:i+1
            for n=j-1:j+1
                SUM=SUM+P(m,n);
            end
        end
        P(i,j)=(SUM+P(i,j))/10;
    end
end
axes(handles.newImage);
imshow(P);


% --- Executes on button press in smooth_middle.
function smooth_middle_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_middle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
[row,col]=size(I(:,:,1));
R=im2double(I);
Z=zeros(1,10);
for i=2:row-1
    for j=2:col-1
        %disp(R(i,j));
        x=1;
        for m=i-1:i+1
            for n=j-1:j+1
                Z(1,x)=Q(m,n);
                x=x+1;
            end
        end
        for x=1:9
            m=10-x;
            for n=1:m
                if(Z(1,n)>Z(1,n+1))
                    Z(1,10)=Z(1,n);
                    Z(1,n)=Z(1,n+1);
                    Z(1,n+1)=Z(1,10);
                end
            end
        end
        R(i,j)=Z(1,5);
        %disp(Z);
        %disp(R(i,j));
    end
end
axes(handles.newImage);
imshow(R);



