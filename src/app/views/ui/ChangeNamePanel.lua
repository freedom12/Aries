local Panel = class("ChangeNamePanel", cc.Node)

function Panel:ctor(str)
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_4.png", {capInsets=cc.rect(50, 50, 1, 2), size=cc.size(760, 420)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    display.newSprite("ui/txt_xiugaimingzi.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1055)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("ChangeNamePanel")
    end)

    self.yesBtn = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-180)
        :addTo(self)
    self.yesBtn.txt = display.newSprite("ui/txt_querenxiugai.png")
        :move(154/2, 57/2)
        :addTo(self.yesBtn)
    self.yesBtn:addEvent(function()
        self:changeName()
    end)

    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(380, 50)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    self.usrInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)
    self.usrInput:setPlaceHolder("请输入新名字")
    self.usrInput:setPlaceHolderColor(cc.c3b(100, 100, 100))
    self.usrInput:setFontSize(35)
    self.usrInput:setTextAreaSize(cc.size(380, 42))
    self.usrInput:setContentSize(cc.size(380, 42))
    self.usrInput:ignoreContentAdaptWithSize(false)
    self.usrInput:setTextHorizontalAlignment(1)
    self.usrInput:setTextVerticalAlignment(1)
    self.usrInput:setMaxLengthEnabled(true)
    self.usrInput:setMaxLength(11)
end

function Panel:changeName ()
    local str = self.usrInput:getString()
    if not str or str == "" then
        UIMgr:warn("请输入姓名")
        return
    end

    NetMgr:changeName(str)
    UIMgr:hide("ChangeNamePanel")
end

return Panel
