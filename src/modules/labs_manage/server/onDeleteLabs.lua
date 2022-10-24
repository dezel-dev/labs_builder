---@author Dezel

LaboratoryUtils.Events:register("deleteLabs", function(labId)
	MySQL.query("DELETE FROM `laboratory` WHERE `id` = :id", {
		id = labId
	})
end)