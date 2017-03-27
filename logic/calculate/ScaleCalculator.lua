local Calculator = require("logic.calculate.Calculator")
local ScaleCalculator = Calculator.create()

ScaleCalculator.type = "ScaleCalculator"

function ScaleCalculator.create(scale)
    local ret = {}
    setmetatable(ret, {__index=ScaleCalculator})
    ret:init(scale)
    return
end

function ScaleCalculator:init(scale)
    Calculator.init(self)
    self.scale = scale
end

function ScaleCalculator:calculate(context, lastResult, proName)
    print("calculator:", self.type, self.id)
    if lastResult then
        lastResult = lastResult * self.scale
    else
        lastResult = context[proName] * self.scale
    end
    return true, lastResult
end

return ScaleCalculator
