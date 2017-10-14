
% Realiza un suavizado basado en un filtro gaussiano.
%
% [Entradas]
% imGray  : Imagen en escala de grises.
% sigma   : El tama�o de hsize debe depender de sigma, en una relaci�n
%           hsize = 6*sqrt(2*sigma) + 1. Cuanto mayor sea la sigma m�s se 
%           tendr� en cuenta a vecinos lejanos en el suavizado.
% hsize   : Tama�o de la m�scara con la que realizar el suavizado.
% exeMode : Con exeMode a 2, se utiliza la propiedad de separabilidad para
%           realizar las convoluciones.
%
% [Salidas]
% imRes : Imagen resultado (imGray suavizada).
% time  : Tiempo que ha tardado en ejecutarse.
% mask  : M�scara utilizada para realizar el suavizado.

function [imRes, time, mask] =  gaussFilter(imGray, sigma, hsize, exeMode)

    tic;
    
    % Creamos la mascara para el suavizado, dependiendo del modo de
    % ejecucion especificado por el usuario
    
    if ( exeMode == 1 )
        
        h = fspecial('gaussian',[hsize, hsize], sigma);
        imRes = conv2(double(imGray),h, 'same');
        
        mask = h;
        
    else % usando separabilidad  
        
        g_x = fspecial('gaussian',[1, hsize], sigma);
        g_y = fspecial('gaussian',[hsize, 1], sigma);
        
        imAux = conv2(double(imGray),g_x, 'same');
        imRes = conv2(double(imAux),g_y, 'same');
        
        mask = g_y*g_x;
        
    end
    
    % Convertirmos la imagen obtenida
    imRes = uint8(imRes);  
    
    time = toc;
    
  
    
    