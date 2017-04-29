local Panel = class("LogPanel", cc.Node)

function Panel:ctor()
    self.index = 0

    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_4.png", {capInsets=cc.rect(50, 50, 1, 2), size=cc.size(760, 420)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("LogPanel")
    end)

    self.tabList = {}
    self.tabList[1] = ccui.Button:create("ui/btn_d_1.png")
        :move(CC_DESIGN_RESOLUTION.width/2-275, CC_DESIGN_RESOLUTION.height/2+220)
        :addTo(self)
    self.tabList[1]:addEvent(function() self:select(1) end)
    self.tabList[2] = ccui.Button:create("ui/btn_m_1.png")
        :move(CC_DESIGN_RESOLUTION.width/2-275+220, CC_DESIGN_RESOLUTION.height/2+220)
        :addTo(self)
    self.tabList[2]:addEvent(function() self:select(2) end)

    -- self.tabList[1]:setVisible(false)
    self.tabList[2]:setVisible(false)

    self.node = cc.Node:create()
    self.node:setPosition(CC_DESIGN_RESOLUTION.width/2-325, CC_DESIGN_RESOLUTION.height/2-175)
    self:addChild(self.node)

    self:select(1)

    self:enableNodeEvents()
end

function Panel:onEnter ()
    self.eventList = {}
    self.eventList[1] = EventMgr:addEventListener(RATE_LOG, function(e)
        self:setData(e.data)
    end)
end

function Panel:onExit ()
    for i, v in ipairs(self.eventList) do
        EventMgr:removeEventListener(v)
    end
end

function Panel:select (index)
    if self.index == index then
        return
    end
    self.index = index

    if self.index == 1 then
        self.tabList[1]:loadTextureNormal("ui/btn_d_2.png")
        self.tabList[2]:loadTextureNormal("ui/btn_m_1.png")
        NetMgr:getRateLog()
    else
        self.tabList[1]:loadTextureNormal("ui/btn_d_1.png")
        self.tabList[2]:loadTextureNormal("ui/btn_m_2.png")
    end
end

function Panel:setData (data)
    if not data then
        return
    end
    self.data = data.result.list
    local max = 0
    for i, v in ipairs(self.data) do
        max = math.max(v.rateDay, max)
    end

    local w, h = 650, 300
    local dw, dh = 90, 50
    local nw, nh = 7, 6

    max = math.max(max, nh)
    max = math.ceil(max/nh)*nh

    local img = display.newSprite("ui/shape_1.png")
        :move(w/2, 0)
        :addTo(self.node)
    img:setLocalZOrder(10)
    img:setScaleX(w/img:getContentSize().width+1)

    local img = display.newSprite("ui/shape_1.png")
        :move(0, h/2)
        :addTo(self.node)
    img:setLocalZOrder(10)
    img:setScaleY(h/img:getContentSize().height+1)

    local lab = cc.Label:createWithSystemFont(0, "Arial", 40)
        :move(-25, -25)
        :addTo(self.node)
    lab:setColor(display.COLOR_TXT)
    lab:setAlignment(1, 1)
    lab:setDimensions(40, 40)
    for i = 1, nh do
        local lab = cc.Label:createWithSystemFont(max/nh*i, "Arial", 30)
            :move(-25, dh*i)
            :addTo(self.node)
        lab:setColor(display.COLOR_TXT)
        lab:setAlignment(1, 1)
        lab:setDimensions(30, 30)
    end

    self.dateLabList = {}
    for i = 1, nw do
        local lab = cc.Label:createWithSystemFont("", "Arial", 25)
            :move(dw*i, -25)
            :addTo(self.node)
        lab:setColor(display.COLOR_TXT)
        lab:setAlignment(1, 1)
        lab:setDimensions(70, 25)
        self.dateLabList[i] = lab
    end

    table.sort(self.data, function(a, b)
        return a.validDate < b.validDate
    end)
    local index = 0
    for i = math.max(#self.data-7, 1), #self.data do
        index = index + 1
        local v = self.data[i]
        local list = string.split(v.validDate, "-")
        self.dateLabList[index]:setString(list[2].."."..list[3])
        local rate = v.rateDay
        local img = display.newSprite("ui/shape_2.png")
            :move(dw*index, 0)
            :addTo(self.node)
        img:setAnchorPoint(cc.p(0.5, 0))
        img:setScaleY(max/nh*dh*rate/img:getContentSize().height)

        local lab = cc.Label:createWithSystemFont(rate, "Arial", 25)
            :move(dw*i, max/nh*dh*rate+20)
            :addTo(self.node)
        lab:setColor(display.COLOR_TXT)
        lab:setAlignment(1, 1)
        lab:setDimensions(70, 25)
    end
end

return Panel
