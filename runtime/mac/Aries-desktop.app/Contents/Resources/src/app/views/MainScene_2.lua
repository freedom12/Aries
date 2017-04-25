
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    local sp = display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)
    local glProgramState = cc.GLProgramState:getOrCreateWithGLProgramName("ShaderUIGrayScale")
    sp:setGLProgramState(glProgramState)

    -- add HelloWorld label
    local lab = cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)
    local glProgramState = cc.GLProgramState:getOrCreateWithGLProgramName("ShaderLabelOutline")
    lab:setGLProgramState(glProgramState)
    lab:enableOutline(cc.c4b(0.5, 0.5, 0.5, 1), 5)
    local eventMgr = cc.load("event"):create()
    eventMgr:bind(self)

    eventMgr:addEventListener("test", function(e)
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", e.name, e.data)
    end)

    local e = {
        name = "test",
        data = "hhhh"
    }
    eventMgr:dispatchEvent(e)

    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    -- xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    -- xhr:open("GET", "http://www.panguclub.net:8080/bossCountry/member/showMember.do?id=1")

    xhr:open("GET", "http://www.panguclub.net:8080/bossCountry/member/login.do?gTel=13313313311&gPassWord=123123")
    -- xhr:setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
    local function onReadyStateChange()
        local response = json.decode(xhr.response, 1)
        dump(response)
        local session = xhr:getResponseHeader("Set-Cookie")
        session = string.split(session, ";")[1]
        session = string.trim(session)

        local xhr = cc.XMLHttpRequest:new()
        xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
        xhr:open("GET", "http://www.panguclub.net:8080/bossCountry/member/showMember.do")
        xhr:setRequestHeader("Cookie", session)
        xhr:registerScriptHandler(function()
            local response = json.decode(xhr.response, 1)
            print("Http Status Code:"..xhr.statusText, xhr.status)
            dump(response)
            local user = response.user
            user.gSex = 0
            user.gQiantaiexpdate = nil
            local xhr = cc.XMLHttpRequest:new()
            xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
            xhr:open("POST", "http://www.panguclub.net:8080/bossCountry/member/updateMemberInfo.do")
            xhr:setRequestHeader("Cookie", session)
            -- xhr:setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8")
            xhr:registerScriptHandler(function()
                local response = json.decode(xhr.response, 1)
                dump(response)
            end)
            -- str = string.urlencode(str)
            local str = "gUsername=hahahah"
            -- local str = "gPassword=123123123"
            print(str)
            xhr:send(str)
        end)
        xhr:send()
    end

    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send()
end

return MainScene

-- 1.网络通信
-- 2.文本输入
-- 3.自适应
-- 4.事件系统
-- 5.json
--[[

gAddraddress=qweqweqwe&
id=1&
gPasswordii=4297f44b13955235245b2497399d7a93&
gPassword=4297f44b13955235245b2497399d7a93&
gGuwen=0&
gUsername=monika&
gAddrpostcode=123123&
gQiandao=1&
gLogins=1&
gTel=13313313311&
gQiantai=1&
gWeixin=123123&
gInvitenum=0&
gZhifubao=123123@qq.com&
gJinbi=0&
gIslock=0&
gCaiwuchu=0&
gExtrarate=0&
gSex=0&
gLevel=0
]]
