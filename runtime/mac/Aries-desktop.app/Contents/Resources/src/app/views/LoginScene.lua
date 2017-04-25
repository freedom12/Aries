local LoginScene = class("LoginScene", cc.load("mvc").ViewBase)

function LoginScene:onCreate()
    AudioEngine.setMusicVolume(cc.UserDefault:getInstance():getIntegerForKey("music")/100)
    AudioEngine.setEffectsVolume(cc.UserDefault:getInstance():getIntegerForKey("sound")/100)

    EventMgr:init(self)
    UIMgr:init(self)

    self.bg = display.newSprite("bg.png")
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self.root)

    UIMgr:show("LoginPanel")
    -- UIMgr:show("SuggestPanel")

    self:enableNodeEvents()
end

function LoginScene:onEnter ()
    self.eventList = {}
    self.eventList[1] = EventMgr:addEventListener(UPDATE_INFO, function(e)
        app:enterScene("MainScene")
    end)
end

function LoginScene:onExit ()
    for i, v in ipairs(self.eventList) do
        EventMgr:removeEventListener(v)
    end
end

return LoginScene
