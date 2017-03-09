function [] = reanalyzeKmRun(traj, methSiteCount, time, startTime, endTime,color)




dt = time(2)-time(1);
rateStartIndex = max(find(time<=startTime));
rateEndIndex = min(find(time>=endTime));



for c=1:length(methSiteCount)
    
    for r=1:size(traj,3);
    rate(c,r+1) = (traj(rateEndIndex,c,r)-traj(rateStartIndex,c,r))/(dt*(rateEndIndex-rateStartIndex));

    end
    

end


substrateLevel = methSiteCount-mean(traj(rateStartIndex,:,:),3);

p=polyfit(1./num2conc(substrateLevel'),1./num2conc(mean(rate,2)),1);

figure(1);
plot(time,mean(traj,3),'k','Color',color); hold on;
plot([time(rateStartIndex),time(rateStartIndex)],[0,1500],'k--');
plot([time(rateEndIndex),time(rateEndIndex)],[0,1500],'k--');
ylabel('Methylation Level'); xlabel('Time(s)');
axis([0,10,0,400]);



figure(2); plot(1./num2conc(substrateLevel'),1./num2conc(mean(rate,2)),'k.','Color',color,'MarkerSize',20); hold on;
%plot(-p(2)/p(1):0.01:(1/num2conc(substrateLevel(1))),polyval(p,-p(2)/p(1):0.01:(1/num2conc(substrateLevel(1)))),'b-');
plot([0,0],[-5,100],'k-');
plot([-10,10],[0,0], 'k-');
xlabel('1/[methylationSites] in 1/uM');
ylabel('1/velocity in s/uM');



km = -1/(-p(2)/p(1));
vmax = (1/p(2));
fprintf(['First Guess (Linweaver-Burk Line Fit) \n\tEffective Km: ',num2str(km),'uM    Vmax:',num2str(vmax),'uM/second  \n']);



figure(3); plot(num2conc(substrateLevel'),num2conc(mean(rate,2)),'b.','Color',color,'MarkerSize',20); hold on;
plot(num2conc(substrateLevel'),num2conc(mean(rate,2)),'b-','Color',color);

s=num2conc(0:1:substrateLevel(end));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(s,mmPlot(s,vmax,km),'k');
%plot([0,s(end)],[vmax,vmax],'k--');
%plot([km,km],[0,mmPlot(km,vmax,km)],'k--');
%plot([0,km],[mmPlot(km,vmax,km),mmPlot(km,vmax,km)],'k--');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlabel('[methylationSites] in uM');
ylabel('velocity in uM/s');


%[x,fval,exitflag,output] = fminunc(@mmError,[vmax;km]);  %min with optimization toolbox
[x,fval,exitflag,output] = fminsearch(@mmError,[vmax;km]); %min with built in function

newvmax = x(1);
newkm = x(2);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(s,mmPlot(s,newvmax,newkm),'r-');
%plot([0,s(end)],[newvmax,newvmax],'r--');
%plot([newkm,newkm],[0,mmPlot(newkm,newvmax,newkm)],'r--');
%plot([0,newkm],[mmPlot(newkm,newvmax,newkm),mmPlot(newkm,newvmax,newkm)],'r--');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2);
xEndPoints = [(-1/newkm),(1./num2conc(substrateLevel(1)'))];
plot(xEndPoints,(newkm/newvmax).*(xEndPoints)+(1/newvmax),'r');

axis([xEndPoints(1)-0.1,xEndPoints(2)+0.1,-2,max((newkm/newvmax).*(xEndPoints)+(1/newvmax))+1]);


fprintf(['Refined fit: \n\tEffective Km: ',num2str(newkm),'uM    Vmax:',num2str(newvmax),'uM/second  \n']);









    function [v] = mmPlot(sub,vmax,km)
        v = vmax.*sub./(km+sub);
    end
    function [error] = mmError(x)
       v = x(1).*num2conc(substrateLevel')./(x(2)+num2conc(substrateLevel'));
       error = sum((v - num2conc(mean(rate,2))).^2);
    end
end