local Vo = class("UsrVo")

function Vo:ctor(data)
    self.index = data.index
    self.isOpen = data.isOpen
    self.value = data.value
    self.lockValue = data.lockValue
end

return Vo
