classdef ThermalStorage < handle
    properties
        capacity
        efficiency
        maxChargeRate
        maxDischargeRate
        currentEnergy
        temperature     % Storage temperature
    end
    
    methods
        function obj = ThermalStorage(capacity, efficiency, maxChargeRate, maxDischargeRate)
            obj.capacity = capacity;
            obj.efficiency = efficiency;
            obj.maxChargeRate = maxChargeRate;
            obj.maxDischargeRate = maxDischargeRate;
            obj.currentEnergy = capacity * 0.4;
            obj.temperature = 60; % degrees Celsius
        end
        
        function success = charge(obj, energy, timeStep)
            % Simplified charge method
            maxCharge = min(obj.maxChargeRate * obj.capacity, ...
                obj.capacity - obj.currentEnergy);
            actualCharge = min(energy * obj.efficiency, maxCharge);
            
            if actualCharge > 0
                obj.currentEnergy = obj.currentEnergy + actualCharge;
                obj.temperature = obj.temperature + actualCharge/100;
                success = true;
            else
                success = false;
            end
        end
        
        function [energyOut, success] = discharge(obj, energyRequested, timeStep)
            % Simplified discharge method
            maxDischarge = min(obj.maxDischargeRate * obj.capacity, ...
                obj.currentEnergy);
            actualDischarge = min(energyRequested, maxDischarge);
            
            if actualDischarge > 0
                obj.currentEnergy = obj.currentEnergy - actualDischarge;
                obj.temperature = obj.temperature - actualDischarge/100;
                energyOut = actualDischarge / obj.efficiency;
                success = true;
            else
                energyOut = 0;
                success = false;
            end
        end
    end
end