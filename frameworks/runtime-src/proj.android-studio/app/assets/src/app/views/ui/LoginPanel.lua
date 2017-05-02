local Panel = class("LoginPanel", cc.Node)

function Panel:ctor()
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_4.png", {capInsets=cc.rect(50, 50, 1, 2), size=cc.size(760, 420)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25)
        :addTo(self)

    display.newSprite("ui/logo.png")
        :move(display.cx, 1100)
        :addTo(self)

    local lab = cc.Label:createWithSystemFont("账号", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2-60, CC_DESIGN_RESOLUTION.height/2+60)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(500, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(380, 50)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+60)
        :addTo(self)
    self.usrInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+60)
        :addTo(self)
    self.usrInput:setPlaceHolder("")
    self.usrInput:setPlaceHolderColor(cc.c3b(100, 100, 100))
    self.usrInput:setFontSize(40)
    self.usrInput:setTextAreaSize(cc.size(380, 50))
    self.usrInput:setContentSize(cc.size(380, 50))
    self.usrInput:ignoreContentAdaptWithSize(false)
    self.usrInput:setTextHorizontalAlignment(1)
    self.usrInput:setTextVerticalAlignment(1)
    self.usrInput:setMaxLengthEnabled(true)
    self.usrInput:setMaxLength(11)

    local lab = cc.Label:createWithSystemFont("密码", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2-60, CC_DESIGN_RESOLUTION.height/2-30)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(500, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(380, 50)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-30)
        :addTo(self)
    self.pwdInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-30)
        :addTo(self)
    self.pwdInput:setPlaceHolder("")
    self.pwdInput:setPlaceHolderColor(cc.c3b(100, 100, 100))
    self.pwdInput:setFontSize(40)
    self.pwdInput:setTextAreaSize(cc.size(380, 50))
    self.pwdInput:setContentSize(cc.size(380, 50))
    self.pwdInput:ignoreContentAdaptWithSize(false)
    self.pwdInput:setTextHorizontalAlignment(1)
    self.pwdInput:setTextVerticalAlignment(1)
    self.pwdInput:setPasswordEnabled(true)
    self.pwdInput:setPasswordStyleText("*")
    self.pwdInput:setMaxLengthEnabled(true)
    self.pwdInput:setMaxLength(11)

    self.loginBtn = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-140)
        :addTo(self)
    self.loginBtn.txt = display.newSprite("ui/txt_denglu.png")
        :move(154/2, 57/2)
        :addTo(self.loginBtn)
    self.loginBtn:addEvent(function()
        self:login()
    end)

    local usr = cc.UserDefault:getInstance():getStringForKey("usr")
    local pwd = cc.UserDefault:getInstance():getStringForKey("pwd")
    if usr and pwd and usr ~= "" and pwd ~= "" then
        self.usrInput:setString(usr)
        self.pwdInput:setString(pwd)
    end

    self:enableNodeEvents()
end

function Panel:onEnter ()
    self.id = EventMgr:addEventListener(USR_INFO, function(e)
        UIMgr:hide("LoginPanel")
    end)
end

function Panel:onExit ()
    EventMgr:removeEventListener(self.id)
end

function Panel:login ()
    local usr = self.usrInput:getString()
    local pwd = self.pwdInput:getString()
    if not usr or usr == "" then
        UIMgr:warn("请输入手机号")
        return
    end
    if not tonumber(usr) then
        UIMgr:warn("手机号不正确")
        return
    end
    if not pwd or pwd == "" then
        UIMgr:warn("请输入密码")
        return
    end
    cc.UserDefault:getInstance():setStringForKey("usr", usr)
    cc.UserDefault:getInstance():setStringForKey("pwd", pwd)
    NetMgr:login(usr, pwd)
end

return Panel
