---@author Dezel

LaboratoryMenu.Builder.FactionList = {}

CreateThread(function()
    MySQL.ready(function()
        MySQL.query("SELECT * FROM jobs", {}, function(rows)
            if (#rows <= 0) then
                return
            end
            for _, v in pairs(rows) do
                LaboratoryMenu.Builder.FactionList[string.upper(v.name)] = {
                    name = v.name,
                    label = v.label,
                    grade = {}
                }
                MySQL.query("SELECT * FROM job_grades WHERE job_name = @job_name", {
                    ['@job_name'] = v.name
                }, function(result)
                    if (#result <= 0) then
                        return
                    end
                    for _, data in pairs(result) do
                        table.insert(LaboratoryMenu.Builder.FactionList[string.upper(v.name)].grade, {
                            id = data.id,
                            grade = data.grade,
                            name = data.name,
                            label = data.label,
                            canEnter = true
                        })
                    end
                end)
            end
        end)
    end)
end)