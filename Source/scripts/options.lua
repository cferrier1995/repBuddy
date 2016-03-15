----main menu
--------------------------------------------------
centerX = display.contentCenterX
centerY = display.contentCenterY
screenX = display.screenOriginX
screenY = display.screenOriginY
screenWidth = display.contentWidth - screenX * 2
screenHeight = display.contentHeight - screenY * 2
screenLeft = screenX
screenRight = screenX + screenWidth
screenTop = screenY
screenBottom = screenY + screenHeight
display.contentWidth = screenWidth
display.contentHeight = screenHeight
--------------------------------------------------
 --display.setDefault( "background", 3, 144, 255 )
module( ..., package.seeall )

local director=require("director")
local preference = require "preference"

_G.currentScreen = "dailyPlay"

local correctSoundEffect = audio.loadSound("soundFx/Right 2.mp3")
local correctSoundEffect2 = audio.loadSound("soundFx/Right 4.mp3")
local correctSoundEffect3 = audio.loadSound("soundFx/Right 5.mp3")
local completedSound = audio.loadSound("soundFx/Event 3.mp3")
local wrongSoundEffect = audio.loadSound("soundFx/Wrong 5.mp3")

--audio.setVolume(1)

--[[
 local ads = require "ads"
if system.getInfo( "platformName" ) == "Android" then
 amazonAds = require "plugin.amazonAds"
end



local gameNetwork = require "gameNetwork"
local utility = require( "utility" )
local json = require "json"
local mySettings
achs=preference.getValue("achTable")

loggedIntoGC=preference.getValue("loggedInVar")
if loggedIntoGC==nil then
loggedIntoGC=false
end

--local facebook = require "facebook"
--local appId ="614202838597557"
_G.screenName="menu"
_G.isPremium=false
if system.getInfo("targetAppStore") == "amazon" ==true then
_G.testAmazon=true
gamecircle = require("plugin.gamecircle")
gamecircle.Init(true, true,false)

else
_G.testAmazon=false
end
]]--


function printTable(myList)
local myString = "{"
for i = 1, #myList do
myString = myString..tostring(myList[i])..","
end
myString = string.sub(myString,1,string.len(myString)-1)
myString = myString.."}"
print(myString)
end

local xScale
local yScale
local scale
varLa = ""

function findBestMatch()
      if system.getInfo( "platformName" ) == "Android" then
        swizz = "Android"
        if screenHeight < 960 then
        ImageSuffix = "-960"
        hizzy = 540
        wizzy = 960
        elseif screenHeight < 1024 then
        ImageSuffix="-1024"
        hizzy = 600
        wizzy = 1024
        elseif screenHeight < 1920 then
        ImageSuffix = "-1920"
        hizzy = 1200
        wizzy = 1920
        elseif screenHeight < 2560 or screenHeight > 2560 then
        ImageSuffix = "-2560"
        hizzy = 1600
        wizzy = 2560
        end
      else
        swizz = "IOS"
        if screenHeight < 960 then
        ImageSuffix = "-960"
       -- hizzy = 640
        --wizzy = 960
        varLa = "BOO"
                hizzy = 1600
        wizzy = 2560
        elseif screenHeight < 1024 then
        ImageSuffix = "-1024"
        hizzy = 768
        wizzy = 1024
        elseif screenHeight < 1136 then
        ImageSuffix = "-1136"
        hizzy = 640
        wizzy = 1136
        elseif screenHeight < 1920 then
        ImageSuffix = "-1920"
        hizzy = 1080
        wizzy = 1920
        elseif screenHeight < 2048 or screenHeight > 2048 then
        ImageSuffix = "-2560"
        hizzy = 2048
        wizzy = 1536
        end
      end
    end
if screenHeight == 800 or screenHeight== 854 then 
        ImageSuffix = "-960" 
        swizz="Android"
        hizzy=540
        wizzy=960
elseif system.getInfo( "platformName" ) == "Android" and screenHeight==480 and screenWidth==320 then
 ImageSuffix = "-960" 
        swizz="Android"
        hizzy=540
        wizzy=960

elseif screenHeight==480 then
    ImageSuffix = "-960" 
        swizz="IOS"
        hizzy=640
        wizzy=960
    elseif screenHeight==960 and screenWidth ==640 then 
        ImageSuffix = "-960"
        swizz="IOS"
         hizzy=640
        wizzy=960
elseif screenHeight ==960 and screenWidth ==540  then
ImageSuffix ="-960"
swizz ="Android"
hizzy=540
wizzy=960

    elseif screenHeight==1024 and screenWidth == 768 then
        ImageSuffix = "-1024"
        swizz="IOS" 
        hizzy=768
        wizzy=1024

    elseif screenHeight==1024 and screenWidth == 600 then
        ImageSuffix = "-1024"
swizz="Android" 
hizzy=600
wizzy=1024
    elseif screenHeight==1136 then
        ImageSuffix = "-1136" 
        swizz="IOS"
        hizzy=640
        wizzy=1136
    elseif screenHeight==1280 or screenWidth==720 then 
        ImageSuffix="-1920"
        swizz="Android"
        hizzy=1200
        wizzy=1920
    elseif screenHeight==1920 or screenWidth==1080 or screenWidth==1200 and system.getInfo( "platformName" ) == "Android" then
        ImageSuffix="-1920"
        swizz="Android"
        hizzy=1200
        wizzy=1920
    elseif screenHeight==2048 then
        ImageSuffix="-2560"
        swizz="IOS"
        hizzy=2048
        wizzy=1536

    elseif screenHeight==2560 or screenWidth==1600 then
        ImageSuffix="-2560"
        swizz="Android"
        hizzy=1600
        wizzy=2560

    elseif screenHeight==1334 or screenWidth==750 then
        ImageSuffix="-1920"
        swizz="IOS"
        hizzy=1200
        wizzy=1920

    elseif screenHeight==1920 or screenWidth==1080 and system.getInfo( "platformName" ) ~= "Android"  then
      ImageSuffix="-1920"
      hizzy=1200
      wizzy=1920
    else
    findBestMatch()
    end


function scaleMe(photo)
ratioP1=screenWidth/hizzy
ratioP2=screenHeight/wizzy
xScale = ratioP2
yScale = ratioP1
scale = math.min( xScale, yScale )
photo:scale( scale, scale )

end

function table.shuffle(t)
        math.randomseed(os.time())
        assert(t, "table.shuffle() expected a table, got nil")
        local iterations = #t
        local j
        for i = iterations, 2, -1 do
                j = math.random(i)
                t[i], t[j] = t[j], t[i]
        end
end





local function onKeyEvent( event )
    local keyname = event.keyName
    if event.phase == "up" and event.keyName=="back" then
            if _G.screenName=="menu" then

            elseif _G.screenName=="options" then
            director:changeScene("scripts.mainMenu","fade")
            elseif _G.screenName=="matches" then
            director:changeScene("scripts.options","fade")
             elseif _G.screenName=="scores" then
            director:changeScene("scripts.mainMenu","fade")
            end
    end

    return true;

end


function playCorrect( )
if _G.isSoundFxOn then
math.randomseed(os.time())
numRand = math.random(1,3)
if numRand == 1 then
audio.play(correctSoundEffect)
elseif numRand == 2 then
audio.play(correctSoundEffect2 )
else
audio.play(correctSoundEffect3 )
end
end
end

function playCompletedLevel()
if _G.isSoundFxOn then
audio.play(completedSound)
end

end


function playWrong( )
if _G.isSoundFxOn then
math.randomseed(os.time())
numRand = math.random(1)
if numRand == 1 then
audio.play(wrongSoundEffect)
elseif numRand == 2 then
audio.play(correctSoundEffect2 )
else
audio.play(correctSoundEffect3 )
end
end
end

--if system.getInfo( "platformName" ) == "Android" then  Runtime:addEventListener( "key", onKeyEvent ) end


function new()

local g = display.newGroup()


savedOptions = preference.getValue("settingsTable")
if savedOptions == nil then
savedOptions = {3,150,true}
preference.save{settingsTable = savedOptions}
end



_G.startDelay = savedOptions[1]
_G.numWeight = savedOptions[2]
_G.isLbs = savedOptions[3]

print(_G.startDelay)
print(_G.numWeight)
print(_G.isLbs)

local background = display.newRect(0,screenTop,screenWidth,screenHeight)
background:setFillColor(4/255,115/255,242/255)
background.x = centerX
background.y = centerY
g:insert(background)


logoImage = display.newRoundedRect(0,screenTop,screenWidth/3*2,screenHeight/10,screenHeight/50)
logoImage:setFillColor(78/255,198/255,245/255)
logoImage.x=centerX
logoImage.y=screenHeight/10
logoImage.strokeWidth = screenHeight/75
logoImage:setStrokeColor(8/255,100/255,204/255)
g:insert(logoImage)

logoText=display.newText("Settings", 0, 0, "Helvetica-Bold", screenWidth/10)
logoText.x=centerX
logoText.y =logoImage.y
logoText:setFillColor(1,1,1)
g:insert( logoText )


advisingText=display.newText("", 0, 0, "Helvetica", screenWidth/20)
advisingText.x=centerX
advisingText.y =logoImage.y + screenHeight/10
advisingText:setFillColor(1,1,1)
g:insert( advisingText )


dividerLine = display.newRect(0,screenTop,screenWidth- screenWidth/10,screenHeight/250)
dividerLine.x=centerX
dividerLine.y = advisingText.y + screenHeight/20


restRepsTime = 1
restRepsTimeMax = 60
restSetsTime = 1
restSetsTimeMax = 300
numWeightsMin = 75
numWeights = _G.numWeight
numWeightsMax = 500
numStartDelay = _G.startDelay
numStartDelayMax = 30
holdTime = 1
holdTimeMax = 60
weightType = "Lbs"
isLbs = _G.isLbs

if isLbs then
weightType = "Lbs"
else
weightType = "Kgs"
end




function incrementValue(event)
    if event.target.type == 1 then
        if numStartDelay >= 1 and numStartDelay < numStartDelayMax then
            numStartDelay = numStartDelay + 1
            startDelayText.text = "Start Delay: "..numStartDelay.."s"
        else
            numStartDelay = 3
            startDelayText.text = "Start Delay: "..numStartDelay.."s"
        end
    elseif event.target.type == 2 then
        if numWeights >=numWeightsMin and numWeights < numWeightsMax then
           numWeights = numWeights + 1
           numWeightsText.text = "Weight("..weightType.."): "..numWeights
        else
            numWeights = numWeightsMin
            numWeightsText.text = "Weight("..weightType.."): "..numWeights
        end
    end
end


function decrementValue(event)
    if event.target.type == 1 then
        if numStartDelay <= numStartDelayMax and numStartDelay > 3 then
            numStartDelay = numStartDelay - 1
            startDelayText.text = "Start Delay: "..numStartDelay.."s"
        else
            numStartDelay = numStartDelayMax
            startDelayText.text = "Start Delay: "..numStartDelay.."s"
        end
    elseif event.target.type == 2 then
        if numWeights <= numWeightsMax and numWeights > numWeightsMin then
           numWeights = numWeights - 1
           numWeightsText.text = "Weight("..weightType.."): "..numWeights
        else
            numWeights = numWeightsMax
            numWeightsText.text = "Weight("..weightType.."): "..numWeights
        end
    end
end



incrementorButtons = {}
decrementorButtons = {}



startDelayText=display.newText("Start Delay: "..numStartDelay.."s", 0, 0, "Helvetica", screenWidth/20)
startDelayText.x=screenWidth/4
startDelayText.y =logoImage.y + screenHeight/10 * 2
startDelayText:setFillColor(1,1,1)
g:insert( startDelayText )

decrementorButtons[1] = display.newImageRect("images/Android/leftarrow-2560.png",screenWidth/10,screenHeight/25)
decrementorButtons[1].type = 1 
decrementorButtons[1].x=screenRight - screenWidth/10 * 3
decrementorButtons[1].y = startDelayText.y 
decrementorButtons[1]:setFillColor(78/255,198/255,245/255)
g:insert(decrementorButtons[1])
decrementorButtons[1]:addEventListener("tap",decrementValue)

incrementorButtons[1] =  display.newImageRect("images/Android/rightarrow-2560.png",screenWidth/10,screenHeight/25)
incrementorButtons[1].type = 1 
incrementorButtons[1].x=screenRight - screenWidth/10
incrementorButtons[1].y = startDelayText.y 
incrementorButtons[1]:setFillColor(78/255,198/255,245/255) 
g:insert(incrementorButtons[1])
incrementorButtons[1]:addEventListener("tap",incrementValue)





numWeightsText=display.newText("Weight("..weightType.."): "..numWeights, 0, 0, "Helvetica", screenWidth/20)
numWeightsText.x=screenWidth/4
numWeightsText.y =logoImage.y + screenHeight/10 * 2.75
numWeightsText:setFillColor(1,1,1)
g:insert( numWeightsText )

decrementorButtons[2] = display.newImageRect("images/Android/leftarrow-2560.png",screenWidth/10,screenHeight/25)
decrementorButtons[2].type = 2
decrementorButtons[2].x=screenRight - screenWidth/10 * 3
decrementorButtons[2].y = numWeightsText.y 
decrementorButtons[2]:setFillColor(78/255,198/255,245/255)
g:insert(decrementorButtons[2])
decrementorButtons[2]:addEventListener("tap",decrementValue)

incrementorButtons[2] = display.newImageRect("images/Android/rightarrow-2560.png",screenWidth/10,screenHeight/25)
incrementorButtons[2].type = 2
incrementorButtons[2].x=screenRight - screenWidth/10 
incrementorButtons[2].y = numWeightsText.y
incrementorButtons[2]:setFillColor(78/255,198/255,245/255) 
g:insert(incrementorButtons[2])
incrementorButtons[2]:addEventListener("tap",incrementValue)





changeKiloText=display.newText("Use Kilograms", 0, 0, "Helvetica", screenWidth/20)
changeKiloText.x=screenWidth/4
changeKiloText.y =logoImage.y + screenHeight/10 * 3.5
changeKiloText:setFillColor(1,1,1)
g:insert( changeKiloText )

changeKiloButton = display.newCircle(0,0,screenHeight/30)
changeKiloButton.x = screenWidth/4*3.25
changeKiloButton.y = changeKiloText.y
changeKiloButton:setFillColor(51/255,77/255,142/255)
changeKiloButton.strokeWidth = screenHeight/150
changeKiloButton:setStrokeColor(51/255,77/255,142/255)


g:insert(changeKiloButton)

changeKiloBText =display.newText("ON", 1, 1, "Helvetica-Bold", screenWidth/20)
changeKiloBText.x = changeKiloButton.x
changeKiloBText.y = changeKiloButton.y
changeKiloBText:setFillColor(1,1,1)
g:insert(changeKiloBText)


function changeLbs()
    if isLbs then
        isLbs = false
        changeKiloBText.text = "ON"
        changeKiloBText:setFillColor(1,1,1)
        weightType = "Kgs"
        numWeightsText.text = "Weight("..weightType.."): "..numWeights
    else
        isLbs = true
        changeKiloBText.text = "OFF"
        changeKiloBText:setFillColor(1,1,1)
        weightType = "Lbs"
        numWeightsText.text = "Weight("..weightType.."): "..numWeights 
    end
end

changeKiloButton:addEventListener("tap",changeLbs)

saveImage = display.newRoundedRect(0,screenTop,screenWidth/3,screenHeight/15,screenHeight/100)
saveImage:setFillColor(214/255,67/255,46/255)
saveImage.x=centerX
saveImage.y=screenHeight/10 * 7.5
saveImage.strokeWidth = screenHeight/200
saveImage:setStrokeColor(0,0,0)
g:insert(saveImage)

saveText=display.newText("SAVE", 0, 0, "Helvetica-Bold", screenWidth/25)
saveText.x=centerX
saveText.y =saveImage.y
saveText:setFillColor(1,1,1)
g:insert( saveText )



function goHome()
    director:changeScene("scripts.interface","fade")
end

function saveSettings()
  print("I promise I'm working")
  savedOptions[1] = numStartDelay
  savedOptions[2] = numWeights
  savedOptions[3] = isLbs
  preference.save{settingsTable = savedOptions}
  hintText.alpha = 1
  stopTrans = transition.to(hintText,{alpha=0,time=500,delay=500})
end

backButton = display.newImageRect("images/Android/back-2048.png", screenHeight/12, screenHeight/12)
backButton.x=screenLeft + backButton.width
backButton.y=screenHeight/10 * 7.5
g:insert(backButton)

backButton:addEventListener("tap",goHome)


hintText=display.newText("Saved!", 0, 0, "Helvetica-Bold", screenWidth/10)
hintText.x=centerX
hintText.y =screenBottom - screenHeight/11
hintText:setFillColor(1,1,1)
hintText.alpha = 0
g:insert( hintText )

saveImage:addEventListener("tap",saveSettings )


if isLbs then
weightType = "Lbs"
changeKiloBText.text = "OFF"
changeKiloBText:setFillColor(1,1,1)
else
weightType = "Kgs"
changeKiloBText.text = "ON"
changeKiloBText:setFillColor(1,1,1)
end


--[[

xAxisData=display.newText("X: 0", 0, 0, "GeosansLight", screenWidth/10)
xAxisData.x=centerX
xAxisData.y =screenHeight/3 - screenHeight/6
xAxisData:setFillColor(239/255,250/255,240/255)
g:insert( xAxisData )


xAxisData=display.newText("X: 0", 0, 0, "GeosansLight", screenWidth/10)
xAxisData.x=centerX
xAxisData.y =screenHeight/3 - screenHeight/6
xAxisData:setFillColor(239/255,250/255,240/255)
g:insert( xAxisData )

yAxisData=display.newText("Y: 0", 0, 0, "GeosansLight", screenWidth/10)
yAxisData.x=centerX
yAxisData.y =screenHeight/3 * 2 - screenHeight/6
yAxisData:setFillColor(239/255,250/255,240/255)
g:insert( yAxisData )


zAxisData=display.newText("Z: 0", 0, 0, "GeosansLight", screenWidth/10)
zAxisData.x=centerX
zAxisData.y =screenHeight/3 * 3 - screenHeight/6
zAxisData:setFillColor(239/255,250/255,240/255)
g:insert( zAxisData )



function changeData(event)
xAxisData.text = "X: "..event.xInstant
yAxisData.text = "Y: "..event.yInstant
zAxisData.text = "Z: "..event.zInstant
end

Runtime:addEventListener("accelerometer", changeData)
]]--

return g

end