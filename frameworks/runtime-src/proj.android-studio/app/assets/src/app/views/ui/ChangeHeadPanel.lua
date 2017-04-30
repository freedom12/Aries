local Panel = class("ChangeHeadPanel", cc.Node)

function Panel:ctor(str)
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_4.png", {capInsets=cc.rect(50, 50, 1, 2), size=cc.size(760, 420)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    display.newSprite("ui/txt_xiugaitouxiang.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1055)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("ChangeHeadPanel")
    end)

    display.newSprite("ui/bg_head_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2-170, CC_DESIGN_RESOLUTION.height/2+30)
        :addTo(self)
    display.newSprite("img_head_0_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2-170, CC_DESIGN_RESOLUTION.height/2+17)
        :addTo(self)
    self.headBtn1 = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2-170, CC_DESIGN_RESOLUTION.height/2-130)
        :addTo(self)
    self.headBtn1:setTitleText("更换")
    self.headBtn1:setTitleFontSize(30)
    self.headBtn1:addEvent(function()
        self:changeHead(0)
    end)

    display.newSprite("ui/bg_head_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2+170, CC_DESIGN_RESOLUTION.height/2+30)
        :addTo(self)
    display.newSprite("img_head_1_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2+170, CC_DESIGN_RESOLUTION.height/2+17)
        :addTo(self)
    self.headBtn2 = ccui.Button:create("ui/btn_4.png")
        :move(CC_DESIGN_RESOLUTION.width/2+170, CC_DESIGN_RESOLUTION.height/2-130)
        :addTo(self)
    self.headBtn2:setTitleText("更换")
    self.headBtn2:setTitleFontSize(30)
    self.headBtn2:addEvent(function()
        self:changeHead(1)
    end)
end

function Panel:changeHead (index)
    if not DataMgr:isLogin() then
        return
    end
    local data = DataMgr.data
    local usrData = data.usr
    if index ~= usrData.sex then
        NetMgr:changeHead(index)
    end
    UIMgr:hide("ChangeHeadPanel")
end

return Panel
