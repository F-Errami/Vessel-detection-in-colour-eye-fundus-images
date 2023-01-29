%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mise en forme des messages d'erreur de MAtlab pour le LOG
%Str = GestionMsgErreur(Str)
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%ENTREES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%Str                       #Message d'erreur intial
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%SORTIES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%Str                       #Message d'erreur mis en forme
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Str = GestionMsgErreur(Str)
 
%% Paramètres
%Caractères à supprimer de la chaine
Params.CharASupprimer = 1:31;
%Caractère de Remplacement
Params.Remplace = '.';

%% Recherche dans la chaine et Remplacement
%Recherche
Pos = find(ismember(Str, Params.CharASupprimer));
%Remplacement
if ~isempty(Pos),
    Str(Pos) = Params.Remplace;
end

%% Gestion Particulière des '\'
%Recherche
Pos = strfind(Str, '\');
%Remplacement
for i = 1:size(Pos, 2),
    Str = [Str(1:(Pos(i) + i - 1) - 1) '\\' Str((Pos(i) + i - 1) + 1:end)];
end


