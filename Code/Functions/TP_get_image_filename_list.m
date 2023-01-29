%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Get the image table and the image filename list from the database
%
%   [l_filename_im , l_relPath] = TP_get_image_filename_list( PROJ_D, kpack , flag_rw_tmp , LogId )
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-% INPUTS %-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%   kprob  : problem number data web
%            1  diaretDB database : Finland
%            2  David Owens database
%
%   kpack  : number of acquisition package
%            1  first package of images
%            1  second package of images
%            i  i-th package of images
%
%   flag_rw_tmp     # flag to delete the temporary mat file with the
%   database tree
%
%   LogId           # (Optional) ID of the LOG file (> 2) /Display (1) / Nothing (0)
%                   # Default : 0
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-% OUTPUTS %-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%   l_filename_im   : list of the image filenames
%   l_relPath       : list of relatives paths from DATA_path
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP_get_image_filename_list.m
% Guillaume NOYEL 30-11-2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [l_filename_im , l_relPath] = TP_get_image_filename_list( PROJ_D, kpack , flag_rw_tmp , LogId )


%% Inputs management
nb_arg_fixed = 2;
if nargin == nb_arg_fixed
    LogId = 0;
end

%% Default outputs

l_filename_im = {};


%% Programme

try


kfile = 4; % list filenames
[filename] = TP_GEN_files_name(PROJ_D,kpack, kfile);
if flag_rw_tmp
   Effacer_fichiers(filename);
end

if exist(filename,'file') == 2
    load(filename,'l_filename_im','l_relPath');
else
    [~ , l_filename_im , l_relPath ] = %DR_DB_get_image_table( kprob , kpack , LogId );
    ajout_dossier(filename);
    save(filename,'l_filename_im','l_relPath');
end


%% Error management
catch ME
    EvenementLOG(LogId, 1, ME.message, 1);
end

end

