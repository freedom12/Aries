local SubPanel = class("WarehouseSubPanel2", cc.Node)
local Widget = require "app.views.ui.TakeLogWidget"

function SubPanel:ctor()
    self.widgetList = {}
    self.scroll = ccui.ScrollView:create()
        :move(CC_DESIGN_RESOLUTION.width/2-750/2, CC_DESIGN_RESOLUTION.height/2-25-340/2)
        :addTo(self)
    self.scroll:setContentSize(cc.size(750, 340))
    self.scroll:setInnerContainerSize(cc.size(750, 340))
    self.scroll:setBounceEnabled(true)
    
    self:enableNodeEvents()
    NetMgr:getTakeLog()
end

function SubPanel:onEnter ()
    self.id = EventMgr:addEventListener(TAKE_LOG, function(e)
        self:setData(e.data)
    end)
end

function SubPanel:onExit ()
    EventMgr:removeEventListener(self.id)
end

function SubPanel:setData(data)
    for i, v in ipairs(self.widgetList) do
        v:removeFromParent()
    end
    self.widgetList = {}

    if not data then
        return
    end
    self.data = data.result.list

    local size = self.scroll:getContentSize()
    local num = #self.data
    local h = 50*num+15*(num+1)
    self.scroll:setInnerContainerSize(cc.size(size.width, h))
    local size = self.scroll:getInnerContainerSize()
    for i = 1, num do
        local widget = Widget.new(self.data[i])
        widget:setPosition(30+690/2, 15+50/2+(i-1)*(50+15)+size.height-h)
        self.scroll:addChild(widget)
        table.insert(self.widgetList, widget)
    end
end

return SubPanel
