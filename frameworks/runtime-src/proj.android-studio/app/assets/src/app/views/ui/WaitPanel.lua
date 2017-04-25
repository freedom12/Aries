local Panel = class("LoginPanel", cc.Node)

function Panel:ctor()
    self.img = display.newSprite("ui/img_waiting.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    local act = cc.RotateBy:create(0.5, 360)
    self.img:runAction(cc.RepeatForever:create(act))
end

return Panel
