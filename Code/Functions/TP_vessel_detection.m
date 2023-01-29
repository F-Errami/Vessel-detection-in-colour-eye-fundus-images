
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vessels detection
%
% [] = TP_vessel_detection( PROJ_D , filename , LogId )
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%ENTREES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%   PROJ_D  % Root directory of the project
%
%   kpack  : identyfying number of the package
%            1  Database Drive (train set)
%
%   filename_in : full image filename
%
%
%   LogId    : (Optional) ID of the LOG file (> 2) /Display (1) / Nothing (0)
%               Default : 0
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%SORTIES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP_vessel_detection.m
% Fatima Ezzahrae Errami & Hajar M'Barki
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [] = TP_vessel_detection( PROJ_D , kpack, filename_in , LogId )

% save('my_workspace.mat')
% close all; clearvars;
% load('my_workspace.mat');

%% Parameters

flag_display    = false;%true;% flag of display



%% Image name



[~,im_name_in] = fileparts(filename_in);


%% Program

%% try : to intercept the errors
%try



% image file
im = double(imread(filename_in))/255;


if flag_display
   
    figure();
    imagesc(im); colormap gray; hold on;
    title(sprintf('image %s',im_name_in));
    axis equal
end


% Séparation de la composante verte 

im_G= im(:,:,2);

if flag_display
    
    figure();
    imagesc(im_G); colormap gray; hold on;
    title('Green component');
    axis equal
end

%% segmentation of the ZOI (Zone of interest)

msk_ZOI = msk_zoi_detection(im_G);




if flag_display
    
    figure();
    imagesc(msk_ZOI); colormap gray; hold on;
    title('My segmentation of the ZOI!!!');
    axis equal
end



%% segmentation of the vessels


msk_vessels=vessels_segmentation(im_G,msk_ZOI);



%% Saving the results


kfile = 11; % Mask of the image Zone of Interest    
[fname] = TP_GEN_filenames( PROJ_D , kpack, kfile, filename_in);
ajout_dossier(fname);
imwrite( msk_ZOI , fname );
fprintf('<------------------- Saved : %s\n',fname);


kfile = 21; % vessels_mask
[fname] = TP_GEN_filenames( PROJ_D , kpack, kfile, filename_in);
ajout_dossier(fname);
imwrite( msk_vessels , fname );
fprintf('<------------------- Saved : %s\n',fname);

%% Superimposition of the boundary of the mask vessels to the image
if 1
    boundary_vessels = bwboundaries(msk_vessels);
    im_R = im(:,:,1);
    im_G = im(:,:,2);
    im_B = im(:,:,3);
    SZ = size(im);
    for n=1:length(boundary_vessels)
       bv_ij = boundary_vessels{n};
       ind = sub2ind( SZ(1:2) , bv_ij(:,1) , bv_ij(:,2) );
       im_R(ind) = 255;
       im_G(ind) = 255;
       im_B(ind) = 255;
    end
    im_col_out = cat(3,im_R,im_G,im_B);
    
    
    kfile = 22; % vessels_mask superimposed on the image
    [fname] = TP_GEN_filenames( PROJ_D , kpack, kfile, filename_in);
    imwrite( im_col_out , fname );
    fprintf('<------------------- Saved : %s\n',fname);
    
    
    if flag_display

        figure();
        imagesc(im_col_out); colormap gray; hold on;
        title('Boundaries of the vessels!');
        axis equal
    end
end

if flag_display
   pause(5);% a pause of 5 seconds
   close all;
end

% % Catch : to write the error message in the Log file
% 
% %% Error management
% catch ME
%     EvenementLOG(LogId, 1, ME.message, 1);
% end
