local Mgr = {}

function Mgr:init ()
    self.data = DataVo.new()
    self.priceCfg = {}
    self.openEmployee = 0

    --TODO 临时写法
    self.selectFriendName=""
end

function Mgr:clear ()
    self.data = nil
end

function Mgr:isLogin ()
    if self.data and self.data.usr and self.data.usr.id and self.data.usr.id ~= 0 then
        return true
    end
    return false
end

function Mgr:setUsr (data)
    -- if not self:isLogin() then
    --     return
    -- end
    self.data.usr = UsrVo.new(data)
end

function Mgr:getUsr ()
    dump(self.data)

    if not self:isLogin() then
        return
    end
    return self.data.usr
end

function Mgr:setCompany(data)
    if not self:isLogin() then
        return
    end
    self.data.company = CompanyVo.new(data)
end

function Mgr:getCompany ()
    if not self:isLogin() then
        return
    end
    return self.data.company
end

function Mgr:getUnit (index)
    if not self.isLogin then
        return
    end
    if not self.data.company then
        return
    end
    local unit = self.data.company.unitList[index]
    return unit
end

function Mgr:getUnitIndex (num)
    for i, v in ipairs(self.priceCfg) do
        if v == num then
            return i
        end
    end
    return 0
end

function Mgr:getUnitName (num)
    local list = {"专员","组长","主管","经理","总裁"}
    for i, v in ipairs(self.priceCfg) do
        if v == num then
            return list[i]
        end
    end
    return "--"
end

function Mgr:getNextUnitName (num)
    local list = {"专员","组长","主管","经理","总裁"}
    for i, v in ipairs(self.priceCfg) do
        if v == num then
            return list[i+1] or "--"
        end
    end
    return "--"
end
return Mgr
