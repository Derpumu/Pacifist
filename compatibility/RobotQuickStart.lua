-- RobotQuickStart as of version 2.0.2 adds magazines and SMGs to the inventory unconditionally
-- we keep the items but remove the recipes to get rid of the technologies as well.
return {
    exceptions = {
        ammo = "uranium-rounds-magazine",
        gun = "submachine-gun",
    },
    extra = {
        recipe = {"uranium-rounds-magazine", "submachine-gun"}
    }
}
