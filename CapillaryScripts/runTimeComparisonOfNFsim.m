% Runtime comparison plot

bar([1,5.4]); hold on;
axis([0,3,0,6]);


formatFigure();
set(gca,'YTick',[1 2 3 4 5 6]);
set(gca,'YTickLabel','1|2|3|4|5|6');

set(gca,'XTick',[1 2]);
set(gca,'XTickLabel','|');

set(gca,'LineWidth',3);
set(gca, 'TickDir', 'out');
set(gca,'FontSize',30);












%%
%  Vary beta

BNG = [
0.01   2.01/10782  
0.02   3.9/10697 ;
0.03   12.8/11024  ;
0.05   30.1/11256 ;
0.1    0.015 ;];
loglog(BNG(:,1),BNG(:,2),'r','LineWidth',4); hold on;


runWithChecks = [  0.01   7.063810e-06;
  0.02   7.130506e-06;
  0.05   7.259779e-06;
  0.10   6.919959e-06;
  0.20   7.251072e-06;
  0.50   7.078008e-06;
  1.00   7.168285e-06;
  2.00   7.542467e-06;
  5.00   9.925263e-06;
 10.00   1.725266e-05;
 20.00   2.593202e-05;
 50.00   3.733299e-05;
100.00   5.056088e-05; 
200.00   7.393966e-05;
500.00   1.396782e-04;
1000     2.535895e-04;];
%loglog(runWithChecks(:,1),runWithChecks(:,2),'r','LineWidth',4); hold on;


runWithOutChecks = [  0.01    6.622517e-06;
  0.02   7.149666e-06;
  0.05   6.306978e-06;
  0.10   6.566347e-06;
  0.20   6.630623e-06;
  0.50   6.760106e-06;
  1.00   6.468305e-06;
  2.00   6.569343e-06;
  5.00   6.566635e-06;
 10.00   6.873711e-06;
 20.00   6.652756e-06;
 50.00   6.981412e-06;
100.00   6.589125e-06; 
200.00   6.756567e-06;
500.00   6.667778e-06;
1000     6.992420e-06;
10000    6.724573e-06;];
loglog(runWithOutChecks(:,1),runWithOutChecks(:,2),'b','LineWidth',4); hold on;
axis([10^-2,200,10^-6, 10^-2]);


formatFigure();
legend('"On the fly" Gillespie','NFsim');
set(gca,'LineWidth',2);
set(gca, 'fontSize', 30);

set(gca,'YTick',[10^-6 10^-5 10^-4 10^-3 10^-2]);
set(gca,'XTick',[10^-1,1,10,10^2]);





%%
% Vary Nr...
% 
% lowBetaWithChecks = [
% 5          4.171011e-06;    
% 100        5.100479e-06;
% 200        5.625447e-06;
% 500        6.971570e-06;
% 1000       8.265990e-06;
% 2000       9.519020e-06;
% 5000       1.089844e-05;
% 10000      1.176251e-05;
% 20000      1.235091e-05;
% 50000      1.304319e-05;
% 100000     1.373039e-05;];
% 
% total = lowBetaWithChecks(:,1)+14.*lowBetaWithChecks(:,1)
% loglog(total,lowBetaWithChecks(:,2),'b'); hold on;





highBetaWithChecks = [5          4.061738e-06;
100        2.144122e-05;
200        2.738582e-05;
500        4.459534e-05;
1000       7.688356e-05;
2000       1.503375e-04;
5000      8.395844e-04;
10000      2.904189e-03;];
total = highBetaWithChecks(:,1)+14.*highBetaWithChecks(:,1)
loglog(total,highBetaWithChecks(:,2),'r','LineWidth',4); hold on;

highBetaWithOutChecks = [5  5.347594e-06;
    100        6.177742e-06;
200        7.002801e-06;
500        6.860762e-06;
1000       6.925815e-06;
2000       7.437014e-06;
5000       8.856562e-06;
10000      1.032935e-05;
20000      1.103375e-05;
50000      1.207763e-05;
100000     1.264881e-05;];
total3 = highBetaWithOutChecks(:,1)+14.*highBetaWithOutChecks(:,1)
loglog(total3(:,1),highBetaWithOutChecks(:,2),'b','LineWidth',4); hold on;
axis([200,10^6.2,10^-6, 10^-2]);
formatFigure();

legend('Prohibiting Cycles','Allowing Cycles');
set(gca,'LineWidth',2);
set(gca, 'fontSize', 30);

set(gca,'YTick',[10^-6 10^-5 10^-4 10^-3 10^-2]);
set(gca,'XTick',[10^3,10^4,10^5,10^6]);


