local SubPanel = class("WarehouseSubPanel1", cc.Node)
local Widget = require "app.views.ui.ItemWidget"

function SubPanel:ctor()
    self.widgetList = {}
    self.scroll = ccui.ScrollView:create()
        :move(CC_DESIGN_RESOLUTION.width/2-750/2, CC_DESIGN_RESOLUTION.height/2-25-340/2)
        :addTo(self)
    self.scroll:setContentSize(cc.size(750, 340))
    self.scroll:setInnerContainerSize(cc.size(800, 340))
    self.scroll:setBounceEnabled(false)
    self.scroll:setScrollBarEnabled(false)
    self.scroll:setDirection(0)

    self:setData()
end

function SubPanel:setData()
    for i, v in ipairs(self.widgetList) do
        v:removeFromParent()
    end
    self.widgetList = {}

    local size = self.scroll:getContentSize()
    local num = 10
    self.scroll:setInnerContainerSize(cc.size(201*num+15*(num+1), size.height))
    for i = 1, num do
        local widget = Widget.new()
        widget:setPosition(15+201/2+(i-1)*(201+15), 25+290/2)
        self.scroll:addChild(widget)
        table.insert(self.widgetList, widget)
    end
end

return SubPanel
