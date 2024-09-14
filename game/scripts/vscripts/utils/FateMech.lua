local ____exports = {}
function ____exports.ChangeSkin(self, Unit, ModelName, ModelScale)
    if ModelScale == nil then
        ModelScale = 1
    end
    Unit:SetOriginalModel(ModelName)
    Unit:SetModel(ModelName)
    Unit:SetModelScale(ModelScale)
end
return ____exports
