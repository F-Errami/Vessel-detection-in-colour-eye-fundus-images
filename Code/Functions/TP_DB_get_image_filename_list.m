%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Get the image image filename list and save it in a .mat file
%
%   [l_filename_im] = TP_DB_get_image_filename_list( PROJ_D, kpack , flag_generate_list_filenames )
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-% INPUTS %-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%   PROJ_D  % Root directory of the project
%
%   kpack  : identyfying number of the package
%            1  Database Drive (train set)
%
%
%   flag_rw_tmp     # flag to delete the temporary mat file with the
%   database tree
%
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-% OUTPUTS %-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%   l_filename_im   : list of the image filenames
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP_DB_get_image_filename_list.m
% Guillaume NOYEL 01-12-2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [l_filename_im] = TP_DB_get_image_filename_list( PROJ_D, kpack , flag_generate_list_filenames )

%% Program


kfile = 4; % list filenames
[filename] = TP_GEN_filenames(PROJ_D,kpack, kfile);
if flag_generate_list_filenames
    if(exist(filename,'file')==2)
        delete(filename);
    end
end

if exist(filename,'file') == 2
    load(filename,'l_filename_im');
else
    [DATA_D , INPUT_IM_D , DB_D , RES_D, ext_F] = TP_GEN_directory_management( PROJ_D , kpack );
    
    l_filename_im = dir(fullfile(INPUT_IM_D,['*',ext_F]));
    
    ajout_dossier(filename);
    save(filename,'l_filename_im');
end




end

