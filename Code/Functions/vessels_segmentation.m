%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Segmentation of the vessels
%
% [msk_vessels]=vessels_segmentation(im_G,msk_ZOI)
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%ENTREES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
% 
%
%   im_G : image in grayscale(green component)
%
%   msk_ZOI   : mask of zone of interest
%            
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%SORTIES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vessels_segmentation.m
% Fatima Ezzahrae Errami & Hajar M'Barki
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [msk_vessels]=vessels_segmentation(im_G,msk_ZOI)

%% segmentation of the vessels



%% pré-processing
% We apply a bottom-hat to highlight the vessels and correct the lightning
% variations
im_G2 = imbothat(im_G,strel('disk',5));


%% Maximum opening
% We apply an opening  with a line inclined in all directions 
%  and we calculate the max opening (this step will allow us to remove
%  artifacts and It will renforce the vessels)

 m = imopen(im_G2, strel('line', 1, 0));
 for i = 1:180
      m = imopen(im_G2, strel('line', 1, i));
      im_G2  = max( im_G2 , m);
 end


% we adjust the contrast
 im_G2  = adapthisteq(  im_G2 );


% We threshold the result with threshold based on maximum of variance

 msk_vessels = tse_imthreshold( im_G2 , 1,'variance');




%% post-processing

% We only take into account our ZOI.
msk_vessels = msk_vessels & msk_ZOI;

% As post treatment we suppress medium size objects disconnected from
% vessel networks, these correspond mostly to the shadow in the center.
msk_vessels = bwareaopen(msk_vessels,90);

% We apply a closing by a small disk to smoothe the borders of the vessels.
msk_vessels = imclose(msk_vessels, strel('disk',1));




end






