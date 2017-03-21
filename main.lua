require "utils.OOUtil"

local BattleDirector = require("logic.BattleDirector")
local EntityLogic = require("logic.RoleLogic")
local BattleContext = require("logic.BattleContext")

local function main()
    local battleContext = BattleContext.create()
    local director = BattleDirector.create(battleContext)
    for _=1,5 do
        local entity = EntityLogic.create({})
        director:addEntity(entity)
    end
    director:startBattle()
end

main();
