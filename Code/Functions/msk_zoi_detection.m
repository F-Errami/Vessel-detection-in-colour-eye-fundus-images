%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Segmentation of the mask of ZOI
% [msk_ZOI]=msk_zoi_detection(im_G)
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%ENTREES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
% 
%
%   im_G : image in grayscale(green component)
%       
%            
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%SORTIES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%               Msk of zone of interest
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vessels_segmentation.m
% Fatima Ezzahrae Errami & Hajar M'Barki
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [msk_ZOI]=msk_zoi_detection(im_G)

%% calculer le module du gradient
 gradient = imgradient(im_G);

 %% Appliquer un seuil sur la magnitude du gradient
  msk_ZOI = imbinarize(gradient);
  
 %% Suppression des petits objets du masque
 
  msk_ZOI = bwareaopen(msk_ZOI, 10);

  %% Remplir les trous
  msk_ZOI= imfill(msk_ZOI,'holes') ;



end
