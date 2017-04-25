local Widget = class("ItemWidget", cc.Node)

function Widget:ctor(data)
    --201*290
    self.data = data
    self.bg = display.newSprite("ui/bg_item_2.png")
        :addTo(self)

    self.img = display.newSprite("ui/img_item_1.png")
        :move(0, 20)
        :addTo(self)

    self.numLab = cc.Label:createWithSystemFont("0.00", "Arial", 25)
        :move(0, 115)
        :addTo(self)
    self.numLab:setColor(display.COLOR_TXT)

    self.sellBtn = ccui.Button:create("ui/btn_4.png")
        :move(0, -95)
        :addTo(self)
    self.sellBtn.txt = display.newSprite("ui/txt_chushou.png")
        :move(154/2, 57/2)
        :addTo(self.sellBtn)
    self.sellBtn:addEvent(function()
        self:sell()
    end)

    self:setData(self.data)
end

function Widget:setData (data)
    if not data then
        return
    end
    self.data = data
end

function Widget:sell ()
    -- body...
end

return Widget
