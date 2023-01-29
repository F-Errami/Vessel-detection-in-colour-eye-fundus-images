function [fs,level]=tse_imthreshold(f,nt,criteria)
%TSE_IMTHRESHOLD Automatically threshold an image by maximizing the
%interclas variance or the entropy of its histogram.
%
%  FS=TSE_IMTHRESHOLD(F,NT,CRITERIA) returns the image FS obtained after
%  thresholding input image F using NT threshold levels and the
%  maximization method given by CRITERIA. If omitted NT=1 and
%  CRITERIA='variance'. Possible values for CRITERIA are:
%
%    'variance' to use the maximization of inter-class variance
%    'entropy' to use the maximization of entropy
%
%  [FS,LEVEL]=TSE_IMTHRESHOLD(...) returns the chosen threshold levels in
%  LEVEL array.

if nargin<2, nt=1;criteria='variance';end
if nargin<3,criteria='variance';end

if strcmp(criteria,'variance'),crit=1;
elseif strcmp(criteria,'entropy'),crit=2;
else error('incorrect criteria');end

[p,z]=imhist(f);
zmax=z(end);

first=find(p,1,'first');
last=find(p,1,'last');
p=p(first:last); % Removing beginning and ending 0 frequencies
z=z(first:last);

if  crit==2,p=p+1; end    % prevent log(0) problems

p=p/numel(f);
n=size(p,1);
vmax=0;
imax=1;

if nt==1
    % Two classes case, one threshold to find
    for i=1:n
        v1=fcriteria(z(1:i),p(1:i),crit);
        v2=fcriteria(z(i+1:n),p(i+1:n),crit);
        v=v1+v2;
        if v>vmax
            vmax=v;
            imax=i;
        end
    end
    level=z(imax);
    fs=im2bw(f,level/zmax);
    
elseif nt==2
    % Three classes case, two levels to find
    jmax=2;
    for i=1:n-1
        for j=i+1:n
            v1=fcriteria(z(1:i),p(1:i),crit);
            v2=fcriteria(z(i+1:j),p(i+1:j),crit);
            v3=fcriteria(z(j+1:n),p(j+1:n),crit);
            v=v1+v2+v3;
            if v>vmax
                vmax=v;
                imax=i;
                jmax=j;
            end
        end
    end
    level=[z(imax);z(jmax)];
    fs=thresh(f,level);
    
else
    error('number of classes greater than 3 are not supported');
end
end

function v=fcriteria(z,p,crit)
if crit==1, v=varinter(z,p);
elseif crit==2, v=entropy(p);
end
end


function v=varinter(z,p)
    m=dot(z,p);
    pc=sum(p);
    if  pc>0
        v=m^2/pc;
    else
        v=0;
    end
end

function e=entropy(p)
    pc=sum(p);
    if  pc>0
    pzc=p/pc;
        e=-dot(pzc,log2(pzc));
    else
        e=0;
    end
end

function fs=thresh(f,level)
fs=zeros(size(f),'int8');
for i=1:size(level)-1
    m= f>level(i) & f<=level(i+1);
    fs(m)=i;
end
m=f>level(end);
fs(m)=i+1;
end