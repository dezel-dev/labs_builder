--[[
    setInstance.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 22/08/2022 - 19:16:14
]]--
---@author Dezel

function LaboratoryUtils.Instance:set(playerSrc, instance)
	SetPlayerRoutingBucket(playerSrc, instance)
end