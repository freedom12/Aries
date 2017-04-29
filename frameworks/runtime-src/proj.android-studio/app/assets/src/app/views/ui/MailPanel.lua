local Panel = class("MailPanel", cc.Node)
local Widget = require "app.views.ui.MailWidget"

function Panel:ctor()
    self.page = 1
    self.totalPage = 10
    self.widgetList = {}
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_3.png", {capInsets=cc.rect(35, 32, 1, 2), size=cc.size(750, 380)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-10)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    display.newSprite("ui/txt_youxiang.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1055)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("MailPanel")
    end)

    -- self.numLab = cc.Label:createWithSystemFont("0/0", "Arial", 35)
    --     :move(CC_DESIGN_RESOLUTION.width/2, 535)
    --     :addTo(self)
    -- self.numLab:setColor(display.COLOR_TXT)

    self.scroll = ccui.ScrollView:create()
        :move(CC_DESIGN_RESOLUTION.width/2-750/2, CC_DESIGN_RESOLUTION.height/2-10-380/2)
        :addTo(self)
    self.scroll:setContentSize(cc.size(750, 380))
    self.scroll:setInnerContainerSize(cc.size(750, 380))
    self.scroll:setBounceEnabled(true)


    -- self.lastBtn = ccui.Button:create("ui/btn_l.png")
    --     :move(CC_DESIGN_RESOLUTION.width/2-400, CC_DESIGN_RESOLUTION.height/2)
    --     :addTo(self)
    -- self.lastBtn:addEvent(function() self:setPage(self.page-1) end)
    --
    -- self.nextBtn = ccui.Button:create("ui/btn_r.png")
    --     :move(CC_DESIGN_RESOLUTION.width/2+400, CC_DESIGN_RESOLUTION.height/2)
    --     :addTo(self)
    -- self.nextBtn:addEvent(function() self:setPage(self.page+1) end)

    NetMgr:getMail()
    self:enableNodeEvents()
end

function Panel:onEnter ()
    self.id = EventMgr:addEventListener(MAIL, function(e)
        self:setData(e.data)
    end)
end

function Panel:onExit ()
    EventMgr:removeEventListener(self.id)
end

function Panel:setData(data)
    for i, v in ipairs(self.widgetList) do
        v:removeFromParent()
    end
    self.widgetList = {}

    if not data then
        return
    end
    self.data = data.result.list
    table.sort(self.data, function(a, b)
        return a.gDate > b.gDate
    end)
    local size = self.scroll:getContentSize()
    local num = #self.data
    local h = 135*num+15*(num+1)
    self.scroll:setInnerContainerSize(cc.size(size.width, h))
    local size = self.scroll:getInnerContainerSize()
    for i = 1, num do
        local widget = Widget.new(MailVo.new(self.data[i]))
        widget:setPosition(30+690/2, 15+135/2+(i-1)*(135+15)+size.height-h)
        self.scroll:addChild(widget)
        table.insert(self.widgetList, widget)
    end

    -- self:setPage(self.page)
end

function Panel:setPage(page)
    page = page or 1
    if page < 1 then
        page = 1
    elseif page > self.totalPage then
        page = self.totalPage
    end
    self.page = page
    self.numLab:setString(self.page .. "/" .. self.totalPage)
end

return Panel
