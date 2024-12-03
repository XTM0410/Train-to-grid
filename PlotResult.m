function PlotResult(T2GDeployableRegion,Power_MultiplePeriod,T2GDeployingPeriod_MultiplePeriod)
%PLOTRESULT Plot the result of the deployable T2G evaluation and the virtual energy storage aggregation model

figure;
hold on; 
set(gcf, 'Position', [100, 100, 600, 500]);  
set(gca,'position', [0.2 0.2 0.7 0.7]);

vesa = plot(T2GDeployableRegion(1,:),T2GDeployableRegion(2,:), '-', 'LineWidth',1);
dtp = scatter(T2GDeployingPeriod_MultiplePeriod,Power_MultiplePeriod,[], 'filled');

Xlim = T2GDeployingPeriod_MultiplePeriod(end);
x_ticks = 0:Xlim/3:Xlim;
xticks(x_ticks);
xlabel('T2G deploying period (min)')

Ylim = 1.2*Power_MultiplePeriod(1);
ylim([0 Ylim]);
ylabel('Deployable T2G power (MW)')

legend([dtp,vesa],'Deployable T2G evaluation','Virtual energy storage aggregation model');
end

