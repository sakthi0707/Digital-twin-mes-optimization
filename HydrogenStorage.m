classdef HydrogenStorage < handle
    properties
        capacity
        efficiency
        maxChargeRate
        maxDischargeRate
        currentEnergy
        pressure        % Storage pressure
    end
    
    methods
        function obj = HydrogenStorage(capacity, efficiency, maxChargeRate, maxDischargeRate)
            obj.capacity = capacity;
            obj.efficiency = efficiency;
            obj.maxChargeRate = maxChargeRate;
            obj.maxDischargeRate = maxDischargeRate;
            obj.currentEnergy = capacity * 0.3;
            obj.pressure = 350; % bar
        end
        
        function success = charge(obj, energy, timeStep)
            % Simplified charge method
            maxCharge = min(obj.maxChargeRate * obj.capacity, ...
                obj.capacity - obj.currentEnergy);
            actualCharge = min(energy * obj.efficiency, maxCharge);
            
            if actualCharge > 0
                obj.currentEnergy = obj.currentEnergy + actualCharge;
                obj.pressure = obj.pressure + actualCharge/10;
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
                obj.pressure = obj.pressure - actualDischarge/10;
                energyOut = actualDischarge / obj.efficiency;
                success = true;
            else
                energyOut = 0;
                success = false;
            end
        end
    end
end