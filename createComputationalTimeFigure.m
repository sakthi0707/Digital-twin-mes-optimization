function createComputationalTimeFigure()
    figure('Position', [100, 100, 600, 400]);
    
    strategies = {'Rule-Based', 'MPC', 'Genetic Algorithm'};
    time_seconds = [0.1, 4.8, 125.3]; % Your actual timings
    
    bar(time_seconds, 'FaceColor', [0.5 0.3 0.8]);
    set(gca, 'XTickLabel', strategies, 'yscale', 'log'); % Log scale for clarity
    ylabel('Computational Time (seconds, log scale)');
    title('Computational Efficiency Comparison');
    grid on;
    
    for i = 1:length(time_seconds)
        text(i, time_seconds(i)*1.2, sprintf('%.1f s', time_seconds(i)), ...
            'HorizontalAlignment', 'center', 'FontWeight', 'bold');
    end
end