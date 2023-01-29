%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sensitivity, specificity, accuracy and contingency table (TP : True  Positives,
%   FP : False Positives, FN : False Negatives and TN : True  Negatives)
%
% [ TPR , TNR , Acc , Ntab , msk_TP , msk_FP , msk_FN , msk_TN ] = ...
%   SensibilitySpecificity2imseg( msk_ref , msk_seg , im_msk )
%
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%INPUTS%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
% msk_ref           : binary image of the reference segmentation
% msk_seg           : binary image of the segmentation to be compared
% im_msk            : (option) binary mask to select a ZOI in the images.
%                       Default: the whole image.
%
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%OUTPUTS%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
%
% TPR               : sensitivity, True Positive Rate (TPR), TPR = TP/(TP+FN);
% TNR               : specificity, True Negative Rate (TNR), TNR = TN/(TN+FP);
% Acc               : Accuracy : rate of pixels correctly classified Acc = (TP+TN)/(TP+TN+FP+FN);
% Ntab = [TP FP
%         FN TN];   : Contingency table
%
%                           Reference segmentation
%                            Positive | Negative
%--------------------------------------------------
% Estimated     : Positive      TP         FP
% Segmenttation : Negative      FN         TN
%
% TP : True  Positives
% FP : False Positives
% FN : False Negatives
% TN : True  Negatives
%
% TP = Ntab(1,1);
% FP = Ntab(1,2);
% FN = Ntab(2,1);
% TN = Ntab(2,2);
%
% Positive (P) and Negative (N) values of the refernce segmentation can be
% obtained by summing the column of Ntab:
% P = sum(Ntab(:,1)) = TP + FN
% N = sum(Ntab(:,2)) = FP + TN
%
% msk_TP            : binary image of the true negatives
% msk_FP            : binary image of the false positives
% msk_FN            : binary image of the false negatives
% msk_TN            : binary image of the true negatives
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SensibilitySpecificity2imseg.m
% Guillaume NOYEL 13-09-2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [ TPR , TNR , Acc ,dice, Ntab , msk_TP , msk_FP , msk_FN , msk_TN ] = ...
    SensibilitySpecificity2imseg( msk_ref , msk_seg , varargin )


%% Parameters

flag_disp = false;%true; % display flag


%% Input management

[ msk_ref , msk_seg , im_msk ] = parse_inputs( msk_ref , msk_seg , varargin{:} );

% Number of pixels to be classified
%Npix = sum(msk_ref(im_msk));

%% True positives
msk_TP = and( and(msk_ref , msk_seg ) , im_msk );
TP = sum(msk_TP(im_msk));

%% False negatives
msk_FN = and( and( msk_ref , ~msk_seg ) , im_msk );
FN = sum(msk_FN(im_msk));


%% False positives
msk_FP = and( and(~msk_ref , msk_seg) , im_msk );
%msk_FP2 = and( minus_binary_images( msk_seg , msk_ref ) , im_msk );
%isequal( msk_FP , msk_FP2 )
FP = sum(msk_FP(im_msk));

%% True negative
msk_TN = and( and( ~msk_ref , ~msk_seg ) , im_msk);
TN = sum(msk_TN(im_msk));

%% Contingency table
Ntab = [TP FP
        FN TN];

if flag_disp
    figure;
    subplot(2,2,1); imagesc(msk_TP); title('True positives'); axis equal
    subplot(2,2,2); imagesc(msk_FP); title('False positives'); axis equal
    subplot(2,2,3); imagesc(msk_FN); title('False negatives'); axis equal
    subplot(2,2,4); imagesc(msk_TN); title('True negatives'); axis equal
    
    fprintf('True positive  TP = %d\n',TP);
    fprintf('False positive FP = %d\n',FP);
    fprintf('False negative FN = %d\n',FN);
    fprintf('True negative  TN = %d\n',TN);
end

%% dice coefficient= (2 * TP) / (2 * TP + FP + FN)
dice = (2*TP)/(2*TP+FP+FN);

%% sensitivity (True Positive Rate) TPR = TP/P
TPR = TP/(TP+FN);

%% specificity (True Negative Rate) TNR = TN/N
TNR = TN/(TN+FP);

%% Accuracy
Acc = (TP+TN)/(TP+TN+FP+FN);



end

%% Parse inputs


function [ msk_ref , msk_seg , im_msk ] = parse_inputs( msk_ref , msk_seg , varargin )

p = inputParser;

SZ = size(msk_ref);
default_im_msk = true(SZ);

addRequired(p,'msk_ref',@islogical);
addRequired(p,'msk_seg',@(x) islogical(x) && isequal(SZ,size(x)) );
addOptional(p,'im_msk',default_im_msk,@(x) islogical(x) && isequal(SZ,size(x)));

parse( p , msk_ref , msk_seg , varargin{:} );
im_msk    = p.Results.im_msk;

end