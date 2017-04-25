local Widget = class("ChooseJobWidget", cc.Node)

function Widget:ctor(index, type)
    self.index = index
    self.type = type
    self.isOpen = false
    self.bg = display.newSprite("ui/bg_job.png")
        :move(0, 0)
        :addTo(self)

    local size = self.bg:getContentSize()
    self.lvlTxt = display.newSprite("ui/lv_"..self.type..".png")
        :move(0, 55)
        :addTo(self)

    self.img = display.newSprite("ui/img_job_"..self.type..".png")
        :move(0, -20)
        :addTo(self)

    self.chooseBtn = ccui.Button:create("ui/btn_3.png")
        :move(size.width/2, -45)
        :addTo(self.bg)
    self.chooseBtn:setScale9Enabled(true)
    self.chooseBtn:setCapInsets(cc.rect(85, 35, 1, 2))
    self.chooseBtn:setContentSize(cc.size(171, 72))
    self.chooseBtn:addEvent(function()
        self:employee()
    end)

    self.chooseBtn.txt = display.newSprite("ui/txt_guyong.png")
        :move(171/2, 72/2)
        :addTo(self.chooseBtn)

    self.lab = cc.Label:createWithSystemFont("暂未开启", "Arial", 35)
        :move(size.width/2, -45)
        :addTo(self.bg)
    self.lab:setColor(display.COLOR_TXT)
end

function Widget:employee()
    local cost = DataMgr.priceCfg[self.type]
    local name = DataMgr:getUnitName(cost)
    local str = "是否花费"..cost.."雇佣一位"..name.."为您工作？"
    local panel = UIMgr:show("ConfirmPanel", str)
    panel:setYesHandler(function()
        NetMgr:employee(self.index, self.type)
        UIMgr:hide("ConfirmPanel")
    end)
end

function Widget:setOpen (bool)
    self.isOpen = bool
    self.chooseBtn:setVisible(self.isOpen)
    self.lab:setVisible(not self.isOpen)
end

return Widget
