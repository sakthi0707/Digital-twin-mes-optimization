function create_tornado_plot()
    % Tornado plot for sensitivity analysis
    parameters = {'Carbon Price', 'Renewable Availability', 'Electricity Price', 'Storage Efficiency'};
    
    % Base case carbon footprint (kgCO2)
    base_value = 1741.1;
    
    % Sensitivity results (carbon footprint for low/high parameter values)
    low_values = [1850, 1900, 1790, 1760];    % Higher emissions for unfavorable conditions
    high_values = [1630, 1580, 1690, 1720];   % Lower emissions for favorable conditions
    
    % Calculate impacts (deviation from base)
    low_impact = low_values - base_value;
    high_impact = base_value - high_values;
    
    figure('Position', [100, 100, 800, 600]);
    
    % Create horizontal bars
    for i = 1:length(parameters)
        % Negative impact (worse than base) - LEFT side
        barh(i, -low_impact(i), 'FaceColor', [0.8, 0.2, 0.2], 'EdgeColor', 'k', 'FaceAlpha', 0.7);
        hold on;
        % Positive impact (better than base) - RIGHT side  
        barh(i, high_impact(i), 'FaceColor', [0.2, 0.6, 0.2], 'EdgeColor', 'k', 'FaceAlpha', 0.7);
    end
    
    % Customize plot
    set(gca, 'YTick', 1:length(parameters), 'YTickLabel', parameters);
    xlabel('Change in Carbon Footprint (kgCO?)');
    title('Tornado Plot: Parameter Impact on Carbon Footprint (MPC Strategy)');
    grid on;
    
    % Add zero line (compatible with older MATLAB versions)
    y_limits = ylim;
    x_limits = xlim;
    line([0, 0], [y_limits(1), y_limits(2)], 'Color', 'k', 'LineStyle', '--', 'LineWidth', 2);
    text(0, y_limits(2)*0.95, 'Base Case', 'HorizontalAlignment', 'center', ...
         'BackgroundColor', 'white', 'FontWeight', 'bold');
    
    % Add legend
    legend({'Unfavorable Conditions', 'Favorable Conditions'}, 'Location', 'northeast');
    
    % Improve appearance
    set(gca, 'FontSize', 12, 'FontWeight', 'bold');
    set(gcf, 'Color', 'white');
    
    % Save figure
    saveas(gcf, 'tornado_plot.png');
    saveas(gcf, 'tornado_plot.fig');
    print('-dpng', '-r300', 'tornado_plot_highres.png'); % High resolution version
end