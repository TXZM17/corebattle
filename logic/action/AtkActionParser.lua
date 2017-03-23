local ActionParser = require("logic.action.ActionParser")
local AtkActionParser = ActionParser.create()

AtkActionParser.type = "AtkActionParser"

function AtkActionParser.create(director, action)
    local ret = {}
    setmetatable(ret, {__index=AtkActionParser})
    ret:init(director, action)
    return ret
end

function AtkActionParser:init(director, action)
    ActionParser.init(self, director, action)
end

function AtkActionParser:doAction()
    local atk = self._action.caster:getRealAtk()
    for _,target in ipairs(self._action.targets) do
        if target.type=="RangeLogic" then
            for _,rangeTarget in ipairs(self._director:getRangeTargets()) do
                if self._action:canRangeAtk(rangeTarget) then
                    rangeTarget:onRangeHurt(self:getActionInfo(atk, rangeTarget, target))
                end
            end
        else
            target:onPointHurt(self:getActionInfo(atk, target, target))
        end
    end
end

function AtkActionParser:getActionInfo(hurtValue, realTarget, target)
    return {
        realTarget = realTarget,
        target = target,
        caster = self._action.caster,
        hurtValue = hurtValue,
    }
end

return AtkActionParser
