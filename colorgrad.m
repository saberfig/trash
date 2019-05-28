function [VG, A, PPG] = colorgrad(f, T)  
if (ndims(f)~=3) || (size(f,3)~=3)  
    error('Input image must be RGB');  
end  

 VG=0;
 A=0;
% fspecial 建立预定义的滤波算子，sobel为边缘提取，无参数
% sobel=[[1,2,1];[0,0,0];[-1,-2,-1]]
sh = fspecial('sobel');
% sv是sh的转置矩阵
sv = sh';
% g=imfilter(f,w,filtering_mode,boundary_options,size_optinos)
% f是输入图像，w为滤波模板，g为滤波结果
% replicate是boundary_options的选项，即通过赋值边界的值来扩展
Rx = imfilter(double(f(:,:,1)), sh, 'replicate'); 
Ry = imfilter(double(f(:,:,1)), sv, 'replicate');  
Gx = imfilter(double(f(:,:,2)), sh, 'replicate');  
Gy = imfilter(double(f(:,:,2)), sv, 'replicate');  
Bx = imfilter(double(f(:,:,3)), sh, 'replicate');  
By = imfilter(double(f(:,:,3)), sv, 'replicate');  

% gxx = Rx.^2 + Gx.^2 + Bx.^2;  
% gyy = Ry.^2 + Gy.^2 + By.^2;  
% gxy = Rx.*Ry + Gx.*Gy + Bx.*By;  
% A = 0.5*(atan(2*gxy./(gxx-gyy+eps)));  
% G1 = 0.5*((gxx+gyy) + (gxx-gyy).*cos(2*A) + 2*gxy.*sin(2*A));  
%    
% A = A + pi/2;  
% G2 = 0.5*((gxx+gyy) + (gxx-gyy).*cos(2*A) + 2*gxy.*sin(2*A));  
% G1 = G1.^0.5;  
% G2 = G2.^0.5;  
% VG = mat2gray(max(G1, G2));

RG = sqrt(Rx.^2 + Ry.^2);  
GG = sqrt(Gx.^2 + Gy.^2);  
BG = sqrt(Bx.^2 + By.^2);  
   
PPG = mat2gray(RG + GG + BG);  

%imshow(im2uint8(PPG))

% if nargin ==2  
%     VG = (VG>T).*VG;  
%     PPG = (PPG>T).*PPG;  
% end  