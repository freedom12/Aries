local Widget = class("UnitWidget", cc.Node)

function Widget:ctor(index)
    self.index = index
    self.bg = display.newSprite("ui/bg_unit.png")
        :move(-80, 102)
        :addTo(self)

    local size = self.bg:getContentSize()
    self.jobLab = cc.Label:createWithSystemFont("职位：--", "Arial", 30)
        :move(size.width/2, 170)
        :addTo(self.bg)
    self.jobLab:setAlignment(0, 1)
    self.jobLab:setDimensions(260, 30)
    self.jobLab:setColor(display.COLOR_TXT)

    self.rateLab = cc.Label:createWithSystemFont("产值：--", "Arial", 30)
        :move(size.width/2, 170-35)
        :addTo(self.bg)
    self.rateLab:setAlignment(0, 1)
    self.rateLab:setDimensions(260, 30)
    self.rateLab:setColor(display.COLOR_TXT)

    self.nextJobLab = cc.Label:createWithSystemFont("晋升职位：--", "Arial", 30)
        :move(size.width/2, 170-70)
        :addTo(self.bg)
    self.nextJobLab:setAlignment(0, 1)
    self.nextJobLab:setDimensions(260, 30)
    self.nextJobLab:setColor(display.COLOR_TXT)

    self.numLab = cc.Label:createWithSystemFont("0000", "Arial", 20)
        :move(100, 47)
        :addTo(self.bg)
    self.numLab:setColor(display.COLOR_TXT)

    self.upgradeBtn = ccui.Button:create("ui/btn_upgrade.png")
        :move(220, 50)
        :addTo(self.bg)
    self.upgradeBtn:setScale9Enabled(true)
    self.upgradeBtn:addEvent(function()
        self:upgrade()
    end)

    self:setData()
    self:enableNodeEvents()
end

function Widget:onEnter ()
    self.id = EventMgr:addEventListener(UPDATE_INFO, function(e)
        self:setData()
    end)
end

function Widget:onExit ()
    EventMgr:removeEventListener(self.id)
end

function Widget:setData ()
    local data = DataMgr.data.company.unitList[self.index]
    self.rateLab:setString("产值："..(data.value-data.lockValue))
    self.numLab:setString(data.value)
    self.jobLab:setString("职位："..DataMgr:getUnitName(data.lockValue))
    self.nextJobLab:setString("晋升职位："..DataMgr:getNextUnitName(data.lockValue))


    if data.lockValue == DataMgr.priceCfg[#DataMgr.priceCfg] then
        self.upgradeBtn:setVisible(false)
    elseif DataMgr:getUnitIndex(data.lockValue) == DataMgr.openEmployee then
        self.upgradeBtn:setVisible(false)
    end
end

function Widget:upgrade ()
    NetMgr:upgrade(self.index)
end

return Widget
