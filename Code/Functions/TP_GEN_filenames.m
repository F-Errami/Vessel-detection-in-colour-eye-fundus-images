
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   The file_generates the filenames with respect to the kfile number
%
%   [file_out] = TP_GEN_filenames( PROJ_D, kpack, kfile , filename_im )
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-% INPUTS %-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%   PROJ_D  % Root directory of the project
%
%   kpack  : identyfying number of the package
%            1  Database Drive (train set)
%
%   kfile  : identyfying number of the filenames to generate
%
%   filename_im : image filename
%
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-% OUTPUTS %-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
%   file_out : name of the chosen file
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Guillaume NOYEL
% DR_GEN_files_name.m
% 30-11-2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [file_out] = TP_GEN_filenames( PROJ_D, kpack, kfile , filename_im )

[DATA_D , INPUT_IM_D , DB_D , RES_D] = TP_GEN_directory_management( PROJ_D , kpack );

if kfile == 3 % LOG file
    file_out = fullfile(RES_D,'LOG_files',[datestr(now,'yyyy_mm_dd-HH_MM_ss'),'_Log_file.txt']);
elseif kfile == 4 % list filenames
    file_out = fullfile(RES_D,'list_filenames.mat');
else
    [~,r_f] = fileparts(filename_im); %root of filemane_in
    if kpack == 1
        
        if kfile < 10
        elseif kfile==11
            file_out=sprintf('%s/mask/mask_%s.png',RES_D,r_f);% Mask of the image Zone of Interest       
        elseif kfile==21
            file_out=sprintf('%s/mask_vessels/mask_vessels_%s.png',RES_D,r_f);% Mask of the extracted vessels
        elseif kfile==22
            file_out=sprintf('%s/mask_vessels/im_vessels_%s.png',RES_D,r_f);% Image with the border of the vessels
        elseif kfile==31
            file_out=sprintf('%s/../1st_manual/%s_manual1.gif',INPUT_IM_D,r_f(1:end-9));% Reference segmentation (ground-truth)
        else
            error('Error kfile %d not (yet) existing',kpack);            
        end
    else
        error('Error kpack %d not existing',kpack);
    end
end

