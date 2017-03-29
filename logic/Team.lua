local Team = {}

Team.type = "Team"
Team._toAllocateId = 1

function Team.create()
    local ret = {}
    setmetatable(ret, {__index=Team})
    ret:init()
    return ret
end

function Team:init()
    Team.allocateId(self)
    -- 最大容量为五人
    self.maxMembers = 5
    self.members = {}
end

function Team:addMember(member)
    -- 其实可以使用#table来判定的，但是这样会不清晰
    for i=1,self.maxMembers do
        if not self.members[i] then
            self.members[i] = member
            member.teamId = self.id
            member.teamIndex = i
            return true
        end
    end
    return false
end

function Team:addMembers(members)
    local count = 0
    for i=1,self.maxMembers do
        if not self.members[i] then
            self.members[i] = members[count+1]
            members[count+1].teamId = self.id
            members[count+1].teamIndex = i
            count = count + 1
        end
    end
    return count
end

function Team:setMember(index, member)
    if index>self.maxMembers then
        return false
    end
    self.members[index] = member
    member.teamIndex = index
    member.teamId = self.id
    return true
end

function Team:indexMember(index)
    return self.members[index]
end

function Team.allocateId(team)
    team.id = Team._toAllocateId
    Team._toAllocateId = Team._toAllocateId + 1
end

return Team
