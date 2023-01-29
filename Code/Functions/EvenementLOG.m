%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fonction de Génération d'un évènement LOG (Affiché ou Sauvegardé)
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
    
%% Paramètres
Params.IdentMsg = '##';
    
%% Arguments
%Arguments
if nargin ~= 4,
    fprintf('%s : Pbm Nombre d''Arguments (%d/4)\n', mfilename, nargin);   
end
    
%% Récupération Date / Heure
TxtD = fix(clock);
TxtD = sprintf('%02d/%02d/%04d\t%02d:%02d:%02d', TxtD(3), TxtD(2), TxtD(1), TxtD(4), TxtD(5), TxtD(6));

%% Différenciation des Erreurs / Messages autres
%en Fonction du Type
switch TypeMsg
    %Erreurs
    case 1
        %Suppresion des Caractères Spéciaux
        TxtErr = GestionMsgErreur(Err.message);
        %Si Présence de l'identifiant des Fonctions
        Pos = strfind(TxtErr, Params.IdentMsg);
        if ~isempty(Pos)
            TxtErr = TxtErr(Pos(1) + size(Params.IdentMsg, 2):end);
        end
        %Avec information de Stack
        if ~isempty(Err.stack)
            %Texte pour l'affichage
            TxtAff = ['ERREUR: <a href="error:' Err.stack(1).file ',' num2str(Err.stack(1).line) ',0">' Err.stack(1).name ' (Ligne n°' num2str(Err.stack(1).line) ')</a>'];
            %En-Tête
            TxtSauv = [TxtD '\t*' Err.stack(1).name '*\t' num2str(Err.stack(1).line) '\n'];
        %Sans information de Stack
        else
            %Texte pour l'affichage
            TxtAff = 'ERREUR: ';
            %En-Tête
            TxtSauv = [TxtD '\t*' Err.identifier '*\t-\n'];
        end
        
    %Message / Warning / Enregistrement au LOG /...
    otherwise
        %En-Tête
        TxtSauv = [TxtD '\t' Err '\t-\n'];
        %Texte du LOG
        TxtErr = Err;
end

%% Sauvegarde de l'évènement LOG
%Sauvegarde
if LogId > 2,
    fprintf(LogId, TxtSauv);
    fprintf(LogId, '\n%s\n\n', TxtErr);
end

%% Affichage de l'évènement LOG
%Si Affichage ou Erreur
if (TypeMsg == 1 || Affichage)
    if TypeMsg == 1,
        disp([sprintf('\n') TxtD sprintf('\t') TxtAff sprintf('\t%s\n', TxtErr)]);   
    else
        fprintf(TxtSauv);
        fprintf('%s\n\n', TxtErr);
    end
end

%% Récupération des Erreurs Autres
catch ME
    fprintf('EvenementLOG : %s\n', GestionMsgErreur(ME.message));    
end