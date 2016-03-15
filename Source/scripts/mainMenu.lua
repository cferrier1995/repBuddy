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


return g

end