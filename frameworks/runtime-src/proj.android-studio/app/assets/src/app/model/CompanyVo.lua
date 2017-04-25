local Vo = class("CompanyVo")

function Vo:ctor(data)
    data = data or {}
    self.id = data.id or 0
    self.tel = data.gTel or 0
    
    self.gold = data.gJinbi or 0
    self.score = data.gCaiwuchu or 0
    self.guwen = data.gGuwen or 0

    self.isSign = (tonumber(data.gQiandao)==1)
    self.isAuto = (tonumber(data.gQiantai)==1)

    self.income = data.gIncometoday or 0
    self.income1 = data.gIncometoday1 or 0
    self.income2 = data.gIncometoday2 or 0

    self.isGetParent = (tonumber(data.gIsparentget)==1)
    self.isGetGrand = (tonumber(data.gIsgrapaget)==1)

    self.unitList = {}

    if data.gOffice then
        local gOffice = string.split(data.gOffice, ",")
        local gOfficelockvalue = string.split(data.gOfficelockvalue, ",")
        local gOfficevalue = string.split(data.gOfficevalue, ",")
        for i, v in ipairs(gOffice) do
            local t = {}
            t.index = i
            t.isOpen = (tonumber(gOffice[i]) == 1)
            t.value = tonumber(gOfficevalue[i])
            t.lockValue = tonumber(gOfficelockvalue[i])
            local unit = UnitVo.new(t)
            table.insert(self.unitList, unit)
        end
    end
end
return Vo
