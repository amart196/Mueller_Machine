function pHandles = plotMMData4x4(Lam,MMdata,varargin)
% inputs [Lam, MMdata, b_eV, pHandles, color]
numvarargs = length(varargin);
if numvarargs > 3
    error('plotMMData4x4:TooManyInputs', ...
        'requires at most 3 optional inputs');
end
optargs = {0 0 'r'}; % set defaults for optional inputs
optargs(1:numvarargs) = varargin;
[b_eV, pHandles, color] = optargs{:};

if b_eV == true
    Lam = 1239.8./Lam;
end

if isempty(color)
    color = 'blue';
end

if all(ishandle(pHandles)) == 0 || length(pHandles) ~= 16
    for hand=1:16
        pHandles(hand)=subplot(4,4,hand);
        hold on
    end
end

for j = 1:4
    for k = 1:4
        plot(pHandles(k+4*(j-1)),Lam,squeeze(MMdata(j,k,:)),...
            'Color',color)
    end
end
axis(pHandles,'tight')
end
% 
%             'o',...
%             'Markersize',3,...