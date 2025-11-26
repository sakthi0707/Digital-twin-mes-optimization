classdef RenewablePredictionModel
    methods
        function obj = RenewablePredictionModel()
            % Constructor - no arguments needed
        end
        
        function prediction = predict(obj, weatherData)
            % More realistic renewable prediction
            solarRadiation = weatherData(:,4)';
            windSpeed = weatherData(:,3)';
            
            % Realistic scaling with capacity factors
            solarCapacityFactor = 0.15; % Typical solar capacity factor
            windCapacityFactor = 0.25;  % Typical wind capacity factor
            
            solarPrediction = solarRadiation * 200 * solarCapacityFactor;
            windPrediction = (windSpeed.^3) * 100 * windCapacityFactor;
            
            prediction = solarPrediction + windPrediction;
            
            % Ensure prediction is reasonable
            prediction = max(prediction, 0);
            prediction = min(prediction, 800); % Max 800 kW
        end
    end
end