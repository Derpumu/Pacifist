local debug = mods["pumu-dev"]
function debug_log(message)
    if debug then
        log(message)
    end
end
