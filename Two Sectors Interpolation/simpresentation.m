clear all

cd "C:\Users\vkrrikya\Desktop\SecondProject\A simple model\LMclearing\New Model Two Sectors"

load('0210etta85b001')

OCC01 = OCC;

shareunemp = sum(OCC==1)/NN;
shareemp  = sum(OCC==2)/NN;
sharesemp = sum(OCC==3)/NN;
sharebus = sum(OCC==4)/NN;

occdist01 = [shareunemp shareemp sharesemp sharebus]';
occsinit(occdist01)

occinit(r0')

entselect(bigprob,bigprob(OCC==3|OCC==4),BIGZ,BIGZ(OCC==3|OCC==4))

disp 'Wage'
w0
disp 'Labor Demand'
LD
disp 'Tax Rate'
tau
disp 'Unemployment'
sum(OCC==1)/NN
disp 'Entrepreneurship Traditioanl'
sum(OCC==3)/NN
disp 'Entrepreneurship Modern'
sum(OCC==4)/NN
disp 'Subsistence share of entrepreneurs'
sharesubsemp
disp 'Subsistence share of population'
sharesubtot

% Firm distribution
totlabor = [LDS ; LDB];
nument = length(totlabor);

firmdist = zeros(6,2);
firmdist(1,1) = sum(totlabor<5)/nument;
firmdist(2,1) = sum(totlabor<10)/nument;
firmdist(3,1) = sum(totlabor<25)/nument;
firmdist(4,1) = sum(totlabor<50)/nument;
firmdist(5,1) = sum(totlabor<100)/nument;
firmdist(6,1) = sum(totlabor<250)/nument;


load('0210etta85b015')

totlabor = [LDS ; LDB];
nument = length(totlabor);

firmdist(1,2) = sum(totlabor<5)/nument;
firmdist(2,2) = sum(totlabor<10)/nument;
firmdist(3,2) = sum(totlabor<25)/nument;
firmdist(4,2) = sum(totlabor<50)/nument;
firmdist(5,2) = sum(totlabor<100)/nument;
firmdist(6,2) = sum(totlabor<250)/nument;

shareunemp = sum(OCC==1)/NN;
shareemp  = sum(OCC==2)/NN;
sharesemp = sum(OCC==3)/NN;
sharebus = sum(OCC==4)/NN;

occdist15 = [shareunemp shareemp sharesemp sharebus]';

createfigure([occdist01 occdist15])

