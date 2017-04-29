local Widget = class("FriendWidget", cc.Node)

function Widget:ctor(data)
    self.data = data
    self.bg = display.newSprite("ui/bg_item_1.png", {capInsets=cc.rect(66, 66, 1, 1), size=cc.size(690, 135)})
        :addTo(self)

    self.nameLab = cc.Label:createWithSystemFont("", "Arial", 35)
        :move(-100, 25)
        :addTo(self)
    self.nameLab:setColor(display.COLOR_TXT)
    self.nameLab:setAlignment(0, 1)
    self.nameLab:setDimensions(400, 35)

    self.telLab = cc.Label:createWithSystemFont("", "Arial", 35)
        :move(-100, -25)
        :addTo(self)
    self.telLab:setColor(display.COLOR_TXT)
    self.telLab:setAlignment(0, 1)
    self.telLab:setDimensions(400, 35)

    self.btn = ccui.Button:create("ui/btn_4.png")
        :move(220, 0)
        :addTo(self)
    self.btn:setTitleText("前往")
    self.btn:setTitleFontSize(30)

    self:setData(self.data)
end

function Widget:setData (data)
    if not data then
        return
    end
    self.data = data

    self.nameLab:setString("姓名："..self.data.name)
    self.telLab:setString("电话："..self.data.tel)
    self.btn:addEvent(function()
        DataMgr.selectFriendName = self.data.name
        NetMgr:getCompanyInfo(self.data.tel)
        UIMgr:hide("FriendPanel")
    end)
end

return Widget
