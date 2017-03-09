function [traj, rate, methSiteCount, time] = analyzeKmRun(runs, run_name)

clusterCountFactor = 1;

clusterCount = [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 125 150 175 ];
clusterSize = 19;

receptorCount = clusterCount.*clusterSize*clusterCountFactor;
methSiteCount = receptorCount.*8;

%Note!!! Assumes dt = 1second
rateStartIndex = 3;5;  %start at 
rateEndIndex = 6;8;   % go to 




for c=1:length(clusterCount)
    
    for r=0:runs
    

    fprintf(['Reading file with cluster count: ', num2str(clusterCount(c)), ' on run ',num2str(r),'.\n']);
    
    [data,var] = tblread(['/home/msneddon/Desktop/NG_sim/stdOut/KmTest/',run_name,'/r',num2str(r),'/KmTest_NG_basicOutput.',num2str(clusterCount(c)),'.',num2str(r),'.txt'],'\t');

    dt = data(3,1)-data(2,1);
    fullMethSite = 0*data(:,2)+1*data(:,3)+2*data(:,4)+3*data(:,5)+4*data(:,6)+5*data(:,6)+6*data(:,7)+7*data(:,8)+8*data(:,9);
    openMethSite = methSiteCount(c)-fullMethSite;

    if r==-1
        figure; plot(data(:,1),[fullMethSite,openMethSite]);
        xlabel('Time (seconds)');
        ylabel('Methylation Level [Count]');
        title(['Trajectory for ',num2str(methSiteCount(c)),' possible methylation sites.']);
    end
    
    traj(:,c,r+1) = fullMethSite;
    rate(c,r+1) = (fullMethSite(rateEndIndex)-fullMethSite(rateStartIndex))/(dt*(rateEndIndex-rateStartIndex));
   %fprintf(['File with cluster count: ', num2str(clusterCount(c)), ' on run ',num2str(r),'  velocity:',num2str(rate(c,r+1)),' methylations / second.\n']);

    
    end
    
    fprintf('\n--------------\n');

end

time=data(:,1);
% 
% p=polyfit(1./num2conc(methSiteCount'),1./num2conc(mean(rate,2)),1);
% 
% figure;
% plot(data(:,1),mean(traj,3),'k'); hold on;
% plot([data(rateStartIndex,1),data(rateStartIndex,1)],[0,1500],'k--');
% plot([data(rateEndIndex,1),data(rateEndIndex,1)],[0,1500],'k--');
% ylabel('Methylation Level'); xlabel('Time(s)');
% 
% f1 = figure; plot(1./num2conc(methSiteCount'),1./num2conc(mean(rate,2)),'k.'); hold on;
% plot(-p(2)/p(1):0.01:(1/num2conc(methSiteCount(1))),polyval(p,-p(2)/p(1):0.01:(1/num2conc(methSiteCount(1)))),'b-');
% xlabel('1/[methylationSites] in 1/uM');
% ylabel('1/velocity in s/uM');
% 
% km = -1/(-p(2)/p(1));
% vmax = (1/p(2));
% fprintf(['First Guess (Linweaver-Burk Line Fit) \n\tEffective Km: ',num2str(km),'uM    Vmax:',num2str(vmax),'uM/second  \n']);
% 
% 
% 
% f2 = figure; plot(num2conc(methSiteCount'),num2conc(mean(rate,2)),'b.'); hold on;
% 
% s=num2conc(0:1:methSiteCount(end));
% plot(s,mmPlot(s,vmax,km),'k');
% %plot([0,s(end)],[vmax,vmax],'k--');
% %plot([km,km],[0,mmPlot(km,vmax,km)],'k--');
% %plot([0,km],[mmPlot(km,vmax,km),mmPlot(km,vmax,km)],'k--');
% 
% xlabel('[methylationSites] in uM');
% ylabel('velocity in uM/s');
% 
% 
% %[x,fval,exitflag,output] = fminunc(@mmError,[vmax;km]);  %min with optimization toolbox
% [x,fval,exitflag,output] = fminsearch(@mmError,[vmax;km]); %min with built in function
% 
% newvmax = x(1);
% newkm = x(2);
% 
% 
% 
% plot(s,mmPlot(s,newvmax,newkm),'r-');
% 
% plot([0,s(end)],[newvmax,newvmax],'r--');
% plot([newkm,newkm],[0,mmPlot(newkm,newvmax,newkm)],'r--');
% plot([0,newkm],[mmPlot(newkm,newvmax,newkm),mmPlot(newkm,newvmax,newkm)],'r--');
% 
% figure(f1);
% xEndPoints = [(-1/newkm),(1./num2conc(methSiteCount(1)'))];
% plot(xEndPoints,(newkm/newvmax).*(xEndPoints)+(1/newvmax),'r');
% 
% 
% fprintf(['Refined fit: \n\tEffective Km: ',num2str(newkm),'uM    Vmax:',num2str(newvmax),'uM/second  \n']);
% 





    function [v] = mmPlot(sub,vmax,km)
        v = vmax.*sub./(km+sub);
    end
    function [error] = mmError(x)
       v = x(1).*num2conc(methSiteCount')./(x(2)+num2conc(methSiteCount'));
       error = sum((v - num2conc(mean(rate,2))).^2);
    end
end





