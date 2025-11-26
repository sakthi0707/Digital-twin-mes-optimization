function create_violin_plots()
    % Violin plots for GA trial distributions
    
    % Simulate carbon footprint data for 30 GA trials across 4 parameter configurations
    rng(42); % For reproducibility
    
    % Create sample data (carbon footprint in kgCO2 for different scenarios)
    data = cell(1,4);
    
    % Scenario 1: Low carbon price
    data{1} = 1850 + 50*randn(30,1);
    
    % Scenario 2: Low renewable availability  
    data{2} = 1900 + 60*randn(30,1);
    
    % Scenario 3: High electricity price
    data{3} = 1790 + 45*randn(30,1);
    
    % Scenario 4: Low storage efficiency
    data{4} = 1760 + 40*randn(30,1);
    
    scenario_names = {'Low Carbon Price', 'Low Renewable Avail.', 'High Electricity Price', 'Low Storage Efficiency'};
    
    figure('Position', [100, 100, 1000, 700]);
    
    % Create violin plots
    violinplot(data, scenario_names, 'ShowMean', true, 'ShowData', false);
    
    % Customize plot
    ylabel('Carbon Footprint (kgCO?)');
    title('Distribution of Carbon Footprint Across 30 GA Trials');
    grid on;
    
    % Add statistical annotations
    hold on;
    for i = 1:length(data)
        median_val = median(data{i});
        text(i, median_val-20, sprintf('Med: %.1f', median_val), ...
             'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 10);
    end
    
    % Improve appearance
    set(gca, 'FontSize', 12, 'FontWeight', 'bold');
    set(gcf, 'Color', 'white');
    
    % Rotate x-axis labels if needed
    xtickangle(45);
    
    % Save figure
    saveas(gcf, 'violin_plots.png');
    saveas(gcf, 'violin_plots.fig');
end

% You'll need the violinplot function - here it is:
function h = violinplot(data, categories, varargin)
    % Simple violin plot implementation
    p = inputParser;
    addParameter(p, 'ShowMean', false);
    addParameter(p, 'ShowData', true);
    parse(p, varargin{:});
    
    num_categories = length(data);
    positions = 1:num_categories;
    
    for i = 1:num_categories
        % Kernel density estimation
        [f, xi] = ksdensity(data{i});
        
        % Normalize and scale the density
        f = f / max(f) * 0.3;
        
        % Plot violin (both sides)
        fill([positions(i)-f, positions(i)+fliplr(f)], [xi, fliplr(xi)], ...
             [0.3, 0.5, 0.8], 'FaceAlpha', 0.6, 'EdgeColor', 'k');
        hold on;
        
        % Add individual data points if requested
        if p.Results.ShowData
            jitter = 0.1 * randn(size(data{i}));
            scatter(positions(i) + jitter, data{i}, 40, 'k', 'filled', 'MarkerFaceAlpha', 0.6);
        end
        
        % Add mean line if requested
        if p.Results.ShowMean
            mean_val = mean(data{i});
            plot(positions(i) + [-0.2, 0.2], [mean_val, mean_val], 'r-', 'LineWidth', 2);
        end
        
        % Add median line
        median_val = median(data{i});
        plot(positions(i) + [-0.15, 0.15], [median_val, median_val], 'k-', 'LineWidth', 2);
    end
    
    xlim([0.5, num_categories + 0.5]);
    set(gca, 'XTick', positions, 'XTickLabel', categories);
end