local Panel = class("SettingPanel", cc.Node)

function Panel:ctor()
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_3.png", {capInsets=cc.rect(35, 32, 1, 2), size=cc.size(750, 285)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+25)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    display.newSprite("ui/txt_shezhi.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1055)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("SettingPanel")
    end)

    self.logoutBtn = ccui.Button:create("ui/btn_3.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 580)
        :addTo(self)
    self.logoutBtn.txt = display.newSprite("ui/txt_dengchu.png")
        :move(171/2, 72/2)
        :addTo(self.logoutBtn)
    self.logoutBtn:addEvent(function()
        self:logout()
    end)

    cc.Label:createWithSystemFont("音乐", "Arial", 50)
        :move(740, CC_DESIGN_RESOLUTION.height/2+25+60)
        :addTo(self)
        :setColor(display.COLOR_TXT)
    display.newSprite("ui/pro_bg.png")
        :move(1100, CC_DESIGN_RESOLUTION.height/2+25+60)
        :addTo(self)
    self.musicPro = ccui.LoadingBar:create("ui/pro.png", 100)
    self.musicPro:setPosition(1100, CC_DESIGN_RESOLUTION.height/2+25+60)
    self:addChild(self.musicPro)

    self.musicBtn = display.newSprite("ui/btn_music.png")
        :move(1100, CC_DESIGN_RESOLUTION.height/2+25+60)
        :addTo(self)
    TouchMgr:addTouchEvent(self.musicBtn, nil,function(touch, event)
        local p = touch:getDelta()
        local x, y = self.musicBtn:getPosition()
        x = x + p.x
        local per = (x-870)/459*100
        self:setMusic(per)
    end)

    cc.Label:createWithSystemFont("音效", "Arial", 50)
        :move(740, CC_DESIGN_RESOLUTION.height/2+25-60)
        :addTo(self)
        :setColor(display.COLOR_TXT)
    display.newSprite("ui/pro_bg.png")
        :move(1100, CC_DESIGN_RESOLUTION.height/2+25-60)
        :addTo(self)
    self.soundPro = ccui.LoadingBar:create("ui/pro.png", 100)
    self.soundPro:setPosition(1100, CC_DESIGN_RESOLUTION.height/2+25-60)
    self:addChild(self.soundPro)

    self.soundBtn = display.newSprite("ui/btn_sound.png")
        :move(1100, CC_DESIGN_RESOLUTION.height/2+25-60)
        :addTo(self)
    TouchMgr:addTouchEvent(self.soundBtn, nil,function(touch, event)
        local p = touch:getDelta()
        local x, y = self.soundBtn:getPosition()
        x = x + p.x
        local per = (x-870)/459*100
        self:setSound(per)
    end)

    self:setMusic(cc.UserDefault:getInstance():getIntegerForKey("music", 100))
    self:setSound(cc.UserDefault:getInstance():getIntegerForKey("sound", 100))
end

function Panel:logout ()
    NetMgr:logout()
end

function Panel:setMusic (per)
    per = per or 100
    if per > 100 then
        per = 100
    elseif per < 0 then
        per = 0
    end
    self.musicPro:setPercent(per)
    cc.UserDefault:getInstance():setIntegerForKey("music", per)
    local x = per/100*459 + 870
    self.musicBtn:setPositionX(x)
    ccexp.AudioEngine:setVolume(BGM, cc.UserDefault:getInstance():getIntegerForKey("music", 100)/100)
end

function Panel:setSound (per)
    per = per or 100
    if per > 100 then
        per = 100
    elseif per < 0 then
        per = 0
    end
    self.soundPro:setPercent(per)
    cc.UserDefault:getInstance():setIntegerForKey("sound", per)
    local x = per/100*459 + 870
    self.soundBtn:setPositionX(x)
end

return Panel
