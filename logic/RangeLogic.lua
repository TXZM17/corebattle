local EntityLogic = require("logic.EntityLogic")
local RangeLogic = EntityLogic.create({})

RangeLogic.type = "RangeLogic"

function RangeLogic.create(context)
    local ret = {}
    setmetatable(ret, {__index=RangeLogic})
    ret:init(context)
    return ret
end

function RangeLogic:init(context)
    EntityLogic.init(self, context)
end

function RangeLogic:getAnchorPoint()
    return self.context.anchor
end

function RangeLogic:getShape()
    return self.context.shape
end

function RangeLogic:getRadius()
    if self:getShape()==Constants.SHAPE.CIRCLE then
        return self.context.radius
    end
end

function RangeLogic:inRange(entity)
    if self:getShape()==Constants.SHAPE.CIRCLE then
        local dist = math.sqrt((self.context.anchor.x-entity.anchor.x)^2+(self.context.anchor.y-entity.anchor.y)^2)
        return dist<=self:getRadius()
    elseif self:getShape()==Constants.SHAPE.RECT then
        local inX = entity.anchor.x>=self.context.anchor.x and entity.anchor.x<=self.context.anchor.x+self.context.width
        local inY = entity.anchor.y>=self.context.anchor.y and entity.anchor.y<=self.context.anchor.y+self.context.height
        return inX and inY
    elseif self:getShape()==Constants.SHAPE.TRIANGLE then
        -- TODO
        return false
    else
        return true
    end
end

return RangeLogic
