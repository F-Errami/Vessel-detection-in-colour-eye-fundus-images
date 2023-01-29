

function [name_path_new] = manage_path_str(name_path)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the symbols of relative paths '..' or '.' from a string of  path
% Replace the symbol '\' or '/' by '\\'
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%INPUTS%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
% name_path      # input path
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%OUTPUTS%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
% name_path_new  # output path
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% manage_path_str.m
% Guillaume Noyel 05/02/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Removing '..'
tab_n = strfind(name_path,'..');
N = length(tab_n);
name_path_new = name_path;
for n=1:N
    name_path_new = [ fileparts(name_path_new(1:tab_n(n)-2)) , name_path_new(tab_n(n)+2:end) ];
    tab_n(n+1:N) = strfind(name_path_new,'..');
end

%% Removing '.'
tab_n = strfind(name_path_new,'.');
N = length(tab_n);
for n=1:N
    name_path_new = [ name_path_new(1:tab_n(n)-2) , name_path_new(tab_n(n)+1:end) ];
    tab_n(n+1:N) = strfind(name_path_new,'.');
end

%name_path_new = strrep(strrep(name_path_new,'\','\\'),'/','\\');