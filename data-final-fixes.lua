Pacifist = require("functions.pacifist")
DataRaw = require("lib.data_raw")

local data_raw = DataRaw:new(data.raw)
Pacifist.process(data_raw)

require("prototype.dummies")

data.raw["item"]["grenade"].icon = "__Pacifist__/graphics/blasting-cap.png"
