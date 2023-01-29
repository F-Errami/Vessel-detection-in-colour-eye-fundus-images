% Script_Analysis_EyeFundusImages.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fatima Ezzahrae Errami & Hajar M'Barki
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clearvars;

%% Parameters to be modified

% number of image dataset
% kpack
% 1 : Drive database: train set

kpack = 1;




% Flags for running the different parts of the program
flag = zeros(100,1);

flag(1)  = 1 ;   % # Vessel segmentation
flag(2)  = 1 ;   % # Comparaison between vessel segmentation and its reference

% flag to write the LOG file
flag_write_LOG_file = true;%false;%true;


%% Manage directories

SCRIPT_D = fileparts(mfilename('fullpath')); %directory of the script
addpath(genpath(SCRIPT_D));
PROJ_D  = manage_path_str(fullfile(SCRIPT_D,'..'));%  Root directory of the project

%DATA_D  % data directory
%INPUT_DATA_D  % input data directory
%DB_D    % database directory
%RES_D   % results directory

%[DATA_D , INPUT_IM_D , DB_D , RES_D] = TP_GEN_directory_management( PROJ_D , kpack );

%% Program

% ------------------ LOG file
if flag_write_LOG_file
    kfile = 3; % Log_files
    [filename_LOG] = TP_GEN_filenames( PROJ_D , kpack, kfile);
    ajout_dossier(filename_LOG);
    
    LogId = fopen(filename_LOG,'w');
else
    LogId = 0; %#ok<UNRCH> % Error display
end


%%         Generate the structure with the image filenames            


flag_generate_list_filenames = true; % flag to re-generate the lists "l_filename_im"
[l_filename_im] = TP_DB_get_image_filename_list( PROJ_D, kpack , flag_generate_list_filenames );

% Number of images
[nim] = length(l_filename_im);



%%        Vessel detection    

if flag(1) > 0
    kim_ini = 1;
    for kim = kim_ini:nim
        fprintf('Image %d / %d \t %.01f %%\n',kim,nim,kim/nim*100);
        filename = fullfile( l_filename_im(kim).folder , l_filename_im(kim).name );
        EvenementLOG(LogId, 3, GestionMsgErreur(sprintf('Image %d / %d \t %.01f pct \n%s\n',kim,nim,kim/nim*100,filename)), 1);
        TP_vessel_detection( PROJ_D , kpack , filename , LogId );
    end
 end

%%    Vessel comparison with the reference     
% listFileName = {}; 
if flag(2) > 0
    kim_ini = 1;
    for kim = kim_ini:nim
        fprintf('Image %d / %d \t %.01f %%\n',kim,nim,kim/nim*100);
        filename = fullfile( l_filename_im(kim).folder , l_filename_im(kim).name );
        EvenementLOG(LogId, 3, GestionMsgErreur(sprintf('Image %d / %d \t %.01f \n%s\n',kim,nim,kim/nim*100,filename)), 1);
        TP_vessel_comparison( PROJ_D , kpack , filename , LogId );
%         listFileName=  append( listFileName, filename);
    end
end


%% étude quantitative
  [sensitivity_m,specificity_m,accuracy_m,dice_m ]= TP_vessel_comparison_moyenne( PROJ_D , kpack ,l_filename_im,LogId);


%% Close log file
if LogId > 2
    fclose(LogId);
end


