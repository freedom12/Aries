local Vo = class("UsrVo")

function Vo:ctor(data)
    data = data or {}

    self.id = data.id
    self.name= data.gUsername
    self.tel = data.gTel
    self.pwd = data.gPassword
    self.pwd2 = data.gPasswordii
    self.lvl = data.gLevel
    self.sex = tonumber(data.gSex) or 0
    self.wechat = data.gWeixin
    self.alipay = data.gZhifubao
    self.inviteNum = data.gInvitenum
    self.extraRate = data.gExtrarate
    self.isLock= (tonumber(data.gIslock) == 1)

    self.address = data.gAddraddress
    self.postCode = data.gAddrpostcode

    self.loginNum = data.gLogins

    -- self.gold = data.gJinbi
    -- self.score = data.gCaiwuchu
    -- self.Guwen = data.gGuwen

    self.isSign = (tonumber(data.gQiandao)==1)
    self.isAuto = (tonumber(data.gQiantai)==1)
    -- self.Qiantaiexpdate = data.gQiantaiexpdate
end

return Vo
