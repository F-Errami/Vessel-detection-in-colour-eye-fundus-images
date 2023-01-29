
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Comparison between vessel segmentation and its groundtruth and caluclate
% mean values of sencitivity, specificity, accuracy and dice coefficient
%
% [sensitivity_m,specificity_m,accuracy_m,dice_m ]=  TP_vessel_comparison_moyenne( PROJ_D , kpack ,l_filename_im,LogId)
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%ENTREES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%   PROJ_D  % Root directory of the project
%
%   kpack  : identyfying number of the package
%            1  Database Drive (train set)
%
%   l_filename_im : list of image name
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
function [sensitivity_m,specificity_m,accuracy_m,dice_m ]=  TP_vessel_comparison_moyenne( PROJ_D , kpack ,l_filename_im,LogId)
%% Program
% calculate the number of pictures
[nim] = length(l_filename_im);

%% initialize
sensitivity_m= 0;
specificity_m =0;
accuracy_m = 0;
dice_m = 0;




% we loop on all the pictures
kim_ini = 1;
for kim = kim_ini:nim



    
    %% Image name
    
    filename =  fullfile( l_filename_im(kim).folder , l_filename_im(kim).name );
    
    
    
        
    %% Reading of the ZOI mask
    
    kfile = 11; % Mask of the image Zone of Interest    
    [fname] = TP_GEN_filenames( PROJ_D , kpack, kfile,filename);
    msk_ZOI = imread( fname );
    
    
    %% Reading of the program segmentation
    
    kfile = 21; % vessels_mask
    [fname] = TP_GEN_filenames( PROJ_D , kpack, kfile,filename);
    
    msk_vessels = imread( fname );
    
    %% reading the reference
    
    kfile = 31; % Reference segmentation (ground-truth)
    [fname] = TP_GEN_filenames( PROJ_D , kpack, kfile, filename);
    
    msk_vessels_ref = imread( fname );
    msk_vessels_ref = msk_vessels_ref>0;
    
    
    
    
    %% Comparison between the programm segmentation and the reference
    
    [ TPR , TNR , Acc ,dice, Ntab , msk_TP , msk_FP , msk_FN , msk_TN ] = SensibilitySpecificity2imseg( msk_vessels_ref , msk_vessels , msk_ZOI );
    
    sensitivity_m= sensitivity_m + TPR;
    specificity_m = specificity_m+TNR;
    accuracy_m = accuracy_m+Acc;
    dice_m = dice_m +dice;




 end

% dividing by the number of images
sensitivity_m= sensitivity_m /nim;
specificity_m = specificity_m /nim;
accuracy_m = accuracy_m/nim;
dice_m = dice_m / nim;

%Display result
fprintf('-------------------- Statistiques:-------------------------------- \n');
fprintf('Sensitivity mean = %.02f %%\n',sensitivity_m*100);
fprintf('Specificty mean = %.02f %%\n',specificity_m*100);
fprintf('Accuracy mean = %.02f %%\n',accuracy_m*100);
fprintf('Dice coefficient mean = %.02f %%\n',dice_m*100);





