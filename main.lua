require "utils.OOUtil"
require "utils.ArrayUtil"
require "const.Constants"

local BattleDirector = require("logic.BattleDirector")
local EntityLogic = require("logic.RoleLogic")
local RoleContext = require("logic.RoleContext")
local BattleContext = require("logic.BattleContext")

local function main()
    local battleContext = BattleContext.create()
    battleContext:setSeed(os.time())
    local director = BattleDirector.create(battleContext)
    local names = {"Anna", "Ben", "Cuck", "Ely"}
    for i=1,5 do
        local context = RoleContext.create({hp=100,atk={8,13},name=names[i]})
        local entity = EntityLogic.create(context)
        director:addEntity(entity)
    end
    director:startBattle()
    print("=================game over=================")
    for _,v in ipairs(director:getAllAliveRole()) do
        print(string.format("%s %s alive hp:%s", v.id, v.name, v.curHp))
    end
end

main();
