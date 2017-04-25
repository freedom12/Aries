local Widget = class("MailWidget", cc.Node)

function Widget:ctor(data)
    self.data = data
    self.bg = display.newSprite("ui/bg_item_1.png", {capInsets=cc.rect(66, 66, 1, 1), size=cc.size(690, 135)})
        :addTo(self)

    self.img = display.newSprite("ui/img_mail.png")
        :move(-275, 0)
        :addTo(self)

    self.titleLab = cc.Label:createWithSystemFont("主题：--", "Arial", 35)
        :move(0, 25)
        :addTo(self)
    self.titleLab:setColor(display.COLOR_TXT)
    self.titleLab:setAlignment(0, 1)
    self.titleLab:setDimensions(400, 35)

    self.senderLab = cc.Label:createWithSystemFont("发件人：--", "Arial", 35)
        :move(0, -25)
        :addTo(self)
    self.senderLab:setColor(display.COLOR_TXT)
    self.senderLab:setAlignment(0, 1)
    self.senderLab:setDimensions(400, 35)

    self:setData(self.data)
end

function Widget:setData (data)
    if not data then
        return
    end
    self.data = data

    local type = ""
    if self.data.type == 1 then
        type = "系统通知"
    else
        type = "转账信息"
    end
    self.titleLab:setString("主题：" .. type)
    self.senderLab:setString("发件人：" .. self.data.from)
end

return Widget
