--[[
    Laboratory.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 21/08/2022 - 15:33:11
]]--
---@author Dezel

---@class _Laboratory
_Laboratory = {}

local __instance = {
    __index = _Laboratory
}

setmetatable(_Laboratory, {
    __call = function(_, metadata)
        local self = setmetatable({}, __instance)

        self.instance = math.random(1, 1000000)
        self.id = metadata.id
        self.gang = metadata.gang
        self.type = metadata.type
        self.position = metadata.position
        self.name = metadata.name
        self.access = metadata.access
        self.chest = metadata.chest
        self.machine = metadata.machine
        if (self.type == "drugs_production") then
            self.drugs = metadata.drugs
            self.bag = metadata.bag
        end

        LaboratoryModules:add(self)
        LaboratoryModules:refresh()

        return (self)
    end
})