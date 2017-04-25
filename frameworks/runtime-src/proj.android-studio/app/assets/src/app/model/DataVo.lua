local Vo = class("DataVo")

function Vo:ctor()
    self.usr = UsrVo.new()
    self.company = CompanyVo.new()
    self.mailList = {}
end

return Vo
