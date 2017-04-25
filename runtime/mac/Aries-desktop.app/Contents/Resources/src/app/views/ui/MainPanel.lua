local Panel = class("MainPanel", cc.Node)

function Panel:ctor(selectIndex)
    self.selectIndex = selectIndex
    self.takeHandler = function() end
    self.state = 1

    self.bg = display.newSprite("ui/bg_head.png",
        {capInsets=cc.rect(388, 50, 1, 2), size=cc.size(470, 138)})
        :move(280, (CC_DESIGN_RESOLUTION.height+display.height)/2-100)
        :addTo(self)
    self.nameBg = display.newSprite("ui/bg_title_2.png")
        :move(70, 0)
        :addTo(self.bg)
    self.nameLab = cc.Label:createWithSystemFont("--", "Arial", 30)
        :move(70, 10)
        :addTo(self.bg)
    self.nameLab:setColor(display.COLOR_TXT)

    self.goldLab = cc.Label:createWithSystemFont("金币：--", "Arial", 30)
        :move(330, 90)
        :addTo(self.bg)
    self.goldLab:setAlignment(0, 1)
    self.goldLab:setDimensions(350, 30)
    self.goldLab:setColor(display.COLOR_TXT)
    self.scoreLab = cc.Label:createWithSystemFont("产值：--", "Arial", 30)
        :move(330, 45)
        :addTo(self.bg)
    self.scoreLab:setAlignment(0, 1)
    self.scoreLab:setDimensions(350, 30)
    self.scoreLab:setColor(display.COLOR_TXT)

    self.usrInfoBtn = ccui.Button:create("ui/icon_search.png")
        :move(70, 70)
        :addTo(self.bg)
    self.usrInfoBtn:addEvent(function() UIMgr:show("UsrInfoPanel") end)
    self.usrInfoBtn:setOpacity(0)

    self.exchangeBtn = ccui.Button:create("ui/btn_0.png")
        :move(420, 90)
        :addTo(self.bg)
    self.exchangeBtn:addEvent(function() UIMgr:show("ExchangePanel") end)

    self.friendBtn = ccui.Button:create("ui/icon_friend.png")
        :move(120, (CC_DESIGN_RESOLUTION.height+display.height)/2-150-150)
        :addTo(self)
    self.friendBtn:addEvent(function() UIMgr:show("FriendPanel") end)

    self.searchBtn = ccui.Button:create("ui/icon_search.png")
        :move(120, (CC_DESIGN_RESOLUTION.height+display.height)/2-150-150*2)
        :addTo(self)
    self.searchBtn:addEvent(function() UIMgr:show("SearchPanel") end)

    self.warehouseBtn = ccui.Button:create("ui/icon_warehouse.png")
        :move(120, (CC_DESIGN_RESOLUTION.height+display.height)/2-150-150*3)
        :addTo(self)
    self.warehouseBtn:addEvent(function() UIMgr:show("WarehousePanel") end)

    self.settingBtn = ccui.Button:create("ui/icon_setting.png")
        :move(2100-150, (CC_DESIGN_RESOLUTION.height+display.height)/2-100)
        :addTo(self)
    self.settingBtn:addEvent(function() UIMgr:show("SettingPanel") end)

    self.mailBtn = ccui.Button:create("ui/icon_mail.png")
        :move(2100-150*2, (CC_DESIGN_RESOLUTION.height+display.height)/2-100)
        :addTo(self)
    self.mailBtn:addEvent(function() UIMgr:show("MailPanel") end)

    self.suggestBtn = ccui.Button:create("ui/icon_suggest.png")
        :move(2100-150*3, (CC_DESIGN_RESOLUTION.height+display.height)/2-100)
        :addTo(self)
    self.suggestBtn:addEvent(function() UIMgr:show("SuggestPanel") end)

    self.logBtn = ccui.Button:create("ui/icon_log.png")
        :move(2100-150*4, (CC_DESIGN_RESOLUTION.height+display.height)/2-100)
        :addTo(self)
    self.logBtn:addEvent(function() UIMgr:show("LogPanel") end)

    self.takeBtn = ccui.Button:create("ui/btn_close.png")
        :move(2100-150, (CC_DESIGN_RESOLUTION.height-display.height)/2+100)
        :addTo(self)
    self.takeBtn:addEvent(function() self:take() end)

    self.signBtn = ccui.Button:create("ui/icon_sign.png")
        :move(2100-150*2, (CC_DESIGN_RESOLUTION.height-display.height)/2+100)
        :addTo(self)
    self.signBtn:addEvent(function() self:sign() end)

    self:enableNodeEvents()
    self:setData()
end

function Panel:onEnter ()
    self.eventList = {}
    self.eventList[1] = EventMgr:addEventListener(USR_INFO, function(e)
        self:setData()
    end)
    self.eventList[2] = EventMgr:addEventListener(UPDATE_INFO, function(e)
        self:setData()
    end)
end

function Panel:onExit ()
    for i, v in ipairs(self.eventList) do
        EventMgr:removeEventListener(v)
    end
end

function Panel:setData ()
    if not DataMgr:isLogin() then
        return
    end
    local data = DataMgr.data
    local usrData = data.usr

    self.nameLab:setString(usrData.name)

    local companyData = data.company
    if not companyData then
        return
    end

    self.goldLab:setString("金币："..companyData.gold)
    self.scoreLab:setString("产值："..companyData.score)

    self.signBtn:setVisible(not companyData.isSign)
end

function Panel:take ()
    self.takeHandler()
end

function Panel:sign ()
    NetMgr:sign()
end

function Panel:setTakeHandler (handler)
    self.takeHandler = handler or function() end
end

function Panel:setTakeBtnVisible (bool)
    self.takeBtn:setVisible(bool)
end

function Panel:setState (state)
    self.state = state
    if self.state == 1 then
        self:setData()
        self.signBtn:addEvent(function() self:sign() end)
    else
        self.signBtn:setVisible(true)
        self.signBtn:addEvent(function() NetMgr:getCompanyInfo(DataMgr.data.usr.tel) end)
    end
end

return Panel
