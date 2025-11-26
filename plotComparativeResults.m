function plotComparativeResults(results)
    % Plot comparative results
    figure('Position', [100, 100, 1000, 600]);
    
    strategies = {results.strategy};
    carbon = [results.carbonFootprint];
    cost = [results.operationalCost];
    renewable = [results.renewablePenetration];
    batterySOC = [results.batteryFinalSOC];
    
    subplot(2,2,1);
    bar(carbon);
    set(gca, 'XTickLabel', strategies);
    title('Carbon Footprint Comparison');
    ylabel('kgCO?');
    grid on;
    
    subplot(2,2,2);
    bar(cost);
    set(gca, 'XTickLabel', strategies);
    title('Operational Cost Comparison');
    ylabel('USD');
    grid on;
    
    subplot(2,2,3);
    bar(renewable);
    set(gca, 'XTickLabel', strategies);
    title('Renewable Penetration');
    ylabel('%');
    grid on;
    
    subplot(2,2,4);
    bar(batterySOC);
    set(gca, 'XTickLabel', strategies);
    title('Battery Final State of Charge');
    ylabel('kWh');
    grid on;
end