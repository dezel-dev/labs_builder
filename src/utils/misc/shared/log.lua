--[[
    log.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:12:44
]]--
---@author Dezel

---log
---@param msg string
---@return void
---@public
function LaboratoryUtils.Misc:log(msg)
    print(("^7[^1Laboratory^7] %s"):format(msg))
end