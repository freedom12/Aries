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

    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(600, 50)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+70)
        :addTo(self)
    self.input = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+70)
        :addTo(self)
    self.input:setFontSize(40)
    self.input:setPlaceHolder(str or "")
    self.input:setTextAreaSize(cc.size(600, 42))
    self.input:setContentSize(cc.size(600, 42))
    self.input:ignoreContentAdaptWithSize(false)
    self.input:setTextHorizontalAlignment(1)
    self.input:setTextVerticalAlignment(1)
    self.input:setMaxLengthEnabled(true)
    self.input:setMaxLength(11)
end

function Panel:setPwd ()
    self.input:setPasswordEnabled(true)
    self.input:setPasswordStyleText("*")
end

function Panel:getStr ()
    return self.input:getString()
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
