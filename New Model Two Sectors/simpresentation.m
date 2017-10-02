clear all

load('2709etta85b001')

OCC01 = OCC;

shareunemp = sum(OCC==1)/NN;
shareemp  = sum(OCC==2)/NN;
sharesemp = sum(OCC==3)/NN;
sharebus = sum(OCC==4)/NN;

occdist01 = [shareunemp shareemp sharesemp sharebus]';
occsinit(occdist01)

load('2709etta85b015tau05')

shareunemp = sum(OCC==1)/NN;
shareemp  = sum(OCC==2)/NN;
sharesemp = sum(OCC==3)/NN;
sharebus = sum(OCC==4)/NN;

occdist15 = [shareunemp shareemp sharesemp sharebus]';

createfigure([occdist01 occdist15])

