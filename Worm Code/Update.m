function []=Update(Ns,Nr,Node,hNode,hCable,hTube)
% Update nodes, tubes and cables after each frame.
for iN=1:Ns       % Node update.
    for jN=1:3
        for kN=1:Nr
            set(hNode{iN,jN,kN},...
                'XData',Node(iN,jN,kN,1),...
                'YData',Node(iN,jN,kN,2),...
                'ZData',Node(iN,jN,kN,3));
        end
    end
end
for iT=1:Ns      % Tube&Cable update.
    for jT=1:3
        if iT==Ns&&jT==3; break; end
        for kT=1:Nr
            if jT==2
                set(hCable{iT,kT},...
                    'XData',[Node(iT,jT,kT,1),Node(iT,jT,mod(kT,Nr)+1,1)],...
                    'YData',[Node(iT,jT,kT,2),Node(iT,jT,mod(kT,Nr)+1,2)],...
                    'ZData',[Node(iT,jT,kT,3),Node(iT,jT,mod(kT,Nr)+1,3)]);
            end
            iT1=iT+floor(jT/3);
            jT1=mod(jT,3)+1;
            kT1=kT+(-1)^(iT+jT);
            kT2=kT1+Nr*(fix((Nr-kT1)/Nr)-fix(kT1/(Nr+1)));
            set(hTube{iT,jT,kT,1},...
                'XData',[Node(iT,jT,kT,1),Node(iT1,jT1,kT,1)],...
                'YData',[Node(iT,jT,kT,2),Node(iT1,jT1,kT,2)],...
                'ZData',[Node(iT,jT,kT,3),Node(iT1,jT1,kT,3)]);
            set(hTube{iT,jT,kT,2},...
                'XData',[Node(iT,jT,kT,1),Node(iT1,jT1,kT2,1)],...
                'YData',[Node(iT,jT,kT,2),Node(iT1,jT1,kT2,2)],...
                'ZData',[Node(iT,jT,kT,3),Node(iT1,jT1,kT2,3)]);
        end
    end
end