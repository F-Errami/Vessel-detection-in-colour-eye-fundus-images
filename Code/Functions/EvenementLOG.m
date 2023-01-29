%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fonction de G�n�ration d'un �v�nement LOG (Affich� ou Sauvegard�)
%EvenementLOG(LogId, TypeMsg, Err, Affichage);
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%ENTREES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%LogId                              #ID du fichier LOG (> 2) / Affichage (1) / Rien (0)
%TypeMsg                            #Type de Message : 1 => Erreur / N => Autre
%Err                                #Structure de l'erreur OU Texte d'un Message / Warning
%Affichage                          #Affichage du Message
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%SORTIES%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EvenementLOG(LogId, TypeMsg, Err, Affichage)

try
    
%% Param�tres
Params.IdentMsg = '##';
    
%% Arguments
%Arguments
if nargin ~= 4,
    fprintf('%s : Pbm Nombre d''Arguments (%d/4)\n', mfilename, nargin);   
end
    
%% R�cup�ration Date / Heure
TxtD = fix(clock);
TxtD = sprintf('%02d/%02d/%04d\t%02d:%02d:%02d', TxtD(3), TxtD(2), TxtD(1), TxtD(4), TxtD(5), TxtD(6));

%% Diff�renciation des Erreurs / Messages autres
%en Fonction du Type
switch TypeMsg
    %Erreurs
    case 1
        %Suppresion des Caract�res Sp�ciaux
        TxtErr = GestionMsgErreur(Err.message);
        %Si Pr�sence de l'identifiant des Fonctions
        Pos = strfind(TxtErr, Params.IdentMsg);
        if ~isempty(Pos)
            TxtErr = TxtErr(Pos(1) + size(Params.IdentMsg, 2):end);
        end
        %Avec information de Stack
        if ~isempty(Err.stack)
            %Texte pour l'affichage
            TxtAff = ['ERREUR: <a href="error:' Err.stack(1).file ',' num2str(Err.stack(1).line) ',0">' Err.stack(1).name ' (Ligne n�' num2str(Err.stack(1).line) ')</a>'];
            %En-T�te
            TxtSauv = [TxtD '\t*' Err.stack(1).name '*\t' num2str(Err.stack(1).line) '\n'];
        %Sans information de Stack
        else
            %Texte pour l'affichage
            TxtAff = 'ERREUR: ';
            %En-T�te
            TxtSauv = [TxtD '\t*' Err.identifier '*\t-\n'];
        end
        
    %Message / Warning / Enregistrement au LOG /...
    otherwise
        %En-T�te
        TxtSauv = [TxtD '\t' Err '\t-\n'];
        %Texte du LOG
        TxtErr = Err;
end

%% Sauvegarde de l'�v�nement LOG
%Sauvegarde
if LogId > 2,
    fprintf(LogId, TxtSauv);
    fprintf(LogId, '\n%s\n\n', TxtErr);
end

%% Affichage de l'�v�nement LOG
%Si Affichage ou Erreur
if (TypeMsg == 1 || Affichage)
    if TypeMsg == 1,
        disp([sprintf('\n') TxtD sprintf('\t') TxtAff sprintf('\t%s\n', TxtErr)]);   
    else
        fprintf(TxtSauv);
        fprintf('%s\n\n', TxtErr);
    end
end

%% R�cup�ration des Erreurs Autres
catch ME
    fprintf('EvenementLOG : %s\n', GestionMsgErreur(ME.message));    
end