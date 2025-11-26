classdef BatteryStorage < handle
    properties
        capacity        % Total capacity (kWh)
        efficiency      % Round-trip efficiency
        maxChargeRate   % Maximum charge rate (fraction of capacity)
        maxDischargeRate % Maximum discharge rate (fraction of capacity)
        currentEnergy   % Current stored energy
    end
    
    methods
        function obj = BatteryStorage(capacity, efficiency, maxChargeRate, maxDischargeRate)
            obj.capacity = capacity;
            obj.efficiency = efficiency;
            obj.maxChargeRate = maxChargeRate;
            obj.maxDischargeRate = maxDischargeRate;
            obj.currentEnergy = capacity * 0.5; % Start at 50% charge
        end
        
        function success = charge(obj, energy, timeStep)
            % Charge the battery with SOC protection
            maxSOC = obj.capacity * 0.8; % Never go above 80%
            availableCapacity = maxSOC - obj.currentEnergy;
            
            maxCharge = min(obj.maxChargeRate * obj.capacity, availableCapacity);
            actualCharge = min(energy * obj.efficiency, maxCharge);
            
            if actualCharge > 0 && obj.currentEnergy + actualCharge <= maxSOC
                obj.currentEnergy = obj.currentEnergy + actualCharge;
                success = true;
            else
                success = false;
            end
        end
        
        function [energyOut, success] = discharge(obj, energyRequested, timeStep)
            % Discharge the battery with SOC protection
            minSOC = obj.capacity * 0.2; % Never go below 20%
            availableEnergy = obj.currentEnergy - minSOC;
            
            maxDischarge = min(obj.maxDischargeRate * obj.capacity, availableEnergy);
            actualDischarge = min(energyRequested, maxDischarge);
            
            if actualDischarge > 0 && obj.currentEnergy - actualDischarge >= minSOC
                obj.currentEnergy = obj.currentEnergy - actualDischarge;
                energyOut = actualDischarge / obj.efficiency;
                success = true;
            else
                energyOut = 0;
                success = false;
            end
        end
    end
end