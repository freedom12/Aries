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

    local lab = cc.Label:createWithSystemFont("请输入新名字", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+70)
        :addTo(self)
    lab:setColor(display.COLOR_TXT)

    self.usrInput = ccui.EditBox:create(cc.size(380, 50), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)
    self.usrInput:setFont("Arial", 40)
    self.usrInput:setTextHorizontalAlignment(1)
    self.usrInput:setMaxLength(11)
    self.usrInput:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
end

function Panel:changeName ()
    local str = self.usrInput:getText()
    if not str or str == "" then
        UIMgr:warn("请输入姓名")
        return
    end

    NetMgr:changeName(str)
    UIMgr:hide("ChangeNamePanel")
end

return Panel
