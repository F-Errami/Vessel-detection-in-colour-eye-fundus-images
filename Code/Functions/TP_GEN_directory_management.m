
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Directory mangement
%
%    [DATA_D , INPUT_IM_D , DB_D , RES_D, ext_F] = TP_GEN_directory_management( PROJ_D , kpack )
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-% INPUTS %-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%
%   PROJ_D  % Root directory of the project
%
%   kpack  : identyfying number of the package
%            1  Database Drive (train set)
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-% OUTPUTS %-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%   DATA_D       : DATA directory
%   INPUT_IM_D   : input image directory
%   DB_D         : Database directory
%   RES_D        : Results directory
%   ext_F        : extension of the files, e.g. '.png'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Guillaume NOYEL
% DR_GEN_directory_management.m
% 30-11-2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [DATA_D , INPUT_IM_D , DB_D , RES_D, ext_F] = TP_GEN_directory_management( PROJ_D , kpack )


%% Database Drive (train set)
if kpack == 1
    
    DATA_D  = fullfile(PROJ_D,'Data'); % data directory
    INPUT_IM_D  = fullfile(DATA_D,'InputData','training','images'); % input image directory
    DB_D    = fullfile(DATA_D,'DB'); % database directory
    RES_D   = fullfile(DATA_D,'Res'); % results directory
    ext_F = '.tif';
else
    error('kpack number %d not (yet) existing',kpack);
end



end

