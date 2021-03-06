%     MultiDOE - Toolbox for sampling a bounded space
%     Copyright (C) 2016  Luc LAURENT <luc.laurent@lecnam.net>
%
% sources available here:
% https://bitbucket.org/luclaurent/multidoe/
% https://github.com/luclaurent/multidoe/
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

%% Function for displaying sampling with nD variables
%% L. LUARENT -- 10/02/2012 -- luc.laurent@lecnam.net


function displayDOE(sampling,doe,missData)

%show order of the sampling
dispTXT=true;

%load bounds of the design space
if isfield(doe,'Xmin')&&isfield(doe,'Xmax')
    Xmin=doe.Xmin;
    Xmax=doe.Xmax;
elseif isfield(doe,'bounds')
    Xmin=doe.bounds(:,1);
    Xmax=doe.bounds(:,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%seek and reordering data in the case of missing data
listSampleOK=1:size(sampling,1);
listRespMiss=[];
listGradMiss=[];
listBothMiss=[];
if nargin==3
    if missData.resp.on
        listRespMiss=unique(missData.resp.ixMiss(:));
        for ii=1:numel(listRespMiss)
            ix=find(listSampleOK==listRespMiss(ii));
            listSampleOK(ix)=[];
        end
    end
    if missData.grad.on
        listGradMiss=unique(missData.grad.ixMiss(:,1));
        for ii=1:numel(listGradMiss)
            ix=find(listSampleOK==listGradMiss(ii));
            listSampleOK(ix)=[];
            
        end
    end
    if missData.resp.on|| missData.grad.on
        listBothMiss=intersect(listRespMiss,listGradMiss);
        for ii=1:numel(listBothMiss)
            ix=find(listRespMiss==listBothMiss(ii));
            listRespMiss(ix)=[];
            ix=find(listGradMiss==listBothMiss(ii));
            listGradMiss(ix)=[];
        end
    end
end
%text to display or not
f1 = @(x) sprintf('%i',x);
f2 = @(x) cellfun(f1, num2cell(x), 'UniformOutput', false);
listSampleOKtxt=f2(listSampleOK);
listRespMissTxt=f2(listRespMiss);
listGradMissTxt=f2(listGradMiss);
listBothMissTxt=f2(listBothMiss);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%number of variables
np=numel(Xmin);


para=0.1;
if np==1
    figure
    hold on
    yy=0.*sampling;
    %show sample points on which all data are available
    plottext(sampling(listSampleOK),yy(listSampleOK),...
        listSampleOKtxt,'o','k',7,dispTXT);
    %show sample point(s) on which response(s) is(are) missing
    plottext(sampling(listRespMiss),yy(listRespMiss),...
        listRespMissTxt,'rs','r',7,dispTXT);
    %show sample point(s) on which gradients(s) is(are) missing
    plottext(sampling(listGradMiss),yy(listGradMiss),...
        listGradMissTxt,'v','g',7,dispTXT);
    %show sample point(s) on which response(s) and gradient(s) are missing
    plottext(sampling(listBothMiss),yy(listBothMiss),...
        listBothMissTxt,'d','d',7,dispTXT);
    hold off
    xMin=Xmin(:)';
    xMax=Xmax(:)';
    depXX=xMax-xMin;
    axis([(xMin-para*depXX) (xMax+para*depXX) -1 1])
    %
    xlabel('$x$')
    %
elseif np==2
    %
    xMin=Xmin(1);
    xMax=Xmax(1);
    yMin=Xmin(2);
    yMax=Xmax(2);
    depXX=xMax-xMin;
    depYY=yMax-yMin;
    figure
    hold on
    %show sample points on which all data are available
    plottext(sampling(listSampleOK,1),sampling(listSampleOK,2),...
        listSampleOKtxt,'o','k',7,dispTXT);
    %show sample point(s) on which response(s) is(are) missing
    plottext(sampling(listRespMiss,1),sampling(listRespMiss,2),...
        listRespMissTxt,'rs','r',7,dispTXT);
    %show sample point(s) on which gradients(s) is(are) missing
    plottext(sampling(listGradMiss,1),sampling(listGradMiss,2),...
        listGradMissTxt,'v','g',7,dispTXT);
    %show sample point(s) on which response(s) and gradient(s) are missing
    plottext(sampling(listBothMiss,1),sampling(listBothMiss,2),...
        listBothMissTxt,'d','r',7,dispTXT);
    hold off
    axis([(xMin-para*depXX) (xMax+para*depXX) (yMin-para*depYY) (yMax+para*depYY)])
    line([xMin;xMin;xMax;xMax;xMax;xMax;xMax;xMin],[yMin;yMax;yMax;yMax;yMax;yMin;yMin;yMin])
    %
    xlabel('$x$','Interpreter','latex');
    ylabel('$y$','Interpreter','latex');
else
    figure
    it=0;
    depX=Xmax(:)'-Xmin(:)';
    for ii=1:np
        for jj=1:np
            it=it+1;
            if ii~=jj
                subplot(np,np,it)
                hold on
                %show sample points on which all data are available
                plottext(sampling(listSampleOK,ii),sampling(listSampleOK,jj),...
                    listSampleOKtxt,'o','k',7,dispTXT);
                %show sample point(s) on which response(s) is(are) missing
                plottext(sampling(listRespMiss,ii),sampling(listRespMiss,jj),...
                    listRespMissTxt,'rs','r',7,dispTXT);
                %show sample point(s) on which gradients(s) is(are) missing
                plottext(sampling(listGradMiss,ii),sampling(listGradMiss,jj),...
                    listGradMissTxt,'v','g',7,dispTXT);
                %show sample point(s) on which response(s) and gradient(s) are missing
                plottext(sampling(listBothMiss,ii),sampling(listBothMiss,jj),...
                    listBothMissTxt,'d','r',7,dispTXT);
                hold off
                xMin=Xmin(ii);xMax=Xmax(ii);yMin=Xmin(jj);yMax=Xmax(jj);depXX=depX(ii);depYY=depX(jj);
                axis([(xMin-para*depXX) (xMax+para*depXX) (yMin-para*depYY) (yMax+para*depYY)])
                line([xMin;xMin;xMax;xMax;xMax;xMax;xMax;xMin],[yMin;yMax;yMax;yMax;yMax;yMin;yMin;yMin])
                %
                stringLabel=@(iv)sprintf('$x_{%i}$',iv);
                xlabel(stringLabel(ii),'Interpreter','latex');
                ylabel(stringLabel(jj),'Interpreter','latex');
            else
                subplot(np,np,it)
                hist(sampling(:,ii))
                xMin=Xmin(ii);xMax=Xmax(ii);depXX=depX(ii);depYY=depX(jj);
                xlim([(xMin-para*depXX) (xMax+para*depYY)]);
                %
                stringLabel=@(iv)sprintf('$x_{%i}$',iv);
                xlabel(stringLabel(ii),'Interpreter','latex');
            end
        end
    end
end
end


%%fonction for showing points and text above it
function plottext(X,Y,TXT,markM,colorM,sizeM,txtOn)
plot(X,Y,...
    markM,'MarkerEdgeColor',colorM,...
    'MarkerFaceColor',colorM,...
    'MarkerSize',sizeM);
if txtOn
    text(X,Y,...
        TXT,'VerticalAlignment','bottom');
end
end
