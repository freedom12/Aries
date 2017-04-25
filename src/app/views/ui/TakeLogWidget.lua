local Widget = class("TakeLogWidget", cc.Node)

function Widget:ctor(data)
    self.data = data
    self.bg = display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(20, 20, 1, 1), size=cc.size(690, 50)})
        :addTo(self)

    self.dateLab = cc.Label:createWithSystemFont("", "Arial", 35)
        :move(-200, 0)
        :addTo(self)
    self.dateLab:setColor(display.COLOR_TXT)
    -- self.dateLab:setAlignment(0, 1)
    -- self.dateLab:setDimensions(400, 35)

    self.incomeLab = cc.Label:createWithSystemFont("", "Arial", 35)
        :move(0, 0)
        :addTo(self)
    self.incomeLab:setColor(display.COLOR_TXT)
    -- self.incomeLab:setAlignment(0, 1)
    -- self.incomeLab:setDimensions(400, 35)

    self.incomeLab1 = cc.Label:createWithSystemFont("", "Arial", 35)
        :move(100, 0)
        :addTo(self)
    self.incomeLab1:setColor(display.COLOR_TXT)
    -- self.incomeLab1:setAlignment(0, 1)
    -- self.incomeLab1:setDimensions(400, 35)

    self.incomeLab2 = cc.Label:createWithSystemFont("", "Arial", 35)
        :move(200, 0)
        :addTo(self)
    self.incomeLab2:setColor(display.COLOR_TXT)
    -- self.incomeLab2:setAlignment(0, 1)
    -- self.incomeLab2:setDimensions(400, 35)

    self:setData(self.data)
end

function Widget:setData (data)
    if not data then
        return
    end
    self.data = data

    self.dateLab:setString(self.data.gDate)
    self.incomeLab:setString(self.data.gIncometoday)
    self.incomeLab1:setString(self.data.gIncometoday1)
    self.incomeLab2:setString(self.data.gIncometoday2)
end

return Widget
