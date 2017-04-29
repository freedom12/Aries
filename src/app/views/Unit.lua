local Unit = class("Unit", cc.Node)

function Unit:ctor(index)
    self.index = index
    self.data = nil
    self.state = 0
    self.view = ccui.Button:create("unit_1_1.png")
        :addTo(self)
    self.view:loadTextureDisabled("unit_1_1.png")

    self.img = display.newSprite("img_unit_1.png")
        :move(50, 65)
        :addTo(self)
    self.img:setVisible(false)

    self.icon = display.newSprite("icon.png")
        :move(45, 160)
        :addTo(self)
    self.icon:setVisible(false)
    local time = 0.5
    local act1 = cc.MoveBy:create(time, cc.p(0, 30))
    local act2 = cc.FadeOut:create(time)
    local act3 = cc.Spawn:create(act1, act2)
    local act4 = cc.CallFunc:create(function()
        self.icon:setPosition(45, 160)
        self.icon:setOpacity(255)
    end)
    local act5 = cc.Sequence:create(act3, act4)
    self.icon:runAction(cc.RepeatForever:create(act5))
end

function Unit:setData (data)
    if not data then
        return
    end
    self.data = data
    self.img:setVisible(self.data.isOpen)
    self.icon:setVisible(self.data.isOpen)
    self.img:setTexture("img_unit_"..DataMgr:getUnitIndex(self.data.lockValue)..".png")
end

function Unit:setEnabled (bool)
    self.view:setEnabled(bool)
end

function Unit:setSelectHandler (handler)
    handler = handler or function()  end
    self.view:addEvent(function()
        handler()
    end)
end

function Unit:setState (state)
    self.view:loadTextureNormal("unit_1_"..state..".png")
    self.state = state
end

return Unit
