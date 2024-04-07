local walls_required = settings.startup["dectorio-walls"] and settings.startup["dectorio-walls"].value

return {
    required = {
        walls = walls_required
    }
}
