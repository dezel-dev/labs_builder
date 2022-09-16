--[[
    bootstrap.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 20:46:25
]]--
---@author Dezel

---@class LaboratoryUtils
LaboratoryUtils = { Misc = {}, Events = {}, Player = {}, Menu = {}, Instance = {}}

---@class LaboratoryMenu
LaboratoryMenu = { Builder = {}, Machine = {}}

---@class LaboratoryMachine
LaboratoryMachine = {}

---@class LaboratoryEnum
LaboratoryEnum = {}

ESX = nil
TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)