function createCarbonFootprintFigure()
    figure('Position', [100, 100, 800, 500]);
    
    strategies = {'Baseline', 'Rule-Based', 'MPC', 'Genetic Algorithm'};
    carbon_data = [4812.9, 2485.2, 1741.1, 1784.0]; % YOUR ACTUAL RESULTS
    
    bar(carbon_data, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'black');
    ylabel('Carbon Footprint (kgCO_2)', 'FontSize', 12, 'FontWeight', 'bold');
    
    % Add main title for R2017a
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 0.98, 'Carbon Footprint Comparison', ...
        'HorizontalAlignment','center','VerticalAlignment', 'top', ...
        'FontSize', 14, 'FontWeight', 'bold');
    
    set(gca, 'XTickLabel', strategies, 'FontSize', 11);
    grid on;
    
    % Add value labels
    for i = 1:length(carbon_data)
        text(i, carbon_data(i) + 100, sprintf('%.1f', carbon_data(i)), ...
            'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 11);
    end
    
    % Add percentage improvement annotations
    text(2, 2000, '48.4% reduction', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'blue');
    text(3, 1200, '63.8% reduction', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'red');
    text(4, 1300, '62.9% reduction', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'green');
    
    set(gcf, 'Color', 'white');
    print('CarbonFootprintComparison', '-dpng', '-r300');
    saveas(gcf, 'CarbonFootprintComparison.fig');
end