function createParetoFrontFigure()
    figure('Position', [100, 100, 800, 600]);
    
    % Sample Pareto front data - replace with your GA results
    % Each point represents a solution trade-off between cost and carbon
    carbon_footprint = [4800, 4200, 3500, 2800, 2200, 1800, 1500, 1400, 1450, 1600];
    operational_cost = [700, 680, 650, 580, 480, 380, 280, 220, 210, 215];
    
    % Plot Pareto front
    plot(carbon_footprint, operational_cost, 'ro-', 'LineWidth', 2, 'MarkerSize', 8, ...
         'MarkerFaceColor', 'red', 'DisplayName', 'Pareto Front');
    hold on;
    
    % Highlight selected solutions
    plot(carbon_footprint(1), operational_cost(1), 'bs', 'MarkerSize', 12, ...
         'MarkerFaceColor', 'blue', 'DisplayName', 'Min-Carbon Solution');
    plot(carbon_footprint(end-2), operational_cost(end-2), 'g^', 'MarkerSize', 12, ...
         'MarkerFaceColor', 'green', 'DisplayName', 'Balanced Solution');
    plot(carbon_footprint(end), operational_cost(end), 'md', 'MarkerSize', 12, ...
         'MarkerFaceColor', 'magenta', 'DisplayName', 'Min-Cost Solution');
    
    xlabel('Carbon Footprint (kgCO?)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Operational Cost ($)', 'FontSize', 12, 'FontWeight', 'bold');
    
    % Add main title for R2017a
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 0.98, 'Genetic Algorithm: Pareto Optimal Front', ...
        'HorizontalAlignment','center','VerticalAlignment', 'top', ...
        'FontSize', 14, 'FontWeight', 'bold');
    
    legend('show', 'Location', 'northeast');
    grid on;
    
    % Add annotations
    text(3000, 600, 'Trade-off Region', 'FontSize', 11, 'Color', 'blue', 'FontWeight', 'bold');
    text(1500, 300, 'Optimal Solutions', 'FontSize', 11, 'Color', 'red', 'FontWeight', 'bold');
    
    set(gcf, 'Color', 'white');
    exportgraphics(gcf, 'ParetoFront.png', 'Resolution', 300);
end