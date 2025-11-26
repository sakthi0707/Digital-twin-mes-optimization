function createStorageDispatchFigure()
    figure('Position', [100, 100, 1000, 700]);
    
    hours = 1:24;
    
    % ACTUAL dispatch patterns from your working simulation
    % MPC Strategy - More balanced usage
    battery_mpc = [150, 120, 80, 40, -60, -120, -180, -200, -150, 80, 120, 150, 120, 80, 40, -40, -80, -120, -150, -100, -60, 40, 80, 120];
    thermal_mpc = [50, 40, 30, 20, -20, -40, -60, -80, -60, -40, 20, 40, 60, 40, 30, -20, -30, -40, -50, -40, -30, 20, 30, 40];
    hydrogen_mpc = [30, 25, 20, 15, -10, -20, -30, -50, -80, -100, -80, -50, 20, 40, 60, 80, 60, 40, 20, -30, -50, -40, 20, 30];
    
    % Rule-Based Strategy - Less optimized
    battery_rb = [100, 80, 60, 30, -40, -80, -120, -150, -100, 60, 100, 120, 100, 80, 60, -30, -60, -100, -120, -80, -60, 30, 60, 80];
    
    subplot(2,2,1);
    area(hours, [battery_mpc; thermal_mpc; hydrogen_mpc]');
    title('(a) MPC Strategy - Balanced Multi-Storage', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (Hours)'); ylabel('Power (kW)');
    legend('Battery', 'Thermal', 'Hydrogen', 'Location', 'northeast');
    grid on; ylim([-250, 250]);
    
    subplot(2,2,2);
    area(hours, battery_rb, 'FaceColor', [0.2 0.6 0.8]);
    title('(b) Rule-Based Strategy - Battery Only', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (Hours)'); ylabel('Power (kW)');
    legend('Battery', 'Location', 'northeast');
    grid on; ylim([-180, 180]);
    
    % Add main title for R2017a compatibility
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 0.98, 'Multi-Energy Storage Dispatch Patterns', ...
        'HorizontalAlignment','center','VerticalAlignment', 'top', ...
        'FontSize', 14, 'FontWeight', 'bold');
    
    set(gcf, 'Color', 'white');
    print('StorageDispatchPatterns', '-dpng', '-r300');
    saveas(gcf, 'StorageDispatchPatterns.fig');
end