require "utils.OOUtil"
require "utils.ArrayUtil"
require "const.Constants"

local BattleDirector = require("logic.BattleDirector")
local EntityLogic = require("logic.RoleLogic")
local RoleContext = require("logic.RoleContext")
local BattleContext = require("logic.BattleContext")
local ReboundPState = require("logic.permanentstate.ReboundPState")
local Team = require("logic.Team")
local ScaleCalculator = require("logic.calculate.ScaleCalculator")

local function main()
    local battleContext = BattleContext.create()
    battleContext:setSeed(os.time())
    local director = BattleDirector.create(battleContext)
    local names = {"Anna", "Ben", "Cuck", "Ely", "Ful"}
    local player = Team.create()
    for i=1,5 do
        local context = RoleContext.create({hp=100,atkMin=8,atkMax=13,name=names[i]})
        local entity = EntityLogic.create(context)
        if i==2 then
            local state = ReboundPState.create(entity)
            entity:addPermanentState(state)
        end
        player:addMember(entity)
    end
    director:addTeam(player)
    names = {"Vnna", "Wen", "Xuck", "Yly", "Zul"}
    local enemy = Team.create()
    for i=1,5 do
        local context = RoleContext.create({hp=100,atkMin=8,atkMax=13,name=names[i]})
        local entity = EntityLogic.create(context)
        if i==2 then
            local state = ReboundPState.create(entity)
            entity:addPermanentState(state)
            local cal = ScaleCalculator.create(1.2)
            cal:setInvolvedPros({atkMin=true,atkMax=true})
            entity:addCalculator(cal)
        end
        enemy:addMember(entity)
    end
    director:addTeam(enemy)
    director:startBattle()
    print("=================game over=================")
    for _,v in ipairs(director:getAllAliveRole()) do
        print(string.format("%s %s alive hp:%s", v.id, v.name, v:getProValue("hp")))
    end
end

main();
