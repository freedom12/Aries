local Panel = class("ChangePwdPanel", cc.Node)

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

    display.newSprite("ui/txt_xiugaimima.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1055)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("ChangePwdPanel")
    end)

    self.yesBtn = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-180)
        :addTo(self)
    self.yesBtn.txt = display.newSprite("ui/txt_querenxiugai.png")
        :move(154/2, 57/2)
        :addTo(self.yesBtn)
    self.yesBtn:addEvent(function()
        self:changePwd()
    end)

    local lab = cc.Label:createWithSystemFont("旧密码：", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2-50, CC_DESIGN_RESOLUTION.height/2+110)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(500, 40)
    lab:setColor(display.COLOR_TXT)
    self.oldInput = ccui.EditBox:create(cc.size(380, 50), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2+130, CC_DESIGN_RESOLUTION.height/2+110)
        :addTo(self)
    self.oldInput:setFont("Arial", 50)
    self.oldInput:setTextHorizontalAlignment(1)
    self.oldInput:setMaxLength(11)
    self.oldInput:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    self.oldInput:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)

    local lab = cc.Label:createWithSystemFont("新密码：", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2-50, CC_DESIGN_RESOLUTION.height/2+10)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(500, 40)
    lab:setColor(display.COLOR_TXT)
    self.newInput = ccui.EditBox:create(cc.size(380, 50), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2+130, CC_DESIGN_RESOLUTION.height/2+10)
        :addTo(self)
    self.newInput:setFont("Arial", 40)
    self.newInput:setTextHorizontalAlignment(1)
    self.newInput:setMaxLength(11)
    self.newInput:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    self.newInput:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)

    local lab = cc.Label:createWithSystemFont("确认密码：", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2-50, CC_DESIGN_RESOLUTION.height/2-90)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(500, 40)
    lab:setColor(display.COLOR_TXT)
    self.newInput2 = ccui.EditBox:create(cc.size(380, 50), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2+130, CC_DESIGN_RESOLUTION.height/2-90)
        :addTo(self)
    self.newInput2:setFont("Arial", 40)
    self.newInput2:setTextHorizontalAlignment(1)
    self.newInput2:setMaxLength(11)
    self.newInput2:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    self.newInput2:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
end

function Panel:changePwd ()
    local old = self.oldInput:getText()
    if not old or old == "" then
        UIMgr:warn("请输入旧密码")
        return
    end
    local new = self.newInput:getText()
    if not new or new == "" then
        UIMgr:warn("请输入新密码")
        return
    end
    local new2 = self.newInput2:getText()
    if not new2 or new ~= new2 then
        UIMgr:warn("确认密码不正确")
        return
    end

    NetMgr:changePwd(old, new)
    UIMgr:hide("ChangePwdPanel")
end

return Panel
