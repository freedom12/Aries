local Panel = class("WarehousePanel", cc.Node)

function Panel:ctor()
    self.index = 0
    self.subPanel = nil
    self.subPanelList = {
        require ("app.views.ui.ExchangePanel"),
        require ("app.views.ui.WarehouseSubPanel2"),
    }
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_3.png", {capInsets=cc.rect(35, 32, 1, 2), size=cc.size(750, 390)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_item_1.png", {capInsets=cc.rect(66, 66, 1, 1), size=cc.size(750, 340)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    display.newSprite("ui/txt_caiwuchu.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1055)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("WarehousePanel")
    end)

    self.tabList = {}
    self.tabList[1] = ccui.Button:create("ui/btn_tab_1.png")
        :move(CC_DESIGN_RESOLUTION.width/2-275, CC_DESIGN_RESOLUTION.height/2-25+193)
        :addTo(self)
    self.tabList[1]:setTitleText("仓库")
    self.tabList[1]:setTitleFontSize(30)
    self.tabList[1]:setTitleColor(display.COLOR_TXT)
    self.tabList[1]:addEvent(function() self:select(1) end)
    self.tabList[2] = ccui.Button:create("ui/btn_tab_1.png")
        :move(CC_DESIGN_RESOLUTION.width/2-275+175, CC_DESIGN_RESOLUTION.height/2-25+193)
        :addTo(self)
    self.tabList[2]:setTitleText("产值记录")
    self.tabList[2]:setTitleFontSize(30)
    self.tabList[2]:setTitleColor(display.COLOR_TXT)
    self.tabList[2]:addEvent(function() self:select(2) end)
    -- self.tabList[3] = ccui.Button:create("ui/btn_tab_1.png")
    --     :move(CC_DESIGN_RESOLUTION.width/2-275+350, CC_DESIGN_RESOLUTION.height/2-25+193)
    --     :addTo(self)
    -- self.tabList[3]:setTitleText("收贡记录")
    -- self.tabList[3]:setTitleFontSize(30)
    -- self.tabList[3]:setTitleColor(display.COLOR_TXT)
    -- self.tabList[3]:addEvent(function() self:select(3) end)

    self:select(1)
end

function Panel:select (index)
    if self.index == index then
        return
    end
    self.index = index
    for i, v in ipairs(self.tabList) do
        v:loadTextureNormal("ui/btn_tab_2.png")
    end

    self.tabList[self.index]:loadTextureNormal("ui/btn_tab_1.png")

    if self.subPanel then
        self.subPanel:removeFromParent()
    end
    self.subPanel = self.subPanelList[self.index].new()
    self:addChild(self.subPanel)
end

return Panel
