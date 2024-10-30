local array = require("__Pacifist__.lib.array")
local string = require("__Pacifist__.lib.string")

local mod_info = {
    exceptions = { __has_subsection = true },
    extra = { __has_subsection = true },
    ignore = { __has_subsection = true },
    preprocess = {},
}

local required = {
    walls = false,
    shields = false
}

local function append(info_list, mod_part)
    if type(mod_part) == "table" then
        array.append(info_list, mod_part)
    elseif type(mod_part) == "function" then
        array.append(info_list, { mod_part })
    else
        array.append(info_list, { tostring(mod_part) })
    end
end

for mod_name, version in pairs(mods) do
    local status, module = pcall(require,"__Pacifist__.compatibility." .. mod_name)
    module = status and module or {}

    for section_name, info_section in pairs(mod_info) do
        if module[section_name] then
            if info_section.__has_subsection then
                for subsection_name, mod_subsection in pairs(module[section_name]) do
                    info_section[subsection_name] = info_section[subsection_name] or {}
                    append(info_section[subsection_name], mod_subsection)
                end
            else
                append(info_section, module[section_name])
            end
        end
    end

    for name, flag in pairs(required) do
        required[name] = (module.required and module.required[name]) or flag
    end
end


local compatibility = {}

function compatibility.extend_config(config)
    for section_name, info_section in pairs(mod_info) do
        if info_section.__has_subsection then
            for subsection_name, info_subsection in pairs(info_section) do
                if not string.starts_with(subsection_name, "__") then
                    config[section_name][subsection_name] = config[section_name][subsection_name] or {}
                    array.append(config[section_name][subsection_name], info_subsection)
                end
            end
        else
            array.append(config[section_name], info_section)
        end
    end
    for name, flag in pairs(required) do
        config.required[name] = config.required[name] or flag
    end
end

return compatibility