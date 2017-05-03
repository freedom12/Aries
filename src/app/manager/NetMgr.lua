local Mgr = {}
Mgr.url = "https://www.qmboss.top:8443/bossCountry/"
Mgr.session = ""
function Mgr:send (url, data, handler, isHideWait)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("POST", url)
    -- xhr:setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8")
    xhr:setRequestHeader("Cookie", self.session)
    local function onReadyStateChange()
        if xhr.readyState ~= 4 then
            return
        end
        if not isHideWait then
            UIMgr:hideWait()
        end
        if xhr.status ~= 200 then
            print("NET ERROR:", xhr.statusText)
            UIMgr:warn("网络错误")
            return
        end
        local response = xhr.response
        if not response or response == "" then
            print("网络返回为空")
            UIMgr:warn("网络错误")
            return
        end
        if not self.session or self.session == "" then
            local session = xhr:getResponseHeader("Set-Cookie")
            session = string.split(session, ";")[1]
            session = string.trim(session)
            self.session = session
        end

        response = json.decode(xhr.response, 1)
        if not isHideWait then
            dump(response)
        end
        handler(response)
    end

    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send(data)

    if not isHideWait then
        UIMgr:showWait()
    end
end

function Mgr:login(usr, pwd)
    if not string.isNumOrChar(pwd) then
        UIMgr:warn("密码包含非数字或字母")
        return
    end
    -- pwd = string.urlencode(pwd)
    -- usr = string.urlencode(usr)
    local url = Mgr.url.."member/login.do?".."gTel="..usr.."&gPassWord="..pwd
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            print("CODE:"..data.result.code.."  MESSAGE:"..data.result.message)
            return
        end
        DataMgr:init()

        local e = {
            name = LOGIN,
            data = data
        }
        EventMgr:dispatchEvent(e)

        self:getConf()
    end)
end

function Mgr:logout ()
    DataMgr:clear()
    local url = Mgr.url.."member/logout.do"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.msg)
            return
        end
        DataMgr:clear()
        self.session = ""

        local e = {
            name = LOGOUT,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:updateInfo ()
    local url = Mgr.url.."member/showMember.do"
    self:send(url, nil, function(data)
        if data.code and data.code ~= 0 then
            UIMgr:warn(data.message)
            return
        end
        DataMgr:setUsr(data.user)

        local url = Mgr.url.."company/getCompanyInfo.do?gTel="..DataMgr.data.usr.tel
        self:send(url, nil, function(data)
            if data.code and data.code ~= 0 then
                UIMgr:warn(data.message)
                return
            end

            DataMgr:setCompany(data.result.company)
            local e = {
                name = UPDATE_INFO,
                data = CompanyVo.new(data.result.company)
            }
            EventMgr:dispatchEvent(e)
        end)
    end)
end

function Mgr:changeName (name)
    -- name = string.urlencode(name)
    local url = Mgr.url.."member/updateMemberInfo.do?"
    local data = "gUsername="..name
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        DataMgr:getUsr().name = name
        UIMgr:warn("修改名字成功")
        local e = {
            name = UPDATE_INFO,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:changeHead (index)
    local url = Mgr.url.."member/updateMemberInfo.do".."?gSex="..index
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        DataMgr:getUsr().sex = index
        UIMgr:warn("修改头像成功")
        local e = {
            name = UPDATE_INFO,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:changePwd (old, new)
    if not string.isNumOrChar(old) then
        UIMgr:warn("旧密码包含非数字或字母")
        return
    end
    if not string.isNumOrChar(new) then
        UIMgr:warn("新密码包含非数字或字母")
        return
    end
    -- old = string.urlencode(old)
    -- new = string.urlencode(new)
    local url = Mgr.url.."member/updatePassword.do".."?passwordOld="..old.."&passwordNew="..new
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        UIMgr:warn("修改密码成功")
        -- local e = {
        --     name = UPDATE_INFO,
        --     data = data
        -- }
        -- EventMgr:dispatchEvent(e)
    end)
end

function Mgr:getUsrInfo ()
    local url = Mgr.url.."member/showMember.do"
    self:send(url, data, function(data)
        if data.code and data.code ~= 0 then
            UIMgr:warn(data.message)
            return
        end
        DataMgr:setUsr(data.user)

        local e = {
            name = USR_INFO,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:getCompanyInfo (tel)
    -- tel = string.urlencode(tel)
    local url = Mgr.url.."company/getCompanyInfo.do?gTel="..tel
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = COMPANY_INFO,
            data = CompanyVo.new(data.result.company)
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:getConf ()
    local url = Mgr.url.."company/getConfigs.do"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        local conf = data.result.configs
        dump(conf)
        for i, v in pairs(conf) do
            if v.bossKey == "employee" then
                local list = string.split(v.bossValue, ",")
                for j, w in ipairs(list) do
                    list[j] = tonumber(w)
                end
                DataMgr.priceCfg = list
            elseif v.bossKey == "employee_level" then
                DataMgr.openEmployee = tonumber(v.bossValue) or 0
            elseif v.bossKey == "qiantai_day" then
                DataMgr.autoTime = tonumber(v.bossValue) or 0
            elseif v.bossKey == "qiantai_price" then
                DataMgr.autoCost = tonumber(v.bossValue) or 0
            end
        end
        self:updateInfo()
    end)
end

-- function Mgr:getPrice ()
--     local url = Mgr.url.."company/getEmployeeInfo.do"
--     self:send(url, data, function(data)
--         if data.result and data.result.code and data.result.code ~= 0 then
--             UIMgr:warn(data.result.message)
--             return
--         end
--         local str = data.result.employeePrice
--         local list = string.split(str, ",")
--         for i, v in ipairs(list) do
--             list[i] = tonumber(v)
--         end
--         DataMgr.priceCfg = list
--     end)
-- end
--
-- function Mgr:getOpenEmployee ()
--     local url = Mgr.url.."company/getOpenEmployLevel.do"
--     self:send(url, data, function(data)
--         if data.result and data.result.code and data.result.code ~= 0 then
--             UIMgr:warn(data.result.message)
--             return
--         end
--
--         DataMgr.openEmployee = tonumber(data.result.level) or 0
--     end)
-- end

function Mgr:employee (index, type)
    local url = Mgr.url.."company/employee.do?index="..type.."&position="..index
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("雇佣成功")
        local e = {
            name = COMPANY_EMPLOYEE,
            data = data
        }
        EventMgr:dispatchEvent(e)
        self:updateInfo()
    end)
end

function Mgr:upgrade (index, type)
    local url = Mgr.url.."company/upEmployeeLevel.do?position="..index
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = COMPANY_UPGRADE,
            data = data
        }
        UIMgr:warn("升职成功")
        EventMgr:dispatchEvent(e)
        self:updateInfo()
    end)
end

function Mgr:regist (name, tel, pwd, wechat, alipay)
    if not string.isNumOrChar(pwd) then
        UIMgr:warn("密码包含非数字或字母")
        return
    end
    if not string.isNumOrChar(wechat) then
        UIMgr:warn("微信包含非数字或字母")
        return
    end
    if not string.isNumOrChar(alipay) then
        UIMgr:warn("支付宝包含非数字或字母")
        return
    end
    -- name = string.urlencode(name)
    -- tel = string.urlencode(tel)
    -- pwd = string.urlencode(pwd)
    -- wechat = string.urlencode(wechat)
    -- alipay = string.urlencode(alipay)
    local url = Mgr.url.."member/registMember.do"
    print(url)
    local data = "gUsername="..name.."&gPassword="..pwd
        .."&gTel="..tel.."&gWeixin="..wechat.."&gZhifubao="..alipay.."&gIsLock=0"
    print(data)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("邀请成功")
        local e = {
            name = REGIST,
            data = data
        }
        EventMgr:dispatchEvent(e)

        self:updateInfo()
    end)
end

function Mgr:sign ()
    local url = Mgr.url.."company/sign.do"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("签到成功")
        local e = {
            name = COMPANY_SIGN,
            data = data
        }
        EventMgr:dispatchEvent(e)

        self:updateInfo()
    end)
end

function Mgr:take (index)
    local url = Mgr.url.."company/harvest.do?index="..index
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        local data = DataMgr:getCompany().unitList[index]
        local num = data.value-data.lockValue
        UIMgr:warn("收获"..num.."产值")
        local e = {
            name = COMPANY_TAKE,
            data = data
        }
        EventMgr:dispatchEvent(e)

        self:updateInfo()
    end)
end

function Mgr:auto ()
    local url = Mgr.url.."company/buyManager.do"
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("雇佣前台成功")
        local e = {
            name = COMPANY_AUTO,
            data = data
        }
        EventMgr:dispatchEvent(e)

        self:updateInfo()
    end)
end

function Mgr:exchange (num)
    local url = Mgr.url.."company/transfer.do?amount="..num
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("兑换"..num.."金币成功")
        local e = {
            name = COMPANY_EXCHANGE,
            data = data
        }
        EventMgr:dispatchEvent(e)

        self:updateInfo()
    end)
end

function Mgr:getMail ()
    local url = Mgr.url.."mail/getMails.do"
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = MAIL,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:readMail (id)
    local url = Mgr.url.."mail/changeState.do?id="..id.."&state=1"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        self:getMail()
        self:updateInfo()
    end)
end

function Mgr:ensureMail (id)
    local url = Mgr.url.."mail/changeState.do?id="..id.."&state=3"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        self:getMail()
    end)
end

function Mgr:delMail (id)
    local url = Mgr.url.."mail/changeState.do?id="..id.."&state=2"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        self:getMail()
    end)
end

function Mgr:getRateLog ()
    local url = Mgr.url.."company/getCommonRateByDate.do"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = RATE_LOG,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:getTakeLog ()
    local url = Mgr.url.."company/getIncomeByDate.do"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = TAKE_LOG,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:getFriend ()
    local url = Mgr.url.."member/memberFriends.do"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = FEIEND,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:getFriendByGap (gap)
    local url = Mgr.url.."member/memberFriendsByGap.do?gap="..gap
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = FEIEND,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:steal (tel)
    local url = Mgr.url.."company/getFriendsBenefit.do?tel="..tel
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("收获好友产值成功")
        local e = {
            name = COMPANY_STEAL,
            data = data
        }
        EventMgr:dispatchEvent(e)

        self:updateInfo()
    end)
end

function Mgr:sendSuggest (str)
    str = string.urlencode(str)
    local url = Mgr.url.."memberMsg/addMessageMsg.do?message="..str
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("留言成功")
        local e = {
            name = SEND_SUGGEST,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:search (tel)
    -- tel = string.urlencode(tel)
    local url = Mgr.url.."transfer/getReceiverName.do?tel="..tel
        print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = SEARCH,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:transfer (tel, num, password)
    if not string.isNumOrChar(password) then
        UIMgr:warn("密码包含非数字或字母")
        return
    end
    -- password = string.urlencode(password)
    local url = Mgr.url.."transfer/apply.do?toTel="..tel.."&amount="..num.."&passwordii="..password
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("请求转账成功")
        local e = {
            name = TRANSFER,
            data = data
        }
        EventMgr:dispatchEvent(e)

        self:updateInfo()
    end)
end

function Mgr:transferEnsure1 (no)
    local url = Mgr.url.."transfer/getEnsure.do?transferNo="..no
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("确认成功")
    end)
end

function Mgr:transferEnsure2 (no)
    local url = Mgr.url.."transfer/applyEnsure.do?transferNo="..no
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        UIMgr:warn("确认成功")
    end)
end

function Mgr:polling ()
    local url = Mgr.url.."company/getInformation.do?"

    self:send(url, data, function(data)
        if data.result and type(data.result) == "table" and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        local tmp = bit.band(data.result, 0x1)
        if tmp==1 then
            local e = {
                name = NEW_MAIL,
                data = data
            }
            EventMgr:dispatchEvent(e)
        end
    end, true)
end

return Mgr
