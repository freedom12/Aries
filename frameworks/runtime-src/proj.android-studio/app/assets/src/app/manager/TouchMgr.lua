local Mgr = {}

function Mgr:addTouchEvent(node,onTouchBegan, onTouchMoved, onTouchEnded, onTouchCancelled)
	local function onNodeTouchBegan(touch, event)
		if self:hitTest(node, touch:getLocation()) then
			if onTouchBegan then
                local ret = onTouchBegan(node, touch, event)
                if ret ~= nil then
                	return ret
                else
                	return true
                end
            else
            	return true
			end
		else
			return false
		end
	end

	local function onNodeTouchMoved(touch, event)
		if onTouchMoved ~= nil then
			onTouchMoved(touch,event)
		end
	end

	local function onNodeTouchEnded(touch, event)
		if onTouchEnded ~= nil then
			onTouchEnded(touch,event)
		end
	end

	local function onNodeTouchCancelled(touch,event)
		if onTouchCancelled ~= nil then
			onTouchCancelled(touch, event)
	 	else
	 		onNodeTouchEnded(touch,event)
		end
	end

	local listener = cc.EventListenerTouchOneByOne:create()
	-- listener:setSwallowTouches(false)
    listener:registerScriptHandler(onNodeTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onNodeTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onNodeTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(onNodeTouchCancelled, cc.Handler.EVENT_TOUCH_CANCELLED)

    local dispatcher = node:getEventDispatcher()
    dispatcher:addEventListenerWithSceneGraphPriority(listener, node)

    return listener
end

function Mgr:removeTouchEvent(node)
    local dispatcher = node:getEventDispatcher()
	dispatcher:removeEventListenersForTarget(node)
end

function Mgr:hitTest(node, point)
    local size = node:getContentSize()
    local x, y = node:getPosition()
    local p = node:getParent():convertToWorldSpace(cc.p(x, y))
    local box = {x=p.x-size.width/2, y=p.y-size.height/2, width=size.width, height=size.height}

    if debugEnable then
        local sceneNode = display.getRunningScene()
        if node.drawNode == nil then
        	node.drawNode = cc.DrawNode:create()
        	sceneNode:addChild(node.drawNode, 255)
        end
        local origin = cc.p(box.x, box.y)
        local dest = cc.p(box.x + box.width, box.y + box.height)
        node.drawNode:clear()
        node.drawNode:drawRect(origin, dest, cc.c4f(1, 0, 0 ,1))
    end

    return cc.rectContainsPoint(box, point)
end

return Mgr
