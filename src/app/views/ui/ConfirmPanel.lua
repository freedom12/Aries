local Panel = class("ConfirmPanel", cc.Node)

function Panel:ctor(str)
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_4.png", {capInsets=cc.rect(35, 32, 1, 2), size=cc.size(760, 465)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("ConfirmPanel")
    end)

    self.yesBtn = ccui.Button:create("ui/btn_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2-125, CC_DESIGN_RESOLUTION.height/2-140)
        :addTo(self)
    self.yesBtn.txt = display.newSprite("ui/txt_queding.png")
        :move(209/2, 72/2)
        :addTo(self.yesBtn)
    self.yesBtn:addEvent(function()
        UIMgr:hide("ConfirmPanel")
    end)

    self.noBtn = ccui.Button:create("ui/btn_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2+125, CC_DESIGN_RESOLUTION.height/2-140)
        :addTo(self)
    self.noBtn.txt = display.newSprite("ui/txt_quxiao.png")
        :move(209/2, 72/2)
        :addTo(self.noBtn)
    self.noBtn:addEvent(function()
        UIMgr:hide("ConfirmPanel")
    end)

    self.lab = cc.Label:createWithSystemFont(str or "", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+70)
        :addTo(self)
    self.lab:setColor(display.COLOR_TXT)
    self.lab:setAlignment(1, 1)
    self.lab:setDimensions(700, 300)
end

function Panel:setYesHandler (handler)
    self.yesBtn:addEvent(function()
        handler()
    end)
end

function Panel:setNoHandler (handler)
    self.noBtn:addEvent(function()
        handler()
    end)
end

function Panel:setCloseHandler (handler)
    self.closeBtn:addEvent(function()
        UIMgr:hide("ConfirmPanel")
    end)
end

return Panel
