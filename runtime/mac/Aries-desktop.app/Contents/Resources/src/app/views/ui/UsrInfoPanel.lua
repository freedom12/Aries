local Panel = class("UsrInfoPanel", cc.Node)

function Panel:ctor()
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    -- display.newSprite("ui/txt_yaoqinghaoyou.png")
    --     :move(CC_DESIGN_RESOLUTION.width/2, 1055)
    --     :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("UsrInfoPanel")
    end)

    local d = 60

    self.nameLab = cc.Label:createWithSystemFont("姓  名：--", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160)
        :addTo(self)
    self.nameLab:setAlignment(0, 1)
    self.nameLab:setDimensions(500, 40)
    self.nameLab:setColor(display.COLOR_TXT)

    self.nameBtn = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2+300, CC_DESIGN_RESOLUTION.height/2+160)
        :addTo(self)
    self.nameBtn:setTitleText("修改")
    self.nameBtn:setTitleFontSize(30)
    self.nameBtn:addEvent(function()
        self:changeName()
    end)

    self.telLab = cc.Label:createWithSystemFont("手机号：--", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d)
        :addTo(self)
    self.telLab:setAlignment(0, 1)
    self.telLab:setDimensions(500, 40)
    self.telLab:setColor(display.COLOR_TXT)

    self.parentLab = cc.Label:createWithSystemFont("邀请人：--", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*2)
        :addTo(self)
    self.parentLab:setAlignment(0, 1)
    self.parentLab:setDimensions(500, 40)
    self.parentLab:setColor(display.COLOR_TXT)

    self.pwdLab = cc.Label:createWithSystemFont("密  码：******", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*3)
        :addTo(self)
    self.pwdLab:setAlignment(0, 1)
    self.pwdLab:setDimensions(500, 40)
    self.pwdLab:setColor(display.COLOR_TXT)

    self.pwdBtn = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2+300, CC_DESIGN_RESOLUTION.height/2+160-d*3)
        :addTo(self)
    self.pwdBtn:setTitleText("修改")
    self.pwdBtn:setTitleFontSize(30)
    self.pwdBtn:addEvent(function()
        self:changePwd()
    end)

    self.wechatLab = cc.Label:createWithSystemFont("微  信：--", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*4)
        :addTo(self)
    self.wechatLab:setAlignment(0, 1)
    self.wechatLab:setDimensions(500, 40)
    self.wechatLab:setColor(display.COLOR_TXT)

    self.alipayLab = cc.Label:createWithSystemFont("支付宝：--", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+160-d*5)
        :addTo(self)
    self.alipayLab:setAlignment(0, 1)
    self.alipayLab:setDimensions(500, 40)
    self.alipayLab:setColor(display.COLOR_TXT)

    self:setData()
    self:enableNodeEvents()
end

function Panel:onEnter ()
    self.id = EventMgr:addEventListener(UPDATE_INFO, function(e)
        self:setData()
    end)
end

function Panel:onExit ()
    EventMgr:removeEventListener(self.id)
end

function Panel:setData ()
    if not DataMgr:isLogin() then
        return
    end
    local data = DataMgr.data
    local usrData = data.usr

    self.nameLab:setString("姓  名：" .. usrData.name)
    self.telLab:setString("手机号：" .. usrData.tel)
    self.wechatLab:setString("微  信：" .. usrData.wechat)
    self.alipayLab:setString("支付宝：" .. usrData.alipay)
end

function Panel:changeName ()
    local panel = UIMgr:show("InputPanel", "请输入姓名")
    panel:setYesHandler(function()
        local str = panel:getStr()
        if not str or str == "" then
            UIMgr:warn("请输入姓名")
            return
        end

        NetMgr:changeName(str)
        UIMgr:hide("ConfirmPanel")
    end)
end

function Panel:changePwd ()
    local panel = UIMgr:show("InputPanel", "请输入密码")
    panel:setPwd()
    panel:setYesHandler(function()
        local str = panel:getStr()
        if not str or str == "" then
            UIMgr:warn("请输入密码")
            return
        end

        NetMgr:changePwd(str)
        UIMgr:hide("ConfirmPanel")
    end)
end

return Panel
