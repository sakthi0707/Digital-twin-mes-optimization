classdef LoadForecastingModel
    properties
        predictionHorizon = 24
    end
    
    methods
        function obj = LoadForecastingModel()
            % Constructor - no arguments needed
        end
        
        function forecast = predict(obj, historicalData)
            % Simplified load forecasting for demonstration
            forecast = historicalData * 0.9 + randn(1,24)*20;
        end
    end
end