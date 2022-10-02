---@author Dezel

LaboratoryConfig.CommandBuilderName = "labs_builder" -- The name of the command to open the Laboratory Builder
LaboratoryConfig.CommandBuilderGroup = {
	--[[
		The groups who will have access
		to the Laboratory Builder!

		Example :
		user = false

		true = Have Access
		false = Doesn't have Access
	]]--
	admin = true,
	_dev = true,
	superadmin = true,
	user = false
}