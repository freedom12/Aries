local Widget = class("MailWidget", cc.Node)

function Widget:ctor(data)
    self.data = data
    self.bg = display.newSprite("ui/bg_item_1.png", {capInsets=cc.rect(66, 66, 1, 1), size=cc.size(690, 135)})
        :addTo(self)

    self.img = display.newSprite("ui/img_mail.png")
        :move(-275, 0)
        :addTo(self)

    self.titleLab = cc.Label:createWithSystemFont("主题：--", "Arial", 35)
        :move(-15, 25)
        :addTo(self)
    self.titleLab:setColor(display.COLOR_TXT)
    self.titleLab:setAlignment(0, 1)
    self.titleLab:setDimensions(400, 35)

    self.senderLab = cc.Label:createWithSystemFont("发件人：--", "Arial", 35)
        :move(-15, -25)
        :addTo(self)
    self.senderLab:setColor(display.COLOR_TXT)
    self.senderLab:setAlignment(0, 1)
    self.senderLab:setDimensions(400, 35)

    -- self.btn = ccui.Button:create("ui/icon_search.png")
    --     :addTo(self)
    -- self.btn:setOpacity(0)
    -- self.btn:setScale9Enabled(true)
    -- self.btn:setCapInsets(cc.rect(15, 15, 1, 2))
    -- self.btn:setContentSize(cc.size(690, 135))

    self.btn = ccui.Button:create("ui/btn_4.png")
        :move(235, 0)
        :addTo(self)
    self.btn:setTitleText("查看")
    self.btn:setTitleFontSize(30)

    self:setData(self.data)
end

function Widget:setData (data)
    if not data then
        return
    end
    self.data = data

    local type = ""
    if self.data.type == 1 then
        type = "系统通知"
    else
        type = "转账信息"
    end

    if self.data.state == 1 or self.data.state == 3 then
        local glProgramState = cc.GLProgramState:getOrCreateWithGLProgramName("ShaderUIGrayScale")
        self.bg:setGLProgramState(glProgramState)
        self.img:setGLProgramState(glProgramState)
    end
    self.titleLab:setString("主题：" .. type)
    self.senderLab:setString("发件人：" .. self.data.from)
    self.btn:addEvent(function() self:show() end)
end

function Widget:show ()
    local date = string.split(self.data.date, " ")[1]
    local str = self.data.content .. "\n\n                                       "..date
    local panel = UIMgr:show("ConfirmPanel", str)
    panel.lab:setAlignment(0, 1)
    dump(self.data)
    local id = self.data.id
    local type = self.data.transType
    local transferNo = self.data.transferNo
    local state = self.data.state
    if state == 0 then
        NetMgr:readMail(id)
    end
    panel:setNoHandler(function()
        -- NetMgr:delMail(id)
        UIMgr:hide("ConfirmPanel")
    end)

    if type == 1 or type == 2 then
        panel.yesBtn.txt:setVisible(false)
        panel.yesBtn:setTitleText("确认")
        panel.yesBtn:setTitleFontSize(30)
        panel.noBtn.txt:setVisible(false)
        panel.noBtn:setTitleText("取消")
        panel.noBtn:setTitleFontSize(30)
        panel:setYesHandler(function()
            UIMgr:hide("ConfirmPanel")
            if type == 1 then
                NetMgr:transferEnsure1(transferNo)
            elseif type == 2 then
                NetMgr:transferEnsure2(transferNo)
            end
            NetMgr:ensureMail(id)
        end)
        if state == 3 then
            panel.yesBtn:setEnabled(false)
        end
    else
        panel.yesBtn:setVisible(false)
        panel.noBtn:setPositionX(CC_DESIGN_RESOLUTION.width/2)
    end
end

return Widget
