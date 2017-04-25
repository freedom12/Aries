
local MyApp = class("MyApp", cc.load("mvc").AppBase)
EventMgr = require "app.manager.EventMgr"
NetMgr = require "app.manager.NetMgr"
DataMgr = require "app.manager.DataMgr"
UIMgr = require "app.manager.UIMgr"
TouchMgr = require "app.manager.TouchMgr"

DataVo = require "app.model.DataVo"
UsrVo = require "app.model.UsrVo"
CompanyVo = require "app.model.CompanyVo"
UnitVo = require "app.model.UnitVo"
MailVo = require "app.model.MailVo"

AUTO_COST = 2000
AUTO_TIME = 7




function MyApp:onCreate()
    math.randomseed(os.time())
end

return MyApp
