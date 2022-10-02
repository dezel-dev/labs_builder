---@author Dezel

local LaboratoryList = {}

MySQL.ready(function()
	MySQL.query("SELECT * FROM laboratory", {}, function(rows)
		local number = 0
		for _, v in pairs(rows) do
			local otherMetadata = json.decode(v.metadata)
			local metadata = {
				id = v.id,
				gang = otherMetadata.gang,
				type = otherMetadata.type,
				position = otherMetadata.position,
				drugs = otherMetadata.drugs,
				name = otherMetadata.name,
				access = otherMetadata.access,
				chest = json.decode(v.chest),
				bag = json.encode(v.bag),
				machine = {}
			}
			_Laboratory(metadata)
			number += 1
		end
		LaboratoryUtils.Misc:log(("Loaded successfully ^2%s ^7laboratory"):format(number))
	end)
end)

function LaboratoryModules:add(metadata)
	LaboratoryUtils.Misc:log(("Create new laboratory with metadata : %s"):format(json.encode(metadata)))
	LaboratoryList[metadata.id] = metadata
end

function LaboratoryModules:getById(laboratoryId)
	if (not LaboratoryList[laboratoryId]) then
		return LaboratoryUtils.Misc:log("None laboratory with this ID exist!")
	end
	return (LaboratoryList[laboratoryId])
end

function LaboratoryModules:refresh()
	LaboratoryUtils.Events:toClient("refreshLaboratory", -1, LaboratoryList)
end

function _Laboratory:haveGradeAccess(gradeId)
	return (self.access[tostring(gradeId)])
end

function _Laboratory:chestAddItem(item, qty)
	if (self.chest[item.name]) then
		self.chest[item.name] = { name = self.chest[item.name].name, amount = self.chest[item.name].amount + qty, label = self.chest[item.name].label}
	else
		self.chest[item.name] = { name = item.name, amount = qty, label = item.label}
	end
	MySQL.query("UPDATE `laboratory` SET `chest`=@chest WHERE `id`=@id", {
		["@chest"] = json.encode(self.chest),
		["@id"] = self.id
	})
end

function _Laboratory:chestRemoveItem(item, qty)
	if (self.chest[item.name]) then
		if (self.chest[item.name].amount >= qty) then
			self.chest[item.name] = { name = self.chest[item.name].name, amount = self.chest[item.name].amount - qty, label = self.chest[item.name].label }
			MySQL.query("UPDATE `laboratory` SET `chest`=@chest WHERE `id`=@id", {
				["@chest"] = json.encode(self.chest),
				["@id"] = self.id
			})
			return (true)
		end
	end
	return (false)
end