local Vo = class("MailVo")

function Vo:ctor(data)
    data = data or {}
    self.id = data.id
    self.date = data.gDate
    self.content = data.gMailContent
    self.from = data.gMailFrom
    self.to = data.gMailTo
    self.state = tonumber(data.gState)
    self.transferNo = data.gTransferNo
    self.type = tonumber(data.gMailType)
    self.transType = tonumber(data.gTransferType)
end

return Vo
