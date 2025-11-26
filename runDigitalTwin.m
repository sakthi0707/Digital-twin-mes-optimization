% Main execution script
clear; clc; close all;

fprintf('=== AI-Enabled Digital Twin for Carbon-Neutral Smart Grid ===\n');

% Create digital twin instance
digitalTwin = SmartGridDigitalTwin();

% Generate sample data
hours = 0:23;
loadProfile = 400 + 300 * sin(2*pi*(hours-6)/24) + randn(1,24)*30;
loadProfile = max(loadProfile, 100);

weatherData = zeros(24, 6);
for i = 1:24
    weatherData(i,1) = 15 + 10 * sin(2*pi*(i-6)/24);
    weatherData(i,2) = 60 + 20 * sin(2*pi*(i-12)/24);
    weatherData(i,3) = 2 + 4 * rand();
    if i >= 6 && i <= 18
        weatherData(i,4) = 0.6 * sin(pi*(i-6)/12) + 0.1 * rand();
    else
        weatherData(i,4) = 0;
    end
    weatherData(i,5) = 0.3 + 0.4 * rand();
    weatherData(i,6) = 1013 + 10 * randn();
end

% Run simulation to get predictions
renewablePrediction = digitalTwin.predictRenewableGeneration(weatherData);
loadForecast = digitalTwin.forecastLoad(loadProfile);

% Store data
digitalTwin.gridLoad = loadProfile;
digitalTwin.renewableGeneration = renewablePrediction;

% Run comparative analysis
fprintf('\n=== Running Comparative Optimization Analysis ===\n');
results = digitalTwin.optimizationController.compareOptimizationStrategies(...
    renewablePrediction, loadForecast, digitalTwin.batteryStorage);

% Display results
fprintf('\n=== COMPARATIVE RESULTS ===\n');
for i = 1:length(results)
    fprintf('\n%s Strategy:\n', results(i).strategy);
    fprintf('  Carbon Footprint: %.1f kgCO2\n', results(i).carbonFootprint);
    fprintf('  Operational Cost: $%.2f\n', results(i).operationalCost);
    fprintf('  Renewable Penetration: %.1f%%\n', results(i).renewablePenetration);
    fprintf('  Battery Final SOC: %.1f kWh (%.1f%%)\n', results(i).batteryFinalSOC, (results(i).batteryFinalSOC/1000)*100);
end

% Debug analysis
debugOptimization(results);

% Visualize results
digitalTwin.visualizeResults();

% Plot comparative results
plotComparativeResults(results);

function debugOptimization(results)
    fprintf('\n=== DEBUG ANALYSIS ===\n');
    for i = 1:length(results)
        fprintf('\n%s:\n', results(i).strategy);
        fprintf('  Final Battery SOC: %.1f kWh (%.1f%%)\n', ...
                results(i).batteryFinalSOC, ...
                (results(i).batteryFinalSOC/1000)*100);
        
        % Check battery health
        soc_percent = (results(i).batteryFinalSOC/1000)*100;
        if soc_percent < 20
            fprintf('  ??  BATTERY HEALTH RISK: SOC below 20%%\n');
        elseif soc_percent > 80
            fprintf('  ??  BATTERY HEALTH RISK: SOC above 80%%\n');
        else
            fprintf('  ? Battery SOC within safe range (20-80%%)\n');
        end
        
        % Performance assessment
        if i > 1 % Skip baseline
            if results(i).carbonFootprint < results(1).carbonFootprint * 0.7
                fprintf('  ? Good carbon reduction (>30%% improvement)\n');
            else
                fprintf('  ??  Moderate carbon reduction\n');
            end
        end
    end
end