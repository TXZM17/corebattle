local Calculator = require("logic.calculate.Calculator")
local ScaleCalculator = Calculator.create()

ScaleCalculator.type = "ScaleCalculator"

-- 比例，是否是原始属性的比例
function ScaleCalculator.create(scale)
    local ret = {}
    setmetatable(ret, {__index=ScaleCalculator})
    ret:init(scale)
    return ret
end

function ScaleCalculator:init(scale)
    Calculator.init(self)
    self.scale = scale
end

function ScaleCalculator:calculate(lastResult)
    print("calculator:", self.type, self.id)
    lastResult = lastResult*self.scale
    return true, lastResult
end

return ScaleCalculator
