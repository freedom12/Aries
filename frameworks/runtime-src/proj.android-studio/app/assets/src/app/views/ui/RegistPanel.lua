local Panel = class("RegistPanel", cc.Node)

function Panel:ctor()
    self.data = nil
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    display.newSprite("ui/txt_yaoqinghaoyou.png")
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
        :move(CC_DESIGN_RESOLUTION.width/2-285, CC_DESIGN_RESOLUTION.height/2+160)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(370, 40)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160)
        :addTo(self)
    self.nameInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160)
        :addTo(self)
    self.nameInput:setFontSize(35)
    self.nameInput:setPlaceHolder("")
    self.nameInput:setTextAreaSize(cc.size(370, 40))
    self.nameInput:setContentSize(cc.size(370, 40))
    self.nameInput:ignoreContentAdaptWithSize(false)
    self.nameInput:setTextHorizontalAlignment(1)
    self.nameInput:setTextVerticalAlignment(1)

    local lab = cc.Label:createWithSystemFont("手机号", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-285, CC_DESIGN_RESOLUTION.height/2+160-d)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(370, 40)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d)
        :addTo(self)
    self.telInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d)
        :addTo(self)
    self.telInput:setFontSize(35)
    self.telInput:setPlaceHolder("")
    self.telInput:setTextAreaSize(cc.size(370, 40))
    self.telInput:setContentSize(cc.size(370, 40))
    self.telInput:ignoreContentAdaptWithSize(false)
    self.telInput:setTextHorizontalAlignment(1)
    self.telInput:setTextVerticalAlignment(1)

    local lab = cc.Label:createWithSystemFont("密码", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-285, CC_DESIGN_RESOLUTION.height/2+160-d*2)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(370, 40)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*2)
        :addTo(self)
    self.pwdInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*2)
        :addTo(self)
    self.pwdInput:setFontSize(35)
    self.pwdInput:setPlaceHolder("")
    self.pwdInput:setTextAreaSize(cc.size(370, 40))
    self.pwdInput:setContentSize(cc.size(370, 40))
    self.pwdInput:ignoreContentAdaptWithSize(false)
    self.pwdInput:setTextHorizontalAlignment(1)
    self.pwdInput:setTextVerticalAlignment(1)
    self.pwdInput:setPasswordEnabled(true)
    self.pwdInput:setPasswordStyleText("*")

    local lab = cc.Label:createWithSystemFont("确认密码", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-285, CC_DESIGN_RESOLUTION.height/2+160-d*3)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(370, 40)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*3)
        :addTo(self)
    self.pwdInput2 = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*3)
        :addTo(self)
    self.pwdInput2:setFontSize(35)
    self.pwdInput2:setPlaceHolder("")
    self.pwdInput2:setTextAreaSize(cc.size(370, 40))
    self.pwdInput2:setContentSize(cc.size(370, 40))
    self.pwdInput2:ignoreContentAdaptWithSize(false)
    self.pwdInput2:setTextHorizontalAlignment(1)
    self.pwdInput2:setTextVerticalAlignment(1)
    self.pwdInput2:setPasswordEnabled(true)
    self.pwdInput2:setPasswordStyleText("*")

    local lab = cc.Label:createWithSystemFont("微信", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-285, CC_DESIGN_RESOLUTION.height/2+160-d*4)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(370, 40)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*4)
        :addTo(self)
    self.wechatInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*4)
        :addTo(self)
    self.wechatInput:setFontSize(35)
    self.wechatInput:setPlaceHolder("")
    self.wechatInput:setTextAreaSize(cc.size(370, 40))
    self.wechatInput:setContentSize(cc.size(370, 40))
    self.wechatInput:ignoreContentAdaptWithSize(false)
    self.wechatInput:setTextHorizontalAlignment(1)
    self.wechatInput:setTextVerticalAlignment(1)

    local lab = cc.Label:createWithSystemFont("支付宝", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2-285, CC_DESIGN_RESOLUTION.height/2+160-d*5)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(370, 40)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*5)
        :addTo(self)
    self.alipayInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*5)
        :addTo(self)
    self.alipayInput:setFontSize(35)
    self.alipayInput:setPlaceHolder("")
    self.alipayInput:setTextAreaSize(cc.size(370, 40))
    self.alipayInput:setContentSize(cc.size(370, 40))
    self.alipayInput:ignoreContentAdaptWithSize(false)
    self.alipayInput:setTextHorizontalAlignment(1)
    self.alipayInput:setTextVerticalAlignment(1)

    self.registBtn = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*6-15)
        :addTo(self)
    self.registBtn:setTitleText("邀请")
    self.registBtn:setTitleFontSize(30)
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
    local name = self.nameInput:getString()
    if not name or name == "" then
        UIMgr:warn("请输入受邀人姓名")
        return
    end

    local tel = self.telInput:getString()
    if not tel or tel == "" then
        UIMgr:warn("请输入手机号")
        return
    end

    local pwd = self.pwdInput:getString()
    if not pwd or pwd == "" then
        UIMgr:warn("请输入密码")
        return
    end

    local pwd2 = self.pwdInput2:getString()
    if pwd2 ~= pwd then
        UIMgr:warn("确认密码不正确")
        return
    end

    local wechat = self.wechatInput:getString()
    if not wechat or wechat == "" then
        UIMgr:warn("请输入微信账号")
        return
    end

    local alipay = self.alipayInput:getString()
    if not alipay or alipay == "" then
        UIMgr:warn("请输入支付宝账号")
        return
    end

    NetMgr:regist(name, tel, pwd, wechat, alipay)
end

return Panel
