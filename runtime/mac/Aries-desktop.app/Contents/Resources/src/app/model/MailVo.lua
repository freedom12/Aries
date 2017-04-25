local Vo = class("MailVo")

function Vo:ctor(data)
    dump(data)
    data = data or {}
    self.id = data.id
    self.data = data.gDate
    self.content = data.gMailContent
    self.from = data.gMailFrom
    self.to = data.gMailTo
    self.state = data.gState
    self.transferNo = data.gTransferNo
end

return Vo
