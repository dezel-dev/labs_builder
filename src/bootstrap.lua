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