local dev_mod = "pumu-dev"
local debug = (mods and mods[dev_mod])
        or (script and script.active_mods and script.active_mods[dev_mod])

function debug_log(message)
    if debug then
        log(message)
    end
end
