local Mgr = {}

function Mgr:init (scene)
    self.scene = scene
    self.panelList = {}
    self.uiLayer = cc.Node:create()
    self.scene.root:addChild(self.uiLayer, 10)

    self.waitPanelCount = 0
end

function Mgr:show (name, params, isTouch)
    order = order or 0
    local panel = require ("app.views.ui."..name).new(params)
    self.panelList[name] = panel
    panel.maskLayer = self:createMaskLayer(isTouch)
    panel.maskLayer:addChild(panel)
    self.uiLayer:addChild(panel.maskLayer)
    return panel
end

function Mgr:hide (name)
    local panel = self.panelList[name]
    if not panel then
        return
    end

    self.panelList[name] = nil
    panel.maskLayer:removeFromParent()
end

function Mgr:createMaskLayer (isTouch)
    if isTouch == nil then
        isTouch = true
    end
    local maskLayer = display.newLayer(cc.c4b(1, 1, 1, 0), cc.size(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height))
    maskLayer:setTouchEnabled(isTouch)

    if isTouch then
        local listener = cc.EventListenerTouchOneByOne:create()
        listener:registerScriptHandler(function()
            return true
        end, cc.Handler.EVENT_TOUCH_BEGAN)
        listener:setSwallowTouches(true)

        local eventDispatcher = maskLayer:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, maskLayer)
    end
    return maskLayer
end

function Mgr:showWait ()
    if self.waitPanelCount == 0 then
        self.waitPanel = self:show("WaitPanel")
        self.waitPanel:setLocalZOrder(100)
    end
    self.waitPanelCount = self.waitPanelCount + 1
end

function Mgr:hideWait ()
    self.waitPanelCount = self.waitPanelCount - 1
    if self.waitPanelCount == 0 then
        self.waitPanel = self:hide("WaitPanel")
    end
end

function Mgr:warn (str)
    if not str or str == "" then
        str = "网络错误"
    end
    local node = cc.Node:create()
    node:setPosition(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
    self.uiLayer:addChild(node, 200)
    local bg = display.newSprite("ui/bg_txt_3.png", {capInsets=cc.rect(19, 19, 1, 1), size=cc.size(500, 75)})
        :addTo(node)
    local lab = cc.Label:createWithSystemFont(str, "Arial", 40)
        :addTo(node)
    lab:setColor(display.COLOR_TXT_2)

    local size = lab:getContentSize()
    size.width = math.max(size.width + 50, 450)
    size.height = size.height + 20
    bg:setContentSize(size)

    local act1 = cc.DelayTime:create(1)
    local act2 = cc.CallFunc:create(function()
        node:removeFromParent()
    end)
    node:runAction(cc.Sequence:create(act1, act2))
end

return Mgr
