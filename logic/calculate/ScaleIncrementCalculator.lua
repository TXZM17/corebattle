local Calculator = require("logic.calculate.Calculator")
local ScaleIncrementCalculator = Calculator.create()

ScaleIncrementCalculator.type = "ScaleIncrementCalculator"

-- 比例，是否是原始属性的比例
function ScaleIncrementCalculator.create(scale, isBase)
    local ret = {}
    setmetatable(ret, {__index=ScaleIncrementCalculator})
    ret:init(scale, isBase)
    return ret
end

function ScaleIncrementCalculator:init(scale, isBase)
    Calculator.init(self)
    self.scale = scale
    self.isBase = isBase
end

function ScaleIncrementCalculator:calculate(lastResult, proName, baseContext)
    print("calculator:", self.type, self.id)
    if self.isBase then
        lastResult = lastResult + baseContext[proName]*self.scale
    else
        lastResult = lastResult + lastResult * self.scale
    end
    return true, lastResult
end

return ScaleIncrementCalculator
