local compatibility = {}

local array = require("__Pacifist__.lib.array")

local mod_info = {
    exceptions = {},
    extra = {},
    ignore = {},
}

local required = {
    walls = false,
    shields = false
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

    for name, flag in pairs(required) do
        required[name] = (module.required and module.required[name]) or flag
    end
end

function compatibility.extend_config()
    for section_name, info_section in pairs(mod_info) do
        for subsection_name, info_subsection in pairs(info_section) do
            array.append(PacifistMod[section_name][subsection_name], info_subsection)
        end
    end
    PacifistMod.required = PacifistMod.required or {}
    for name, flag in pairs(required) do
        PacifistMod.required[name] = PacifistMod.required[name] or flag
    end
end

function compatibility.walls_required()
    return PacifistMod.required.walls
end

function compatibility.shields_required()
    return PacifistMod.required.shields
end

return compatibility