function createCostComparisonFigure()
    figure('Position', [100, 100, 800, 500]);
    
    strategies = {'Baseline', 'Rule-Based', 'MPC', 'Genetic Algorithm'};
    cost_data = [721.9, 869.8, 609.4, 624.4]; % YOUR ACTUAL RESULTS
    
    bar(cost_data, 'FaceColor', [0.2 0.6 0.3], 'EdgeColor', 'black');
    ylabel('Operational Cost ($)', 'FontSize', 12, 'FontWeight', 'bold');
    
    % Add main title for R2017a
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 0.98, 'Operational Cost Comparison', ...
        'HorizontalAlignment','center','VerticalAlignment', 'top', ...
        'FontSize', 14, 'FontWeight', 'bold');
    
    set(gca, 'XTickLabel', strategies, 'FontSize', 11);
    grid on;
    
    for i = 1:length(cost_data)
        text(i, cost_data(i) + 20, sprintf('$%.1f', cost_data(i)), ...
            'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 11);
    end
    
    % Add percentage change annotations
    text(2, 750, '+20.5%', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'blue');
    text(3, 550, '-15.6%', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'red');
    text(4, 570, '-13.5%', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'green');
    
    set(gcf, 'Color', 'white');
    print('CostComparison', '-dpng', '-r300');
    saveas(gcf, 'CostComparison.fig');
end