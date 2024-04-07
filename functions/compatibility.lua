local compatibility = {}

local array = require("__Pacifist__.lib.array")

local mod_info = {
    exceptions = {},
    extra = {},
    ignore = {},
    required = {}
}

for mod_name, version in pairs(mods) do
    local status, module = pcall(require,"__Pacifist__.compatibility." .. mod_name)
    module = status and module or {}

    for section_name, info_section in pairs(mod_info) do
        if module[section_name] then
            for subsection_name, mod_subsection in pairs(module[section_name]) do
                info_section[subsection_name] = info_section[subsection_name] or {}
                if type(mod_subsection) == "table" then
                    array.append(info_section[subsection_name], mod_subsection)
                else
                    array.append(info_section[subsection_name], { tostring(mod_subsection) })
                end
            end
        end
    end
end

function compatibility.extend_config()
    for section_name, info_section in pairs(mod_info) do
        for subsection_name, info_subsection in pairs(info_section) do
            array.append(PacifistMod[section_name][subsection_name], info_subsection)
        end
    end
end

function compatibility.walls_required()
    return (settings.startup["dectorio-walls"] and settings.startup["dectorio-walls"].value)
        or mods["angelsbioprocessing"]
end

function compatibility.shields_required()
    return mods["500BotStart"] ~= nil
end

return compatibility