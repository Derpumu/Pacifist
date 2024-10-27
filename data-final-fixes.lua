Pacifist = require("functions.data")
DataRaw = require("lib.data_raw")

local data_raw = DataRaw:new(data.raw)
local new_data = Pacifist.process(data_raw)
