function createRenewablePenetrationFigure()
    figure('Position', [100, 100, 800, 500]);
    
    strategies = {'Baseline', 'Rule-Based', 'MPC', 'Genetic Algorithm'};
    penetration_data = [33.9, 44.6, 51.9, 51.9]; % YOUR ACTUAL RESULTS
    
    bar(penetration_data, 'FaceColor', [0.1 0.5 0.8], 'EdgeColor', 'black');
    ylabel('Renewable Penetration (%)', 'FontSize', 12, 'FontWeight', 'bold');
    
    % Add main title for R2017a
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 0.98, 'Renewable Energy Penetration', ...
        'HorizontalAlignment','center','VerticalAlignment', 'top', ...
        'FontSize', 14, 'FontWeight', 'bold');
    
    set(gca, 'XTickLabel', strategies, 'FontSize', 11);
    grid on;
    ylim([0, 60]);
    
    for i = 1:length(penetration_data)
        text(i, penetration_data(i) + 2, sprintf('%.1f%%', penetration_data(i)), ...
            'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 11);
    end
    
    % Add improvement annotations
    text(2, 38, '+31.6%', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'blue');
    text(3, 45, '+53.1%', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'red');
    text(4, 45, '+53.1%', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'green');
    
    set(gcf, 'Color', 'white');
    print('RenewablePenetration', '-dpng', '-r300');
    saveas(gcf, 'RenewablePenetration.fig');
end