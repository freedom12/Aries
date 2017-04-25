local Mgr = cc.load("event"):create()
LOGIN = "LOGIN"
LOGOUT = "LOGOUT"
REGIST = "REGIST"
USR_INFO = "USR_INFO"
COMPANY_INFO = "COMPANY_INFO"
COMPANY_SIGN = "COMPANY_SIGN"
COMPANY_TAKE = "COMPANY_TAKE"
COMPANY_AUTO = "COMPANY_AUTO"
COMPANY_STEAL = "COMPANY_STEAL"
COMPANY_UPGRADE = "COMPANY_UPGRADE"
COMPANY_EMPLOYEE = "COMPANY_EMPLOYEE"
MAIL = "MAIL"
RATE_LOG = "RATE_LOG"
TAKE_LOG = "TAKE_LOG"
FEIEND = "FEIEND"
SEARCH = "SEARCH"
SEND_SUGGEST = "SEND_SUGGEST"
TRANSFER = "TRANSFER"
UPDATE_INFO = "UPDATE_INFO"
function Mgr:init (scene)
    self:bind(scene)
end

local on = Mgr.addEventListener
function Mgr:addEventListener (...)
    local tar, id = Mgr:on(...)
    return id
end

return Mgr
