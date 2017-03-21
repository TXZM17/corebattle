require "utils.OOUtil"
require "utils.ArrayUtil"

local BattleDirector = require("logic.BattleDirector")
local EntityLogic = require("logic.RoleLogic")
local RoleContext = require("logic.RoleContext")
local BattleContext = require("logic.BattleContext")

local function main()
    local battleContext = BattleContext.create()
    battleContext:setSeed(1787656567)
    local director = BattleDirector.create(battleContext)
    for _=1,5 do
        local context = RoleContext.create(1)
        local entity = EntityLogic.create(context)
        director:addEntity(entity)
    end
    director:startBattle()
end

main();
