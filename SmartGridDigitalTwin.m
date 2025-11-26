classdef SmartGridDigitalTwin < handle
    properties
        % Grid parameters
        gridLoad
        renewableGeneration
        carbonIntensity
        timeSteps
        
        % Energy storage systems
        batteryStorage
        thermalStorage
        hydrogenStorage
        
        % AI models
        loadForecaster
        renewablePredictor
        optimizationController
        
        % Simulation results
        results
        carbonFootprint
    end
    
    methods
        function obj = SmartGridDigitalTwin()
            % Initialize digital twin
            obj.initializeParameters();
            obj.initializeStorageSystems();
            obj.initializeAIModels();
        end
        
        function initializeParameters(obj)
            % Basic grid parameters
            obj.timeSteps = 1:24; % 24-hour simulation
            obj.gridLoad = zeros(1, 24);
            obj.renewableGeneration = zeros(1, 24);
            obj.carbonIntensity = zeros(1, 24);
        end
        
                  function initializeStorageSystems(obj)
            % Multi-energy storage initialization
            obj.batteryStorage = BatteryStorage(1000, 0.9, 0.2, 0.2);
            obj.thermalStorage = ThermalStorage(500, 0.85, 0.3, 0.3);
            obj.hydrogenStorage = HydrogenStorage(2000, 0.7, 0.15, 0.15);
        end
        
                     function initializeAIModels(obj)
            % Initialize AI/ML models - FIXED no arguments version
            obj.loadForecaster = LoadForecastingModel();
            obj.renewablePredictor = RenewablePredictionModel();
            obj.optimizationController = OptimizationController();
        end
        
        function simulate(obj, weatherData, loadProfile)
            % Main simulation function
            fprintf('Starting digital twin simulation...\n');
            
            % Store input data
            obj.gridLoad = loadProfile;
            
            % Predict renewable generation
            renewablePrediction = obj.predictRenewableGeneration(weatherData);
            obj.renewableGeneration = renewablePrediction;
            
            % Forecast load (using simplified method for demo)
            loadForecast = obj.forecastLoad(loadProfile);
            
            % Optimize energy storage (simplified for demo)
            [storageSchedule, gridSchedule] = obj.optimizeEnergyFlow(...
                renewablePrediction, loadForecast);
            
            % Calculate carbon footprint
            obj.calculateCarbonFootprint(gridSchedule, renewablePrediction);
            
            % Update carbon intensity for visualization
            for i = 1:24
                if obj.gridLoad(i) > obj.renewableGeneration(i)
                    obj.carbonIntensity(i) = 0.5; % kgCO2/kWh
                else
                    obj.carbonIntensity(i) = 0;
                end
            end
            
            fprintf('Simulation completed successfully.\n');
        end
        
        function prediction = predictRenewableGeneration(obj, weatherData)
            % Simplified renewable energy prediction
            solarRadiation = weatherData(:,4)'; % Extract solar radiation
            windSpeed = weatherData(:,3)';      % Extract wind speed
            
            % Simple models for demonstration
            solarPrediction = solarRadiation * 100; % kW per unit radiation
            windPrediction = windSpeed.^3 * 2;      % kW per m^3/s wind speed
            
            prediction = solarPrediction + windPrediction;
            fprintf('Renewable generation prediction completed\n');
        end
        
        function forecast = forecastLoad(obj, historicalData)
            % Simplified load forecasting
            forecast = historicalData * 0.9 + randn(1,24)*20;
            fprintf('Load forecasting completed for 24 hours\n');
        end
        
                function [storageSchedule, gridSchedule] = optimizeEnergyFlow(obj, ...
                renewablePrediction, loadForecast)
            
            % Reset storage to initial state
            obj.batteryStorage.currentEnergy = obj.batteryStorage.capacity * 0.5;
            obj.thermalStorage.currentEnergy = obj.thermalStorage.capacity * 0.4;
            obj.hydrogenStorage.currentEnergy = obj.hydrogenStorage.capacity * 0.3;
            
            % Use optimization controller with arguments
            [storageSchedule, gridSchedule] = ...
                obj.optimizationController.optimize(...
                renewablePrediction, loadForecast, ...
                obj.batteryStorage, obj.thermalStorage, obj.hydrogenStorage);
        end
        
                        function calculateCarbonFootprint(obj, gridSchedule, renewablePrediction)
            % Calculate carbon emissions correctly
            gridEnergy = sum(max(0, gridSchedule));
            
            % Renewable energy cannot exceed load
            renewableEnergy = sum(min(renewablePrediction, obj.gridLoad));
            totalEnergy = sum(obj.gridLoad);
            
            % More realistic carbon factor
            carbonFactor = 0.35; % kgCO2/kWh (average grid mix)
            obj.carbonFootprint = gridEnergy * carbonFactor;
            
            fprintf('Carbon footprint: %.2f kgCO2\n', obj.carbonFootprint);
            
            % Calculate renewable penetration correctly
            if totalEnergy > 0
                renewablePenetration = (renewableEnergy / totalEnergy) * 100;
                renewablePenetration = min(renewablePenetration, 100); % Cap at 100%
                fprintf('Renewable penetration: %.1f%%\n', renewablePenetration);
            else
                fprintf('Renewable penetration: 0%% (no energy demand)\n');
            end
        end
        
              function visualizeResults(obj)
            % Create comprehensive visualization with focus
            fig = figure('Position', [100, 100, 1200, 800], ...
                        'Name', 'Smart Grid Digital Twin Simulation', ...
                        'NumberTitle', 'off', ...
                        'MenuBar', 'none', ...
                        'ToolBar', 'none');
            
            % Ensure figure has focus
            drawnow;
            pause(0.1);
            
            % 1. Grid Load Profile
            subplot(3,2,1);
            plot(obj.timeSteps, obj.gridLoad, 'b-', 'LineWidth', 2);
            title('Grid Load Profile');
            xlabel('Time (hours)');
            ylabel('Load (kW)');
            grid on;
            xlim([1 24]);
            
            % 2. Renewable Generation
            subplot(3,2,2);
            plot(obj.timeSteps, obj.renewableGeneration, 'g-', 'LineWidth', 2);
            title('Renewable Generation');
            xlabel('Time (hours)');
            ylabel('Generation (kW)');
            grid on;
            xlim([1 24]);
            
            % 3. Energy Storage State
            subplot(3,2,3);
            storageData = [obj.batteryStorage.currentEnergy, ...
                          obj.thermalStorage.currentEnergy, ...
                          obj.hydrogenStorage.currentEnergy];
            bar(storageData, 'FaceColor', [0.2 0.6 0.8]);
            title('Energy Storage State');
            ylabel('Energy (kWh)');
            set(gca, 'XTickLabel', {'Battery', 'Thermal', 'Hydrogen'});
            grid on;
            
            % Add values on top of bars
            for i = 1:length(storageData)
                text(i, storageData(i) + max(storageData)*0.05, ...
                    sprintf('%.1f', storageData(i)), ...
                    'HorizontalAlignment', 'center', 'FontWeight', 'bold');
            end
            
            % 4. Energy Mix
            subplot(3,2,4);
            renewableEnergy = sum(obj.renewableGeneration);
            gridEnergy = max(0, sum(obj.gridLoad) - renewableEnergy);
            energyMix = [renewableEnergy, gridEnergy];
            
            if sum(energyMix) > 0
                percentages = energyMix / sum(energyMix) * 100;
                h = pie(energyMix);
                title('Energy Mix');
                legend({'Renewable', 'Grid'}, 'Location', 'best');
                
                % Add percentage labels
                textObjects = findobj(h, 'Type', 'text');
                if length(textObjects) >= 2
                    set(textObjects(1), 'String', sprintf('Renewable\n%.1f%%', percentages(1)));
                    set(textObjects(2), 'String', sprintf('Grid\n%.1f%%', percentages(2)));
                end
            else
                text(0.5, 0.5, 'No energy data', 'HorizontalAlignment', 'center');
                title('Energy Mix');
            end
            
            % 5. Carbon Intensity
            subplot(3,2,5);
            carbonIntensity = zeros(1,24);
            for i = 1:24
                if obj.gridLoad(i) > obj.renewableGeneration(i)
                    gridEnergy = obj.gridLoad(i) - obj.renewableGeneration(i);
                    carbonIntensity(i) = gridEnergy * 0.5; % kgCO2
                else
                    carbonIntensity(i) = 0;
                end
            end
            
            bar(obj.timeSteps, carbonIntensity, 'FaceColor', [0.8 0.2 0.2]);
            title('Carbon Intensity (Hourly Emissions)');
            xlabel('Time (hours)');
            ylabel('kgCO2');
            grid on;
            xlim([0.5 24.5]);
            
            % 6. Summary Statistics
                        % 6. Summary Statistics
            subplot(3,2,6);
            axis off;
            
            % Calculate renewable penetration correctly
            totalLoad = sum(obj.gridLoad);
            renewableGen = sum(min(obj.renewableGeneration, obj.gridLoad)); % Cap at load
            if totalLoad > 0
                renewablePercent = (renewableGen / totalLoad) * 100;
                renewablePercent = min(renewablePercent, 100); % Cap at 100%
            else
                renewablePercent = 0;
            end
            function plotComparativeResults(results)
    % Plot comparative results
    figure('Position', [100, 100, 1000, 600]);
    
    strategies = {results.strategy};
    carbon = [results.carbonFootprint];
    cost = [results.operationalCost];
    renewable = [results.renewablePenetration];
    
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
    batterySOC = [results.batteryFinalSOC];
    bar(batterySOC);
    set(gca, 'XTickLabel', strategies);
    title('Battery Final State of Charge');
    ylabel('kWh');
    grid on;
end
            % Position text properly to avoid overlap
            text(0.05, 0.95, 'SIMULATION SUMMARY', 'FontSize', 14, 'FontWeight', 'bold');
            text(0.05, 0.80, sprintf('Carbon Footprint: %.1f kgCO2', obj.carbonFootprint), 'FontSize', 11);
            text(0.05, 0.70, sprintf('Renewable Penetration: %.1f%%', renewablePercent), 'FontSize', 11);
            text(0.05, 0.60, sprintf('Total Load: %.1f kWh', totalLoad), 'FontSize', 11);
            text(0.05, 0.50, sprintf('Renewable Gen: %.1f kWh', renewableGen), 'FontSize', 11);
            
            text(0.05, 0.35, 'STORAGE STATUS:', 'FontSize', 11, 'FontWeight', 'bold');
            text(0.05, 0.25, sprintf('Battery: %.1f kWh (%.1f%%)', ...
                obj.batteryStorage.currentEnergy, ...
                (obj.batteryStorage.currentEnergy/obj.batteryStorage.capacity)*100), 'FontSize', 9);
            text(0.05, 0.15, sprintf('Thermal: %.1f kWh (%.1f%%)', ...
                obj.thermalStorage.currentEnergy, ...
                (obj.thermalStorage.currentEnergy/obj.thermalStorage.capacity)*100), 'FontSize', 9);
            text(0.55, 0.25, sprintf('Hydrogen: %.1f kWh (%.1f%%)', ...
                obj.hydrogenStorage.currentEnergy, ...
                (obj.hydrogenStorage.currentEnergy/obj.hydrogenStorage.capacity)*100), 'FontSize', 9);
            
            % Add main title for MATLAB 2017a compatibility
            ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
                'Visible','off','Units','normalized', 'clipping' , 'off');
            text(0.5, 0.98, 'AI-Enabled Digital Twin: Carbon-Neutral Smart Grid Simulation', ...
                'HorizontalAlignment','center','VerticalAlignment', 'top', ...
                'FontSize', 16, 'FontWeight', 'bold');
        end
    end
end