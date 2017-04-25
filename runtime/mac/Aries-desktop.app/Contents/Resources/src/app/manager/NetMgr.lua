local Mgr = {}
Mgr.url = "http://www.panguclub.net:8080/bossCountry/"
Mgr.session = ""
function Mgr:send (url, data, handler, isDebug)
    if isDebug then
        handler()
        return
    end
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
        UIMgr:hideWait()
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
        dump(response)
        handler(response)
    end

    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send(data)
    UIMgr:showWait()
end

function Mgr:login(usr, pwd)
    local url = Mgr.url.."member/login.do?".."gTel="..usr.."&gPassWord="..pwd
    print(url)
    self:send(url, data, function(data)
        if data.result.code and data.result.code ~= 0 then
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

        self:getPrice()
        self:getOpenEmployee()
        self:updateInfo()
    end)
end

function Mgr:logout ()
    DataMgr:clear()
    self.session = ""
    local url = Mgr.url.."member/logout.do"
    self:send(url, data, function(data)
        if data.code and data.code ~= 0 then
            UIMgr:warn(data.message)
            print("CODE:"..data.code.."  MESSAGE:"..data.message)
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
    local url = Mgr.url.."member/updateMember.do"
    self:send(url, "gUsername="..name, function(data)
        if data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end
        DataMgr:setUsr().name = name

        local e = {
            name = UPDATE_INFO,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:changePwd (pwd)
    local url = Mgr.url.."member/updateMember.do"
    self:send(url, "gPassword="..pwd, function(data)
        if data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = UPDATE_INFO,
            data = data
        }
        EventMgr:dispatchEvent(e)
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
    local url = Mgr.url.."company/getCompanyInfo.do?gTel="..tel
    self:send(url, data, function(data)
        if data.code and data.code ~= 0 then
            UIMgr:warn(data.message)
            return
        end

        local e = {
            name = COMPANY_INFO,
            data = CompanyVo.new(data.result.company)
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:getPrice ()
    local url = Mgr.url.."company/getEmployeeInfo.do"
    self:send(url, data, function(data)
        if data.code and data.code ~= 0 then
            UIMgr:warn(data.message)
            return
        end
        local str = data.result.employeePrice
        local list = string.split(str, ",")
        for i, v in ipairs(list) do
            list[i] = tonumber(v)
        end
        DataMgr.priceCfg = list
    end)
end

function Mgr:getOpenEmployee ()
    local url = Mgr.url.."company/getOpenEmployLevel.do"
    self:send(url, data, function(data)
        if data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        DataMgr.openEmployee = tonumber(data.result.level) or 0
    end)
end

function Mgr:employee (index, type)
    local url = Mgr.url.."company/employee.do?index="..type.."&position="..index
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

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
        EventMgr:dispatchEvent(e)
        self:updateInfo()
    end)
end

function Mgr:regist (name, tel, pwd, wechat, alipay)
    local url = Mgr.url.."member/registMember.do?gUsername="..name.."&gPassword="..pwd
        .."&gTel="..tel.."&gWeixin="..wechat.."&gZhifubao="..alipay.."&gIsLock=0"
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = REGIST,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:sign ()
    local url = Mgr.url.."company/sign.do"
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

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

function Mgr:steal (tel)
    local url = Mgr.url.."company/getFriendsBenefit.do?tel="..tel
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = COMPANY_STEAL,
            data = data
        }
        EventMgr:dispatchEvent(e)

        self:updateInfo()
    end)
end

function Mgr:sendSuggest (str)
    local url = Mgr.url.."memberMsg/addMessageMsg.do?message="..str
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = SEND_SUGGEST,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

function Mgr:search (tel)
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
    local url = Mgr.url.."transfer/apply.do?toTel="..tel.."&amount="..num
    print(url)
    self:send(url, data, function(data)
        if data.result and data.result.code and data.result.code ~= 0 then
            UIMgr:warn(data.result.message)
            return
        end

        local e = {
            name = TRANSFER,
            data = data
        }
        EventMgr:dispatchEvent(e)
    end)
end

return Mgr
