local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local Unit = require "app.views.Unit"
local AutoUnit = require "app.views.AutoUnit"
local UnitWidget = require "app.views.ui.UnitWidget"
MAX_COL = 5
MAX_ROW = 4

NORMAL_STATE = 0
TAKE_STATE = 1

function MainScene:onCreate()
    AudioEngine.playMusic("audio/bgm.mp3", true)
    AudioEngine.setMusicVolume(cc.UserDefault:getInstance():getIntegerForKey("music")/100)
    AudioEngine.setEffectsVolume(cc.UserDefault:getInstance():getIntegerForKey("sound")/100)

    self.state = NORMAL_STATE
    self.companyData = nil
    EventMgr:init(self)
    UIMgr:init(self)

    self.panel = UIMgr:show("MainPanel", nil, false)

    self:initBg()
    self:setData()

    self:enableNodeEvents()
end

function MainScene:onEnter ()
    self.eventList = {}
    self.eventList[1] = EventMgr:addEventListener(LOGOUT, function(e)
        app:enterScene("LoginScene")
    end)
    self.eventList[2] = EventMgr:addEventListener(UPDATE_INFO, function(e)
        if self.companyData.tel == DataMgr:getCompany().tel then
            self.companyData = DataMgr:getCompany()
        end
        self:updateUnit()
    end)
    self.eventList[3] = EventMgr:addEventListener(COMPANY_INFO, function(e)
        self.companyData = e.data
        self:updateUnit()
    end)
end

function MainScene:onExit ()
    for i, v in ipairs(self.eventList) do
        EventMgr:removeEventListener(v)
    end
end

function MainScene:initBg ()
    self.bg = display.newSprite("bg.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self.root)

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(function(touch, event)
        self.state = NORMAL_STATE
        self:updateUnit()
        self:hideUnitWidget()
        return true
    end, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(function(touch, event)
        local p = touch:getDelta()
        local x, y = self.bg:getPosition()
        local size = self.bg:getContentSize()
        local dy = (CC_DESIGN_RESOLUTION.height-display.height)/2
    end, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(function(touch, event)
        return true
    end, cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self.bg:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self.bg)
end

function MainScene:setData ()
    if not DataMgr:isLogin() then
        app:enterScene("LoginScene")
        return
    end

    self.companyData = DataMgr:getCompany()
    self.unitLayer = cc.Node:create()
    self.bg:addChild(self.unitLayer)

    self.unitList = {}
    for i = 1, MAX_ROW do
        for j = 1, MAX_COL do
            local index = #self.unitList+1
            local unit = Unit.new(index)
            unit:setPosition(1000+(j-1)*150-(i-1)*150, 900-(j-1)*75-(i-1)*75)
            self.unitLayer:addChild(unit)
            table.insert(self.unitList, unit)
        end
    end

    self.autoUnit = AutoUnit.new()
    self.unitLayer:addChild(self.autoUnit)
    self.autoUnit:setPosition(500, 250)

    self:updateUnit()
end

function MainScene:updateUnit()
    if not self.companyData then
        return
    end

    if self.companyData.tel == DataMgr:getCompany().tel then
        self.panel:setState(1)
        self.panel:setTakeBtnVisible(true)
        self.panel:setTakeHandler(function() self:takeHandler() end)
        for i, v in ipairs(self.unitList) do
            local data = self.companyData.unitList[i]
            v:setData(data)

            if self.state == NORMAL_STATE then
                v:setState(1)
                if data and data.isOpen then
                    v:setSelectHandler(function() self:showUnitWidget(i) end)
                else
                    v:setSelectHandler(function() self:showChooseJobPanel(i) end)
                end
            elseif self.state == TAKE_STATE then
                if data and data.isOpen then
                    v:setState(1)
                    v:setSelectHandler(function() NetMgr:take(i) end)
                else
                    v:setState(0)
                    v:setSelectHandler(function() end)
                end
            end
        end
    else
        self:hideUnitWidget()
        self.panel:setState(2)
        self.panel:setTakeBtnVisible(not self.companyData.isGetParent)
        self.panel:setTakeHandler(function() NetMgr:steal(self.companyData.tel) end)
        for i, v in ipairs(self.unitList) do
            local data = self.companyData.unitList[i]
            v:setData(data)
            v:setState(1)
            v:setSelectHandler(function() end)
        end
    end
end

function MainScene:showUnitWidget (index)
    self:hideUnitWidget()
    local unit = self.unitList[index]
    local x, y = unit:getPosition()

    self.unitWidget = UnitWidget.new(index)
    self.unitWidget:setPosition(x+50, y+100)
    self.unitLayer:addChild(self.unitWidget, 100)

    unit:setState(2)
end

function MainScene:hideUnitWidget ()
    if self.unitWidget then
        self.unitWidget:removeFromParent()
        self.unitWidget = nil
    end
end

function MainScene:showChooseJobPanel (index)
    self:hideUnitWidget()
    for i, v in ipairs(self.unitList) do
        v:setState(1)
    end
    local panel = UIMgr:show("ChooseJobPanel", index)
    panel:setCloseHandler(function()
        self:hideChoosJobPanel()
    end)
    local unit = self.unitList[index]
    unit:setState(2)
end

function MainScene:hideChoosJobPanel ()
    UIMgr:hide("ChooseJobPanel")
    self:updateUnit()
end

function MainScene:takeHandler ()
    self.state = TAKE_STATE
    self:updateUnit()
end

return MainScene

-- 2.文本输入
-- 3.自适应
