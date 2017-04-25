local Panel = class("LoginPanel", cc.Node)

function Panel:ctor()
    display.newSprite("ui/logo.png")
        :move(display.cx, 1100)
        :addTo(self)

    display.newSprite("ui/bg_txt_1.png", {capInsets=cc.rect(25, 25, 2, 2), size=cc.size(600, 80)})
        :move(display.cx, 700)
        :addTo(self)
    display.newSprite("ui/bg_txt_1.png", {capInsets=cc.rect(25, 25, 2, 2), size=cc.size(600, 80)})
        :move(display.cx, 550)
        :addTo(self)

    self.loginBtn = ccui.Button:create("ui/btn_1.png")
        :move(display.cx, 350)
        :addTo(self)
    self.loginBtn:setScale9Enabled(true)
    self.loginBtn:setCapInsets(cc.rect(180, 60, 1, 2))
    self.loginBtn:setContentSize(cc.size(400,150))
    self.loginBtn:setTitleText("登陆")
    self.loginBtn:setTitleFontSize(60)
    self.loginBtn:addEvent(function()
        self:login()
    end)

    self.usrInput = ccui.TextField:create()
        :move(display.cx, 700)
        :addTo(self)
    -- self.usrInput:setMaxLengthEnabled(true)
    -- self.usrInput:setMaxLength(6)
    self.usrInput:setPlaceHolder("请输入用户名")
    self.usrInput:setPlaceHolderColor(cc.c3b(100, 100, 100))
    self.usrInput:setFontSize(40)
    self.usrInput:setTextAreaSize(cc.size(600, 80))
    self.usrInput:setContentSize(cc.size(600, 80))
    self.usrInput:ignoreContentAdaptWithSize(false)
    self.usrInput:setTextHorizontalAlignment(1)
    self.usrInput:setTextVerticalAlignment(1)

    self.pwdInput = ccui.TextField:create()
        :move(display.cx, 550)
        :addTo(self)
    -- self.pwdInput:setMaxLengthEnabled(true)
    -- self.pwdInput:setMaxLength(6)
    self.pwdInput:setPasswordEnabled(true)
    self.pwdInput:setPasswordStyleText("*")
    self.pwdInput:setPlaceHolder("请输入密码")
    self.pwdInput:setPlaceHolderColor(cc.c3b(100, 100, 100))
    self.pwdInput:setFontSize(40)
    self.pwdInput:setTextAreaSize(cc.size(600, 80))
    self.pwdInput:setContentSize(cc.size(600, 80))
    self.pwdInput:ignoreContentAdaptWithSize(false)
    self.pwdInput:setTextHorizontalAlignment(1)
    self.pwdInput:setTextVerticalAlignment(1)

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
        UIMgr:warn("请输入用户名")
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
