local Panel = class("ExchangePanel", cc.Node)

function Panel:ctor()
    self.num = 0
    self.times = 10
    -- display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(660, 490)})
    --     :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
    --     :addTo(self)
    --
    -- display.newSprite("ui/bg_4.png", {capInsets=cc.rect(45, 45, 2, 2), size=cc.size(600, 310)})
    --     :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+60)
    --     :addTo(self)
    --
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(220, 42)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+25)
        :addTo(self)

    local lab = cc.Label:createWithSystemFont("请输入您要兑换的数量", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+100)
        :addTo(self)
    lab:setColor(display.COLOR_TXT)

    local lab = cc.Label:createWithSystemFont("请输入"..self.times.."的整数倍", "Arial", 25)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-35)
        :addTo(self)
    lab:setColor(display.COLOR_TXT)

    self.numInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2+25)
        :addTo(self)
    self.numInput:setFontSize(40)
    self.numInput:setPlaceHolder("0")
    self.numInput:addEventListener(function(object, event)
        if event == ccui.TextFiledEventType.detach_with_ime then
            self:setNum(self.numInput:getString())
        end
    end)

    self.addBtn = ccui.Button:create("ui/btn_add.png")
        :move(CC_DESIGN_RESOLUTION.width/2+150, CC_DESIGN_RESOLUTION.height/2+25)
        :addTo(self)
    self.addBtn:addEvent(function()
        self:setNum(self.num + self.times)
    end)

    self.decBtn = ccui.Button:create("ui/btn_dec.png")
        :move(CC_DESIGN_RESOLUTION.width/2-150, CC_DESIGN_RESOLUTION.height/2+25)
        :addTo(self)
    self.decBtn:addEvent(function()
        self:setNum(self.num - self.times)
    end)

    self.yesBtn = ccui.Button:create("ui/btn_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2-125, CC_DESIGN_RESOLUTION.height/2-130)
        :addTo(self)
    self.yesBtn.txt = display.newSprite("ui/txt_duihuan.png")
        :move(209/2, 72/2)
        :addTo(self.yesBtn)
    self.yesBtn:addEvent(function()
        self:exchange()
    end)

    self.noBtn = ccui.Button:create("ui/btn_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2+125, CC_DESIGN_RESOLUTION.height/2-130)
        :addTo(self)
    self.noBtn.txt = display.newSprite("ui/txt_quxiao.png")
        :move(209/2, 72/2)
        :addTo(self.noBtn)
    self.noBtn:addEvent(function()
        UIMgr:hide("ExchangePanel")
    end)

    self:setNum(self.num)
end

function Panel:setNum (num)
    num = tonumber(num) or 0
    if num < 0 then
        num = 0
    end
    num = math.floor(num/self.times)*self.times
    self.num = num
    self.numInput:setString(num)
end

function Panel:exchange ()
    if self.num <=0 then
        UIMgr:warn("请输入需要兑换的数量")
        return
    end
    NetMgr:exchange(self.num)
end

return Panel
