function createRenewablePenetrationFigure()
    figure('Position', [100, 100, 800, 500]);
    
    strategies = {'Baseline', 'Rule-Based', 'MPC', 'Genetic Algorithm'};
    penetration_data = [33.9, 41.6, 46.8, 44.2];
    
    b = bar(penetration_data, 'FaceColor', [0.1 0.5 0.8], 'EdgeColor', 'black');
    ylabel('Renewable Penetration (%)', 'FontSize', 12, 'FontWeight', 'bold');
    title('Renewable Energy Penetration Comparison', 'FontSize', 14, 'FontWeight', 'bold');
    set(gca, 'XTickLabel', strategies, 'FontSize', 11);
    grid on;
    ylim([0, 60]);
    
    for i = 1:length(penetration_data)
        text(i, penetration_data(i) + 2, sprintf('%.1f%%', penetration_data(i)), ...
            'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 11);
    end
    
    set(gcf, 'Color', 'white');
    exportgraphics(gcf, 'RenewablePenetration.png', 'Resolution', 300);
end