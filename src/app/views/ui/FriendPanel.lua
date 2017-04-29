local Panel = class("FriendPanel", cc.Node)
local Widget = require "app.views.ui.FriendWidget"

function Panel:ctor()
    self.widgetList = {}
    self.data = nil
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_3.png", {capInsets=cc.rect(35, 32, 1, 2), size=cc.size(750, 380)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-40)
        :addTo(self)

    -- display.newSprite("ui/bg_title.png")
    --     :move(CC_DESIGN_RESOLUTION.width/2, 1030)
    --     :addTo(self)

    -- display.newSprite("ui/txt_youxiang.png")
    --     :move(CC_DESIGN_RESOLUTION.width/2, 1055)
    --     :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("FriendPanel")
    end)

    self.scroll = ccui.ScrollView:create()
        :move(CC_DESIGN_RESOLUTION.width/2-750/2, CC_DESIGN_RESOLUTION.height/2-40-380/2)
        :addTo(self)
    self.scroll:setContentSize(cc.size(750, 380))
    self.scroll:setInnerContainerSize(cc.size(750, 380))
    self.scroll:setBounceEnabled(true)

    self.registBtn = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2+300, CC_DESIGN_RESOLUTION.height/2+190)
        :addTo(self)
    self.registBtn:setTitleText("邀请")
    self.registBtn:setTitleFontSize(30)
    self.registBtn:addEvent(function()
        UIMgr:show("RegistPanel")
    end)

    self.tabList = {}
    for i = 1, 3 do
        self.tabList[i] = ccui.Button:create("ui/btn_tab_1.png")
            :move(CC_DESIGN_RESOLUTION.width/2-275+175*(i-1), CC_DESIGN_RESOLUTION.height/2-25+200)
            :addTo(self)
        self.tabList[i]:setTitleText(i.."代好友")
        self.tabList[i]:setTitleFontSize(30)
        self.tabList[i]:setTitleColor(display.COLOR_TXT)
        self.tabList[i]:addEvent(function() self:select(i) end)
    end

    self:select(1)
    self:enableNodeEvents()
end

function Panel:onEnter ()
    self.id = EventMgr:addEventListener(FEIEND, function(e)
        if self.index == 1 then
            self:setData(e.data.friends)
        else
            self:setData(e.data.list)
        end
    end)
end

function Panel:onExit ()
    EventMgr:removeEventListener(self.id)
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

    if self.index == 1 then
        NetMgr:getFriend()
    else
        NetMgr:getFriendByGap(self.index)
    end
end

function Panel:setData (data)
    for i, v in ipairs(self.widgetList) do
        v:removeFromParent()
    end
    self.widgetList = {}

    if not data then
        return
    end
    self.data = data
    local size = self.scroll:getContentSize()
    local num = #self.data
    local h = 135*num+15*(num+1)
    self.scroll:setInnerContainerSize(cc.size(size.width, h))
    local size = self.scroll:getInnerContainerSize()
    for i = 1, num do
        local widget = Widget.new(UsrVo.new(self.data[i]))
        widget:setPosition(30+690/2, 15+135/2+(i-1)*(135+15)+size.height-h)
        self.scroll:addChild(widget)
        table.insert(self.widgetList, widget)

        if self.index ~= 1 then
            widget.btn:setVisible(false)
        end
    end
end

return Panel
