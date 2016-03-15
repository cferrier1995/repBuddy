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

logoText=display.newText("Rep Buddy", 0, 0, "Helvetica-Bold", screenWidth/10)
logoText.x=centerX
logoText.y =logoImage.y
logoText:setFillColor(1,1,1)
g:insert( logoText )

advisingText=display.newText("Please Set Your options and Press Begin!", 0, 0, "Helvetica", screenWidth/20)
advisingText.x=centerX
advisingText.y =logoImage.y + screenHeight/10
advisingText:setFillColor(1,1,1)
g:insert( advisingText )


dividerLine = display.newRect(0,screenTop,screenWidth- screenWidth/10,screenHeight/250)
dividerLine.x=centerX
dividerLine.y = advisingText.y + screenHeight/20


restRepsTime = 1
restRepsTimeMax = 60
restSetsTime = 3
restSetsTimeMax = 300
numSets = 1
numSetsMax = 100
numReps = 1
numRepsMax = 200
holdTime = 0
holdTimeMax = 60


function incrementValue(event)
    if event.target.type == 1 then
        if numReps >= 1 and numReps < numRepsMax then
            numReps = numReps + 1
            numRepsText.text = "Number of reps: "..numReps
        else
            numReps = 1
            numRepsText.text = "Number of reps: "..numReps
        end
    elseif event.target.type == 2 then
        if numSets >=1 and numSets < numSetsMax then
           numSets = numSets + 1
           numSetsText.text = "Number of sets: "..numSets
        else
            numSets = 1
            numSetsText.text = "Number of sets: "..numSets
        end
    elseif event.target.type == 3 then
        if restSetsTime >=1 and restSetsTime < restSetsTimeMax then
           restSetsTime = restSetsTime + 1
           restSetsTimeText.text = "Break Between Sets: "..restSetsTime.."s"
        else
            restSetsTime = 3
            restSetsTimeText.text = "Break Between Sets: "..restSetsTime.."s"
        end
    elseif event.target.type == 4 then
        if holdTime >=0 and holdTime < holdTimeMax then
           holdTime = holdTime + 1
           holdTimeText.text = "Hold Time : "..holdTime.."s"
        else
            holdTime = 0
            holdTimeText.text = "Hold Time : "..holdTime.."s"
        end
    end
end


function decrementValue(event)
    if event.target.type == 1 then
        if numReps <= numRepsMax and numReps > 1 then
            numReps = numReps - 1
            numRepsText.text = "Number of reps: "..numReps
        else
            numReps = numRepsMax
            numRepsText.text = "Number of reps: "..numReps
        end
    elseif event.target.type == 2 then
        if numSets <= numSetsMax and numSets > 1 then
           numSets = numSets - 1
           numSetsText.text = "Number of sets: "..numSets
        else
            numSets = numSetsMax
            numSetsText.text = "Number of sets: "..numSets
        end
    elseif event.target.type == 3 then
        if restSetsTime <= restSetsTimeMax and restSetsTime > 3 then
           restSetsTime = restSetsTime - 1
           restSetsTimeText.text = "Break Between Sets: "..restSetsTime.."s"
        else
            restSetsTime = restSetsTimeMax
            restSetsTimeText.text = "Break Between Sets: "..restSetsTime.."s"
        end
     elseif event.target.type == 4 then
        if holdTime <= holdTimeMax and holdTime > 0 then
           holdTime = holdTime - 1
           holdTimeText.text = "Hold Time : "..holdTime .."s"
        else
            holdTime = holdTimeMax
            holdTimeText.text = "Hold Time : "..holdTime.."s"
        end
    end
end



incrementorButtons = {}
decrementorButtons = {}



numRepsText=display.newText("Number of reps: 1", 0, 0, "Helvetica", screenWidth/20)
numRepsText.x=screenWidth/4
numRepsText.y =logoImage.y + screenHeight/10 * 2
numRepsText:setFillColor(1,1,1)
g:insert( numRepsText )

decrementorButtons[1] = display.newImageRect("images/Android/leftarrow-2560.png",screenWidth/10,screenHeight/25)
decrementorButtons[1].type = 1 
decrementorButtons[1].x=screenRight - screenWidth/10 * 3
decrementorButtons[1].y = numRepsText.y 
decrementorButtons[1]:setFillColor(78/255,198/255,245/255)
g:insert(decrementorButtons[1])
decrementorButtons[1]:addEventListener("tap",decrementValue)

incrementorButtons[1] = display.newImageRect("images/Android/rightarrow-2560.png",screenWidth/10,screenHeight/25)
incrementorButtons[1].type = 1 
incrementorButtons[1].x=screenRight - screenWidth/10 
incrementorButtons[1].y = numRepsText.y 
incrementorButtons[1]:setFillColor(78/255,198/255,245/255)
g:insert(incrementorButtons[1])
incrementorButtons[1]:addEventListener("tap",incrementValue)


numSetsText=display.newText("Number of sets: 1", 0, 0, "Helvetica", screenWidth/20)
numSetsText.x=screenWidth/4
numSetsText.y =logoImage.y + screenHeight/10 * 2.75
numSetsText:setFillColor(1,1,1)
g:insert( numSetsText )


decrementorButtons[2] = display.newImageRect("images/Android/leftarrow-2560.png",screenWidth/10,screenHeight/25)
decrementorButtons[2].type = 2
decrementorButtons[2].x=screenRight - screenWidth/10 * 3
decrementorButtons[2].y = numSetsText.y 
decrementorButtons[2]:setFillColor(78/255,198/255,245/255)
g:insert(decrementorButtons[2])
decrementorButtons[2]:addEventListener("tap",decrementValue)

incrementorButtons[2] = display.newImageRect("images/Android/rightarrow-2560.png",screenWidth/10,screenHeight/25)
incrementorButtons[2].type = 2
incrementorButtons[2].x=screenRight - screenWidth/10
incrementorButtons[2].y = numSetsText.y 
incrementorButtons[2]:setFillColor(78/255,198/255,245/255)
g:insert(incrementorButtons[2])
incrementorButtons[2]:addEventListener("tap",incrementValue)


restSetsTimeText=display.newText("Break Between Sets: 3s", 0, 0, "Helvetica", screenWidth/20)
restSetsTimeText.x=screenWidth/3.1
restSetsTimeText.y =logoImage.y + screenHeight/10 * 3.5
restSetsTimeText:setFillColor(1,1,1)
g:insert( restSetsTimeText )

decrementorButtons[3] = display.newImageRect("images/Android/leftarrow-2560.png",screenWidth/10,screenHeight/25)
decrementorButtons[3].type = 3
decrementorButtons[3].x=screenRight - screenWidth/10 * 3.0
decrementorButtons[3].y = restSetsTimeText.y 
decrementorButtons[3]:setFillColor(78/255,198/255,245/255)
g:insert(decrementorButtons[3])
decrementorButtons[3]:addEventListener("tap",decrementValue)

incrementorButtons[3] = display.newImageRect("images/Android/rightarrow-2560.png",screenWidth/10,screenHeight/25)
incrementorButtons[3].type = 3
incrementorButtons[3].x=screenRight - screenWidth/10
incrementorButtons[3].y = restSetsTimeText.y 
incrementorButtons[3]:setFillColor(78/255,198/255,245/255)
g:insert(incrementorButtons[3])
incrementorButtons[3]:addEventListener("tap",incrementValue)



holdTimeText=display.newText("Hold Time: 0s", 0, 0, "Helvetica", screenWidth/20)
holdTimeText.x=screenWidth/4.6
holdTimeText.y =logoImage.y + screenHeight/10 * 4.25
holdTimeText:setFillColor(1,1,1)
g:insert( holdTimeText )

decrementorButtons[4] = display.newImageRect("images/Android/leftarrow-2560.png",screenWidth/10,screenHeight/25)
decrementorButtons[4].type = 4
decrementorButtons[4].x=screenRight - screenWidth/10 * 3
decrementorButtons[4].y = holdTimeText.y 
decrementorButtons[4]:setFillColor(78/255,198/255,245/255)
g:insert(decrementorButtons[4])
decrementorButtons[4]:addEventListener("tap",decrementValue)

incrementorButtons[4] = display.newImageRect("images/Android/rightarrow-2560.png",screenWidth/10,screenHeight/25)
incrementorButtons[4].type = 4
incrementorButtons[4].x=screenRight - screenWidth/10
incrementorButtons[4].y = holdTimeText.y 
incrementorButtons[4]:setFillColor(78/255,198/255,245/255)
g:insert(incrementorButtons[4])
incrementorButtons[4]:addEventListener("tap",incrementValue)


beginImage = display.newRoundedRect(0,screenTop,screenWidth/3,screenHeight/15,screenHeight/100)
beginImage:setFillColor(214/255,67/255,46/255)
beginImage.x=centerX
beginImage.y=screenHeight/10 * 7.5
beginImage.strokeWidth = screenHeight/200
beginImage:setStrokeColor(0,0,0)
g:insert(beginImage)

beginText=display.newText("BEGIN", 0, 0, "Helvetica-Bold", screenWidth/20)
beginText.x=centerX
beginText.y =beginImage.y
beginText:setFillColor(1,1,1)
g:insert( beginText )

settingsButton = display.newImageRect("images/Android/wrench-2048.png", screenHeight/12, screenHeight/12)
settingsButton.x=screenRight - settingsButton.width
settingsButton.y=screenHeight/10 * 7.5
g:insert(settingsButton)

questionButton = display.newCircle(0,0,screenHeight/25)
questionButton.x=screenLeft + questionButton.width
questionButton.y=screenHeight/10 * 7.5
questionButton.strokeWidth = screenHeight/200
questionButton:setFillColor(41/255,47/255,125/255)
questionButton:setStrokeColor(41/255,47/255,125/255)
g:insert(questionButton)

questionText=display.newText("?", 0, 0, "Helvetica-Bold", screenWidth/10)
questionText.x=questionButton.x
questionText.y =questionButton.y
questionText:setFillColor(1,1,1)
g:insert( questionText )



function goToQuestion()
settingsButton.alpha = 0
beginImage:removeEventListener("tap",goToMainScreen)
--settingsButton:removeListener("tap",goToSettings)
decrementorButtons[1]:removeEventListener("tap",decrementValue)
decrementorButtons[2]:removeEventListener("tap",decrementValue)
decrementorButtons[3]:removeEventListener("tap",decrementValue)
decrementorButtons[4]:removeEventListener("tap",decrementValue)

incrementorButtons[1]:removeEventListener("tap",incrementValue)
incrementorButtons[2]:removeEventListener("tap",incrementValue)
incrementorButtons[3]:removeEventListener("tap",incrementValue)
incrementorButtons[4]:removeEventListener("tap",incrementValue)
questionText:removeEventListener("tap",goToQuestion)

questionImage = display.newImage("images/Android/ScreenImage.png")
questionImage.x=centerX
questionImage.y=centerY
g:insert(questionImage)


returnButton = display.newRoundedRect(0,screenTop,screenWidth/3*2,screenHeight/10,screenHeight/50)
returnButton:setFillColor(78/255,198/255,245/255)
returnButton.x=centerX
returnButton.y= screenBottom - returnButton.height/1.3
returnButton.strokeWidth = screenHeight/75
returnButton:setStrokeColor(8/255,100/255,204/255)
g:insert(returnButton)

returnButtonText=display.newText("Return", 0, 0, "Helvetica-Bold", screenWidth/10)
returnButtonText.x=centerX
returnButtonText.y =returnButton.y
returnButtonText:setFillColor(1,1,1)
g:insert( returnButtonText )


function destroyQuestion()
settingsButton.alpha = 1
returnButton:removeSelf()
returnButtonText:removeSelf()
questionImage:removeSelf()
returnButtonText:removeEventListener("tap",destroyQuestion)

beginImage:addEventListener("tap",goToMainScreen)
--settingsButton:addListener("tap",goToSettings)
decrementorButtons[1]:addEventListener("tap",decrementValue)
decrementorButtons[2]:addEventListener("tap",decrementValue)
decrementorButtons[3]:addEventListener("tap",decrementValue)
decrementorButtons[4]:addEventListener("tap",decrementValue)

incrementorButtons[1]:addEventListener("tap",incrementValue)
incrementorButtons[2]:addEventListener("tap",incrementValue)
incrementorButtons[3]:addEventListener("tap",incrementValue)
incrementorButtons[4]:addEventListener("tap",incrementValue)
questionText:addEventListener("tap",goToQuestion)
end

returnButtonText:addEventListener("tap",destroyQuestion)
end

questionText:addEventListener("tap",goToQuestion)
function goToSettings()
    director:changeScene("scripts.options","fade")
end

function goToMainScreen()
    _G.myReps = numReps
    _G.myHoldTime = holdTime
    _G.mySetRestTime = restSetsTime
    _G.mySets = numSets
    print(numSets)
    print(_G.mySets)
    director:changeScene("scripts.mainScreen","fade")
end

beginImage:addEventListener("tap",goToMainScreen)
settingsButton:addEventListener("tap",goToSettings)


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