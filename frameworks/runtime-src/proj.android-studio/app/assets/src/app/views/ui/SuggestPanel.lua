local Panel = class("SuggestPanel", cc.Node)

function Panel:ctor(str)
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_4.png", {capInsets=cc.rect(35, 32, 1, 2), size=cc.size(760, 450)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-10)
        :addTo(self)

    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(710, 340)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+20)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    display.newSprite("ui/txt_liuyan.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1055)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("SuggestPanel")
    end)

    self.sendBtn = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-190)
        :addTo(self)
    self.sendBtn.txt = display.newSprite("ui/txt_queding.png")
        :move(154/2, 57/2)
        :addTo(self.sendBtn)
    self.sendBtn:addEvent(function()
        self:send()
    end)

    self.input = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+20)
        :addTo(self)
    self.input:setMaxLengthEnabled(true)
    self.input:setMaxLength(300)
    self.input:setPlaceHolder("请输入留言信息")
    self.input:setPlaceHolderColor(display.COLOR_TXT_2)
    self.input:setFontSize(30)
    -- self.input:setAlignment(0, 0)
    self.input:setTextAreaSize(cc.size(690, 320))
    self.input:setContentSize(cc.size(690, 320))
    self.input:ignoreContentAdaptWithSize(false)
    self.input:setTextHorizontalAlignment(1)
    self.input:setTextVerticalAlignment(1)
    self.input:setColor(display.COLOR_TXT_2)

    self:enableNodeEvents()
end

function Panel:onEnter ()
    self.id = EventMgr:addEventListener(SEND_SUGGEST, function(e)
        UIMgr:hide("SuggestPanel")
    end)
end

function Panel:onExit ()
    EventMgr:removeEventListener(self.id)
end

function Panel:send ()
    local str = self.input:getString()
    str = string.trim(str or "")
    if not str or str == "" then
        UIMgr:warn("请输入留言内容")
        return
    end
    NetMgr:sendSuggest(str)
end


return Panel
