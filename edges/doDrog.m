
% Detecta bordes de una imagen utilizando la aproximaci�n discreta del
% operador gradiente Sobel.
%
% [Entradas]
% imGray : Imagen en escala de grises.
% long   : Tama�o de la m�scara = 2*long + 1.
% sigma  : El tama�o de long debe depender de sigma, en una relaci�n
%          long = 3*sqrt(2*sigma). Cuanto mayor sea la sigma m�s se 
%          tendr� en cuenta a vecinos lejanos en el suavizado.
% th     : Umbral para considerar a partir de valor en la imagen gradiente
%           se considera borde.
% 
% [Salidas]
% imRes  : Imagen resultado (bordes detectados en imGray).
% imX    : Imagen gradiente a lo largo de las columnas (detecci�n de bordes
%          verticales).
% imY    : Imagen gradiente a lo largo de las filas (detecci�n de bordes
%          horizontales).
% imGrad : Imagen gradiente.
% time   : Tiempo que ha tardado en ejecutarse.

function [imRes, imX, imY, imGrad, time] = doDrog (imGray, long, sigma, th)

    tic;
    
    % Tama�o de la m�scara 2*long+1
    x = ( -long : long );
    
    g_x = fspecial('gaussian', [1, length(x)], sigma);
    g_y = fspecial('gaussian', [length(x), 1], sigma);
    
    % Creamos las mascaras de la derivadas en x e y
    drog_x = g_y*(-x.*g_x)/(sigma^2);
    drog_y = (-x'.*g_y)*g_x/(sigma^2);
    
    % Obtenemos las imagenes gradientes
    imX = conv2(double(imGray),double(drog_x),'same');
    imY = conv2(double(imGray),double(drog_y),'same');
    
    % Renemobramos el umbral
    umbral = th;
   
    % Comprobamos que pixels de las imagenes gradiente superan el umbral
    % |x| + |x| > umbral
    imGrad = abs(imX) + abs(imY);
    imRes = ((abs(imX) + abs(imY)) < umbral)*255;

    % Convertimos de formato la imagen gradient
    imGrad = uint8(imGrad);
    
    time = toc;
   
  
