local Panel = class("ChooseJobPanel", cc.Node)
local Widget = require "app.views.ui.ChooseJobWidget"
function Panel:ctor(index)
    self.selectIndex = index
    self.closeHandler = function() end
    self.bg = display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(1070, 320+20)})
        :move(display.cx, 160-10-(display.height - CC_DESIGN_RESOLUTION.height)/2)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(1070, 340)
        :addTo(self.bg)
    self.closeBtn:addEvent(function()
        self:close()
    end)

    local x, y = self.bg:getPosition()
    self.bg:setPosition(x, y-350)
    self.bg:runAction(cc.MoveBy:create(0.2, cc.p(0, 350)))

    self.widgetList = {}
    for i = 1, 5 do
        local widget = Widget.new(self.selectIndex, i)
        widget:setPosition(135+(i-1)*200, 185+20)
        self.bg:addChild(widget)
        table.insert(self.widgetList, widget)

        widget:setOpen(i <= DataMgr.openEmployee)
    end

    self:enableNodeEvents()
end

function Panel:onEnter ()
    self.id = EventMgr:addEventListener(COMPANY_EMPLOYEE, function(e)
        UIMgr:hide("ChooseJobPanel")
    end)
end

function Panel:onExit ()
    EventMgr:removeEventListener(self.id)
end

function Panel:setCloseHandler (handler)
    self.closeHandler = handler or function() end
end

function Panel:close ()
    local act1 = cc.MoveBy:create(0.2, cc.p(0, -350))
    local act2 = cc.CallFunc:create(function()
        self.closeHandler()
    end)
    self.bg:runAction(cc.Sequence:create(act1, act2))
end

return Panel
