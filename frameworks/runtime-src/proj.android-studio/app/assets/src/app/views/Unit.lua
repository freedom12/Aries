local Unit = class("Unit", cc.Node)

function Unit:ctor(index)
    self.index = index
    self.data = nil
    self.state = 0
    self.view = ccui.Button:create("unit_1_1.png")
        :addTo(self)
    self.view:loadTextureDisabled("unit_1_0.png")

    self.img = display.newSprite("img_unit_1.png")
        :move(50, 65)
        :addTo(self)
    self.img:setVisible(false)
end

function Unit:setData (data)
    if not data then
        return
    end
    self.data = data
    self.img:setVisible(self.data.isOpen)
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
