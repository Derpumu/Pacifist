local array = require("__Pacifist__.lib.array") --[[@as Array]]
local string = require("__Pacifist__.lib.string")
require("__Pacifist__.lib.debug")

local mod_info = {
    exceptions = { __has_subsection = true },
    extra = { __has_subsection = true },
    ignore = { __has_subsection = true },
    preprocess = {},
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

local load_compatibility_module = function(mod_name)
    local required_name = "__Pacifist__.compatibility." .. mod_name
    local status, module = pcall(require, required_name)
    if not status then
        -- it's OK if the file itself does not exist, otherwise dump the error
        assert(type(module) == "string" and string.starts_with(module, "module " .. required_name .. " not found;  no such file"), module)
        return
    end

    -- dump_table(module, "compatibility." .. mod_name)
    if module then
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
    end
end

for mod_name, _ in pairs(mods) do
    load_compatibility_module(mod_name)
end

local compatibility = {}

---@param config Config
function compatibility.extend_config(config)
    for section_name, info_section in pairs(mod_info) do
        if info_section.__has_subsection then
            for subsection_name, info_subsection in pairs(info_section) do
                if not string.starts_with(subsection_name, "__") then
                    config[section_name][subsection_name] = config[section_name][subsection_name] or {}
                    array.append(config[section_name][subsection_name], info_subsection --[=[@as any[]]=])
                end
            end
        else
            array.append(config[section_name], info_section)
        end
    end
end

return compatibility