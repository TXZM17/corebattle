local Calculator = {comp_type="Calculator"}

Calculator._toAllocateId = 1
Calculator.type = "Calculator"

-- calculator不改变玩家的基础属性，effect可以，这是区别
function Calculator.create()
    local ret = {}
    setmetatable(ret, {__index=Calculator})
    ret:init()
    return ret
end

function Calculator:init()
    Calculator.allocateId(self)
    self.priority = 1
    -- 所有可以计算的属性
    self._targetPros = {}
end

function Calculator:calculate(context, lastResult)
    error("this is a abstract calculate component", context, lastResult, self.id)
end

function Calculator:involved(proName)
    -- 是否参与计算
    if self._targetPros["all"] then
        return true
    end
    return self._targetPros[proName]
end

function Calculator:setInvolvedPros(proNames)
    self._targetPros = proNames
end

--static
function Calculator.allocateId(comp)
    comp.id = Calculator._toAllocateId
    Calculator._toAllocateId = Calculator._toAllocateId + 1
end

return Calculator
