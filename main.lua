local fortumo = require "plugin.fortumo"
local json = require "json"
local widget = require("widget")

fortumo.init()

local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 1,.5,0 )

local title = display.newText( {text = "Fortumo Plugin", fontSize = 30} )
title.width, title.height = 300, 168
title.x, title.y = display.contentCenterX, 168*.5
title:setFillColor(1,0,0)

local makePayment
makePayment = widget.newButton( {
        x = display.contentCenterX,
        y = display.contentCenterY,
        id = "makePayment",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        label = "Make Payment",
        onEvent = function ( e )
            if (e.phase == "ended") then
               fortumo.pay("Insert Display Name", "Insert Product Name", "nonConsumable", "service id", "app secret", nil, function ( e )
                  print(json.encode(e))
               end)
            end
        end
} )
local getPaymentStatus
getPaymentStatus = widget.newButton( {
        x = display.contentCenterX,
        y = display.contentCenterY,
        id = "getPaymentStatus",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        label = "Get Payment Status",
        onEvent = function ( e )
            if (e.phase == "ended") then
               native.showAlert( "My Product Status:", fortumo.getPaymentStatus("service id", "app secret", "Insert Product Name", function ( e )
                  print(json.encode(e))
               end)), {"Ok"} ) 
            end
        end
} )