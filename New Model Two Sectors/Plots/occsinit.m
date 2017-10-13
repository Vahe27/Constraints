function occsinit(yvector1)
%CREATEFIGURE1(yvector1)
%  YVECTOR1:  bar yvector

%  Auto-generated by MATLAB on 29-Sep-2017 10:55:54

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create bar
bar(yvector1,'FaceColor',[0 0.447058826684952 0.74117648601532],...
    'BarWidth',1);

% Create ylabel
ylabel('Density');

% Create xlabel
xlabel('Occupations');

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',13,'XTick',[1 2 3 4],'XTickLabel',...
    {'Unemployed','Employed','Traditional ','Modern'});