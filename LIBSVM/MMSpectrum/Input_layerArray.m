% The optical functions for various materials have been programed in two
% libraries; one library is for anisotropic materials (MaterialLib) and the
% other is for isotropic materials (MaterialLib_iso).Browse to see what is 
% there. The material names are in purple. 

edit MaterialLib
edit MaterialLib_iso

% Sample parameters are entered into the cell array "layer", organized as: 

% layer = {'material',d,eul,bool_thin,bool_isotropic};

    % 'material' =      string giving name of a material in MaterialLib or MaterialLib_iso
    % d =               thickness in nm.
    % eul =             [Z,X,Z] array of passive Euler rotation angles (deg)
    % bool_thin =       true for the thick layer. (should be only one for PW method)
    % bool_isotropic =  true if the material is isotropic.
    
% For multilayers, each array layer is ordered into a larger cell array "layerArray".
% The ambient medium should always be the first layer, i.e., layerArray{1}.
% The exit medium (or possibly the substrate material in reflection),
% should be put as the last layer in layerArray.

% Example: 1 mm ~c-cut +quartz coated in 20 nm of a-cut TiO2 in air. The
% TiO2 layers are misaligned by 45 deg. 

layerArray{1} = {'air',0,[32,1.2,0],1,1};
layerArray{2} = {'TiO2',20,[0,90,0],1,0};
layerArray{3} = {'+quartz',1000000,[24,0.3,0],0,0};
layerArray{4} = {'TiO2',20,[45,90,0],1,0};
layerArray{5} = {'air',0,[32,1.2,0],1,1};

%To calculate the optical response using the PW method and plot the Mueller
%matrix, run the function MMSpectrumPW.

% MM = MMSpectrumPW(layerArray,Lam,AOI,bool_reflect);

% Lam =          Array of wavelengths to compute, in nm.
% AOI =          angle of incidence, in degrees. 
% bool_reflect = true for reflection calculation, false for transmission.

% To plot from 300 nm to 700 nm in transmission at 40 deg off axis: 

MM = MMSpectrumPW(layerArray,300:700,40,true);

%The Berreman method can be applied to calculate multilayers with only thin
%layers. The function is MMSpectrumCoher, and it has the same inputs as PW.

% Example: change the quartz layer to make the layer only 5 um, and change
% the bool_thin to true (i.e., layerArray{3}{4} = true)

layerArray{3} = {'+quartz',5000,[24,0.3,0],1,0};

% and run the function,

MM = MMSpectrumCoher(layerArray,300:700,40,true);
