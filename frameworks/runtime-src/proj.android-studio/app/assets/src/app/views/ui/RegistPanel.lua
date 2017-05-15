local Panel = class("RegistPanel", cc.Node)

function Panel:ctor()
    self.data = nil
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_4.png", {capInsets=cc.rect(50, 50, 1, 2), size=cc.size(760, 370)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+5)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    display.newSprite("ui/txt_yaoqinghaoyou2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1055)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("RegistPanel")
    end)

    local d = 60

    local lab = cc.Label:createWithSystemFont("受邀人姓名", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-275, CC_DESIGN_RESOLUTION.height/2+160)
        :addTo(self)
    lab:setAlignment(2, 1)
    lab:setDimensions(175, 40)
    lab:setColor(display.COLOR_TXT)
    self.nameInput = ccui.EditBox:create(cc.size(370, 40), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160)
        :addTo(self)
    self.nameInput:setFont("Arial", 35)
    self.nameInput:setTextHorizontalAlignment(1)
    self.nameInput:setMaxLength(11)
    self.nameInput:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    local lab = cc.Label:createWithSystemFont("只能输入文字和字母", "Arial", 20)
        :move(CC_DESIGN_RESOLUTION.width/2+290, CC_DESIGN_RESOLUTION.height/2+160)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)

    local lab = cc.Label:createWithSystemFont("手机号", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-275, CC_DESIGN_RESOLUTION.height/2+160-d)
        :addTo(self)
    lab:setAlignment(2, 1)
    lab:setDimensions(175, 40)
    lab:setColor(display.COLOR_TXT)
    self.telInput = ccui.EditBox:create(cc.size(370, 40), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d)
        :addTo(self)
    self.telInput:setFont("Arial", 35)
    self.telInput:setTextHorizontalAlignment(1)
    self.telInput:setMaxLength(11)
    self.telInput:setInputMode(cc.EDITBOX_INPUT_MODE_PHONENUMBER)
    local lab = cc.Label:createWithSystemFont("只能输入数字", "Arial", 20)
        :move(CC_DESIGN_RESOLUTION.width/2+290, CC_DESIGN_RESOLUTION.height/2+160-d)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)

    local lab = cc.Label:createWithSystemFont("密码", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-275, CC_DESIGN_RESOLUTION.height/2+160-d*2)
        :addTo(self)
    lab:setAlignment(2, 1)
    lab:setDimensions(175, 40)
    lab:setColor(display.COLOR_TXT)
    self.pwdInput = ccui.EditBox:create(cc.size(370, 40), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*2)
        :addTo(self)
    self.pwdInput:setFont("Arial", 35)
    self.pwdInput:setTextHorizontalAlignment(1)
    self.pwdInput:setMaxLength(11)
    self.pwdInput:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    self.pwdInput:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
    local lab = cc.Label:createWithSystemFont("只能输入字母和数字", "Arial", 20)
        :move(CC_DESIGN_RESOLUTION.width/2+290, CC_DESIGN_RESOLUTION.height/2+160-d*2)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)

    local lab = cc.Label:createWithSystemFont("确认密码", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-275, CC_DESIGN_RESOLUTION.height/2+160-d*3)
        :addTo(self)
    lab:setAlignment(2, 1)
    lab:setDimensions(175, 40)
    lab:setColor(display.COLOR_TXT)
    self.pwdInput2 = ccui.EditBox:create(cc.size(370, 40), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*3)
        :addTo(self)
    self.pwdInput2:setFont("Arial", 35)
    self.pwdInput2:setTextHorizontalAlignment(1)
    self.pwdInput2:setMaxLength(11)
    self.pwdInput2:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    self.pwdInput2:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
    local lab = cc.Label:createWithSystemFont("只能输入字母和数字", "Arial", 20)
        :move(CC_DESIGN_RESOLUTION.width/2+290, CC_DESIGN_RESOLUTION.height/2+160-d*3)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)

    local lab = cc.Label:createWithSystemFont("微信", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-275, CC_DESIGN_RESOLUTION.height/2+160-d*4)
        :addTo(self)
    lab:setAlignment(2, 1)
    lab:setDimensions(175, 40)
    lab:setColor(display.COLOR_TXT)
    self.wechatInput = ccui.EditBox:create(cc.size(370, 40), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*4)
        :addTo(self)
    self.wechatInput:setFont("Arial", 35)
    self.wechatInput:setTextHorizontalAlignment(1)
    self.wechatInput:setMaxLength(30)
    self.wechatInput:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    local lab = cc.Label:createWithSystemFont("只能输入字母和数字", "Arial", 20)
        :move(CC_DESIGN_RESOLUTION.width/2+290, CC_DESIGN_RESOLUTION.height/2+160-d*4)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)

    local lab = cc.Label:createWithSystemFont("支付宝", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-275, CC_DESIGN_RESOLUTION.height/2+160-d*5)
        :addTo(self)
    lab:setAlignment(2, 1)
    lab:setDimensions(175, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(370, 40)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*5)
        :addTo(self)
    self.alipayInput = ccui.EditBox:create(cc.size(370, 40), "ui/bg_txt_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*5)
        :addTo(self)
    self.alipayInput:setFont("Arial", 35)
    self.alipayInput:setTextHorizontalAlignment(1)
    self.alipayInput:setMaxLength(30)
    self.alipayInput:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    local lab = cc.Label:createWithSystemFont("只能输入字母和数字", "Arial", 20)
        :move(CC_DESIGN_RESOLUTION.width/2+290, CC_DESIGN_RESOLUTION.height/2+160-d*5)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)

    self.registBtn = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*6-15)
        :addTo(self)
    self.registBtn.txt = display.newSprite("ui/txt_yaoqinghaoyou.png")
        :move(154/2, 57/2)
        :addTo(self.registBtn)
    self.registBtn:addEvent(function()
        self:regist()
    end)

    self:enableNodeEvents()
end

function Panel:onEnter ()
    self.id = EventMgr:addEventListener(REGIST, function(e)
        UIMgr:hide("RegistPanel")
        NetMgr:getFriend()
    end)
end

function Panel:onExit ()
    EventMgr:removeEventListener(self.id)
end

function Panel:regist ()
    local name = self.nameInput:getText()
    if not name or name == "" then
        UIMgr:warn("请输入受邀人姓名")
        return
    end

    local tel = self.telInput:getText()
    if not tel or tel == "" then
        UIMgr:warn("请输入手机号")
        return
    end
    if not tonumber(tel) then
        UIMgr:warn("手机号不正确")
        return
    end

    local pwd = self.pwdInput:getText()
    if not pwd or pwd == "" then
        UIMgr:warn("请输入密码")
        return
    end

    local pwd2 = self.pwdInput2:getText()
    if pwd2 ~= pwd then
        UIMgr:warn("确认密码不正确")
        return
    end

    local wechat = self.wechatInput:getText()
    if not wechat or wechat == "" then
        UIMgr:warn("请输入微信账号")
        return
    end

    local alipay = self.alipayInput:getText()
    if not alipay or alipay == "" then
        UIMgr:warn("请输入支付宝账号")
        return
    end

    NetMgr:regist(name, tel, pwd, wechat, alipay)
end

return Panel
