local Panel = class("InputPanel", cc.Node)

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
        UIMgr:hide("InputPanel")
    end)

    self.yesBtn = ccui.Button:create("ui/btn_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-140)
        :addTo(self)
    self.yesBtn.txt = display.newSprite("ui/txt_queding.png")
        :move(209/2, 72/2)
        :addTo(self.yesBtn)
    self.yesBtn:addEvent(function()
        UIMgr:hide("InputPanel")
    end)

    self.input = ccui.EditBox:create(cc.size(600, 50), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+70)
        :addTo(self)
    self.input:setFont("Arial", 40)
    self.input:setPlaceHolder(str or "")
    self.input:setTextHorizontalAlignment(1)
    self.input:setMaxLength(11)
    self.input:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    self.input:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
end

function Panel:setPwd ()
    self.input:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
end

function Panel:getStr ()
    return self.input:getText()
end

function Panel:setYesHandler (handler)
    self.yesBtn:addEvent(function()
        handler()
    end)
end

function Panel:setCloseHandler (handler)
    self.closeBtn:addEvent(function()
        UIMgr:hide("InputPanel")
    end)
end

return Panel
