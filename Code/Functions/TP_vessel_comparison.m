
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Comparison between vessel segmentation and its groundtruth
%
% [] = TP_vessel_comparison( PROJ_D , filename , LogId )
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
% TP_vessel_comparison.m
% Fatima Ezzahrae Errami & Hajar M'Barki
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [] = TP_vessel_comparison( PROJ_D , kpack, filename_in , LogId )


%% Parameters

flag_display    = false;%true;% flag of display



%% Image name

[~,im_name_in] = fileparts(filename_in);


%% Program

%% try : to intercept the errors
try

    
%% Reading of the ZOI mask

kfile = 11; % Mask of the image Zone of Interest    
[fname] = TP_GEN_filenames( PROJ_D , kpack, kfile, filename_in);
msk_ZOI = imread( fname );

if flag_display
    figure();
    imagesc(msk_ZOI); colormap gray; hold on;
    title('My segmentation of the ZOI!');
    axis equal
end

%% Reading of the program segmentation

kfile = 21; % vessels_mask
[fname] = TP_GEN_filenames( PROJ_D , kpack, kfile, filename_in);

msk_vessels = imread( fname );

if flag_display
    figure();
    imagesc(msk_vessels); colormap gray; hold on;
    title('My segmentation of the vessels!');
    axis equal
end

%% reading the reference

kfile = 31; % Reference segmentation (ground-truth)
[fname] = TP_GEN_filenames( PROJ_D , kpack, kfile, filename_in);

msk_vessels_ref = imread( fname );
msk_vessels_ref = msk_vessels_ref>0;

if flag_display
    
    figure();
    imagesc(msk_vessels_ref); colormap gray; hold on;
    title('Reference segmentation made by an expert');
    axis equal
end


%% Comparison between the programm segmentation and the reference

[ TPR , TNR , Acc ,dice, Ntab , msk_TP , msk_FP , msk_FN , msk_TN ] = SensibilitySpecificity2imseg( msk_vessels_ref , msk_vessels , msk_ZOI );

fprintf('Sensitivity = %.02f %%\n',TPR*100);
fprintf('Specificty = %.02f %%\n',TNR*100);
fprintf('Accuracy = %.02f %%\n',Acc*100);
fprintf('Dice coefficient = %.02f %%\n',dice*100);

%% Saving results



if flag_display
   pause(5);% a pause of 5 seconds
   close all;
end

%% Catch : to write the error message in the Log file

%% Error management
catch ME
    EvenementLOG(LogId, 1, ME.message, 1);
end
