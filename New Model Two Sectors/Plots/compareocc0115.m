function compareocc0115(ymatrix1)
%CREATEFIGURE1(ymatrix1)
%  YMATRIX1:  bar matrix data

%  Auto-generated by MATLAB on 29-Sep-2017 10:39:59

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to bar
bar1 = bar(ymatrix1);
set(bar1(2),'DisplayName','b = 0.15','BarWidth',1);
set(bar1(1),'DisplayName','b = 0.01');

% Create ylabel
ylabel('Share in the Population');

% Create xlabel
xlabel('Occupations');

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',12,'XTick',[1 2 3 4],'XTickLabel',...
    {'Unemployed','Employed','Traditional','Modern'});
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.785758928914854 0.805232558139535 0.109553571085146 0.0959683850359945],...
    'FontSize',12);

