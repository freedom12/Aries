local Panel = class("SearchPanel", cc.Node)

function Panel:ctor()
    self.data = nil
    display.newSprite("ui/bg_2.png", {capInsets=cc.rect(113, 101, 2, 2), size=cc.size(840, 545)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2)
        :addTo(self)

    display.newSprite("ui/bg_3.png", {capInsets=cc.rect(35, 32, 1, 2), size=cc.size(750, 270)})
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25)
        :addTo(self)

    display.newSprite("ui/bg_title.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1030)
        :addTo(self)

    display.newSprite("ui/txt_zhuanzhang.png")
        :move(CC_DESIGN_RESOLUTION.width/2, 1055)
        :addTo(self)

    self.closeBtn = ccui.Button:create("ui/btn_close.png")
        :move(CC_DESIGN_RESOLUTION.width/2+840/2, CC_DESIGN_RESOLUTION.height/2+545/2)
        :addTo(self)
    self.closeBtn:addEvent(function()
        UIMgr:hide("SearchPanel")
    end)

    local lab = cc.Label:createWithSystemFont("请输入", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2-285, CC_DESIGN_RESOLUTION.height/2-25+185)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(370, 42)})
        :move(CC_DESIGN_RESOLUTION.width/2-30, CC_DESIGN_RESOLUTION.height/2-25+185)
        :addTo(self)
    self.telInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2-30, CC_DESIGN_RESOLUTION.height/2-25+185)
        :addTo(self)
    self.telInput:setFontSize(40)
    self.telInput:setPlaceHolder("请输入手机号")
    self.telInput:setTextAreaSize(cc.size(370, 42))
    self.telInput:setContentSize(cc.size(370, 42))
    self.telInput:ignoreContentAdaptWithSize(false)
    self.telInput:setTextHorizontalAlignment(1)
    self.telInput:setTextVerticalAlignment(1)
    self.telInput:setMaxLengthEnabled(true)
    self.telInput:setMaxLength(11)

    self.searchBtn = ccui.Button:create("ui/btn_3.png")
        :move(CC_DESIGN_RESOLUTION.width/2+300, CC_DESIGN_RESOLUTION.height/2-25+185)
        :addTo(self)
    self.searchBtn.txt = display.newSprite("ui/txt_sousuo.png")
        :move(171/2, 72/2)
        :addTo(self.searchBtn)
    self.searchBtn:addEvent(function()
        self:search()
    end)

    local lab = cc.Label:createWithSystemFont("交易数量", "Arial", 40)
        :move(CC_DESIGN_RESOLUTION.width/2-285, CC_DESIGN_RESOLUTION.height/2-25-185)
        :addTo(self)
    lab:setAlignment(0, 1)
    lab:setDimensions(200, 40)
    lab:setColor(display.COLOR_TXT)
    display.newSprite("ui/bg_txt_2.png", {capInsets=cc.rect(18, 18, 2, 1), size=cc.size(370, 42)})
        :move(CC_DESIGN_RESOLUTION.width/2-30, CC_DESIGN_RESOLUTION.height/2-25-185)
        :addTo(self)
    self.numInput = ccui.TextField:create()
        :move(CC_DESIGN_RESOLUTION.width/2-30, CC_DESIGN_RESOLUTION.height/2-25-185)
        :addTo(self)
    self.numInput:setFontSize(40)
    self.numInput:setPlaceHolder("请输入10的倍数")
    self.numInput:setTextAreaSize(cc.size(370, 42))
    self.numInput:setContentSize(cc.size(370, 42))
    self.numInput:ignoreContentAdaptWithSize(false)
    self.numInput:setTextHorizontalAlignment(1)
    self.numInput:setTextVerticalAlignment(1)
    self.numInput:setMaxLengthEnabled(true)
    self.numInput:setMaxLength(8)
    self.numInput:addEventListener(function(object, event)
        if event == ccui.TextFiledEventType.detach_with_ime then
            local num = tonumber(self.numInput:getString()) or 0
            if num <= 0 then
                num = 0
            end
            num = math.floor(num/10)*10
            self.numInput:setString(num)
        end
    end)

    self.transferBtn = ccui.Button:create("ui/btn_2.png")
        :move(CC_DESIGN_RESOLUTION.width/2+285, CC_DESIGN_RESOLUTION.height/2-25-185)
        :addTo(self)
    self.transferBtn.txt = display.newSprite("ui/txt_jiaoyi.png")
        :move(209/2, 72/2)
        :addTo(self.transferBtn)
    self.transferBtn:addEvent(function()
        self:transfer()
    end)

    self.nameLab = cc.Label:createWithSystemFont("姓名：--", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25+105)
        :addTo(self)
    self.nameLab:setAlignment(0, 1)
    self.nameLab:setDimensions(680, 35)
    self.nameLab:setColor(display.COLOR_TXT)

    self.telLab = cc.Label:createWithSystemFont("手机号：--", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25+35)
        :addTo(self)
    self.telLab:setAlignment(0, 1)
    self.telLab:setDimensions(680, 35)
    self.telLab:setColor(display.COLOR_TXT)

    self.pnameLab = cc.Label:createWithSystemFont("推荐人姓名：--", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25-35)
        :addTo(self)
    self.pnameLab:setAlignment(0, 1)
    self.pnameLab:setDimensions(680, 35)
    self.pnameLab:setColor(display.COLOR_TXT)

    self.ptelLab = cc.Label:createWithSystemFont("推荐人手机号：--", "Arial", 35)
        :move(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/2-25-105)
        :addTo(self)
    self.ptelLab:setAlignment(0, 1)
    self.ptelLab:setDimensions(680, 35)
    self.ptelLab:setColor(display.COLOR_TXT)

    self:enableNodeEvents()
end

function Panel:onEnter ()
    self.eventList = {}
    self.eventList[1] = EventMgr:addEventListener(SEARCH, function(e)
        self:setData(e.data)
    end)
    self.eventList[2] = EventMgr:addEventListener(TRANSFER, function(e)
        UIMgr:hide("SearchPanel")
    end)
end

function Panel:onExit ()
    for i, v in ipairs(self.eventList) do
        EventMgr:removeEventListener(v)
    end
end

function Panel:setData (data)
    if not data then
        return
    end
    self.data = data.result
    self.nameLab:setString("姓名："..self.data.userName)
    self.telLab:setString("手机号："..self.data.tel)
    self.pnameLab:setString("推荐人姓名："..(self.data.parentUserName or "--"))
    self.ptelLab:setString("推荐人手机号："..(self.data.parentTel or "--"))
end

function Panel:search()
    local tel = self.telInput:getString()
    if not tel or tel == "" then
        UIMgr:warn("请输入搜索手机号")
        return
    end
    NetMgr:search(tel)
end

function Panel:transfer ()
    if not self.data then
        return
    end
    local tel = self.data.tel
    if not tel or tel == "" then
        UIMgr:warn("请输入搜索手机号")
        return
    end
    if not tonumber(tel) then
        UIMgr:warn("手机号不正确")
        return
    end
    local num = tonumber(self.numInput:getString()) or 0
    if num <= 0 then
        UIMgr:warn("请输入转账金额")
        return
    end
    num = math.floor(num/10)*10

    local panel = UIMgr:show("InputPanel", "请输入密码")
    panel:setPwd()
    panel:setYesHandler(function()
        local str = panel:getStr()
        if not str or str == "" then
            UIMgr:warn("请输入密码")
            return
        end

        NetMgr:transfer(tel, num, str)
        UIMgr:hide("InputPanel")
    end)
end

return Panel
