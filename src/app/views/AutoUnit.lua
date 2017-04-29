local Unit = class("AutoUnit", cc.Node)

function Unit:ctor()
    self.state = 1
    self.view = ccui.Button:create("unit_auto_1.png")
        :addTo(self)
    self.view:loadTextureDisabled("unit_auto_1.png")

    self.img = display.newSprite("img_auto.png")
        :move(50, 65)
        :addTo(self)

    self.view:addEvent(function()
        self:auto()
    end)
end

function Unit:setState (state)
    self.view:loadTextureNormal("unit_1_"..state..".png")
    self.state = state
end

function Unit:setEnabled (bool)
    self.view:setEnabled(bool)
end

function Unit:auto()
    if not DataMgr:isLogin() or not DataMgr.data.company then
        return
    end
    if DataMgr.data.company.isAuto then
        UIMgr:warn("已经雇佣")
        return
    end
    local str = "是否话费"..AUTO_COST.."雇佣一位前台为您工作"..AUTO_TIME.."天？"
    local panel = UIMgr:show("ConfirmPanel", str)
    panel:setYesHandler(function()
        NetMgr:auto()
        UIMgr:hide("ConfirmPanel")
    end)
end

return Unit
