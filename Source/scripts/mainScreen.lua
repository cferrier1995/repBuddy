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
local yesSound = audio.loadSound("soundFx/Affirmative Voice 1.mp3")
local noSound = audio.loadSound("soundFx/Negative Voice 1.mp3")
local texttospeech = require('plugin.texttospeech')



savedOptions = preference.getValue("settingsTable")
if savedOptions == nil then
savedOptions = {3,150,true}
preference.save{settingsTable = savedOptions}
end



_G.startDelay = savedOptions[1]
_G.numWeight = savedOptions[2]
_G.isLbs = savedOptions[3]


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

_G.isSoundFxOn = true


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

function playYes( )
if _G.isSoundFxOn then
audio.play(yesSound)
end
end

function playNo( )
if _G.isSoundFxOn then
audio.play(noSound)
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


logoText=display.newText("Please press start and place your phone on your back!", 0, 0, "Helvetica-Bold", screenWidth/30)
logoText.x=centerX
logoText.y =screenHeight/11
logoText:setFillColor(1,1,1)
g:insert( logoText )

hintText=display.newText("", 0, 0, "Helvetica-Bold", screenWidth/15)
hintText.x=centerX
hintText.y =screenHeight/11* 10
hintText:setFillColor(1,1,1)
g:insert( hintText )



dividerLine = display.newRect(0,screenTop,screenWidth- screenWidth/10,screenHeight/250)
dividerLine.x=centerX
dividerLine.y = logoText.y + screenHeight/20
g:insert(dividerLine)


incrementorButtons = {}
decrementorButtons = {}

_G.startDelay = savedOptions[1]
_G.numWeight = savedOptions[2]
_G.isLbs = savedOptions[3]

thisStartDelay = _G.startDelay
thisNumWeight = _G.numWeight
thisLbs = _G.isLbs

thisReps = _G.myReps
thisSets = _G.mySets
thisSetRestTime = _G.mySetRestTime
thisHoldTime =_G.myHoldTime

startButton = display.newCircle(0,screenTop,screenHeight/10)
startButton.x =centerX
startButton.y =centerY
g:insert(startButton)


startButtonText=display.newText("START!", 0, 0, "Helvetica-Bold", screenWidth/15)
startButtonText.x=startButton.x
startButtonText.y =startButton.y
startButtonText:setFillColor(1,0,0)
g:insert( startButtonText )


function calcPushupCal(count, weight)
  weight=weight*.67
  kg=weight*.453592
  joule=kg*9.8*.32
  totalCal=joule*.000239006
  total=totalCal*count
  return total/4
end



numHalfReps = 0
repsCompleted = 0
setsCompleted = 0
canRun = true
numTimeHold = 1
cooldown = 1200 --To Prevent bad detection from one movement, this value requires they move somewhat slow
inputAllowed = true
detectionThreshold = 15
waitForLowerBound = false;
lowerBound = 10

function allowInput()
    inputAllowed = true
end

ttsRate = 1.25;
isFirstRun = false
function checkForSets(event)
    if canRun == true then
        xChange = math.floor(event.xInstant * 100)
        yChange = math.floor(event.yInstant * 100)
        zChange = math.floor(event.zInstant * 100)
        totalChange = math.floor(math.sqrt(xChange * xChange + yChange * yChange + zChange * zChange))

        if totalChange > detectionThreshold and inputAllowed == true then
            waitForLowerBound = true;
            inputAllowed = false
        end

        if waitForLowerBound == true and totalChange < lowerBound then

        	waitForLowerBound = false;
            inputAllowed = false
            timer.performWithDelay(cooldown, allowInput)
            numHalfReps = numHalfReps + 1
            if numHalfReps % 2 == 0 then
                repsCompleted = repsCompleted + 1
            end
            canRun = false



            function speakDelay()
               texttospeech.speak(numTimeHold, {rate = ttsRate})  
               numTimeHold = numTimeHold + 1
            end

            function unDelay()
               numTimeHold = 1
                    if thisHoldTime ~= 0 then
                        timer.cancel(myNameTimer)
                    end
                    if numHalfReps % 2 ~= 0 then
                        startButtonText.text = repsCompleted
                        function goRepsRest( ... )
                            if repsCompleted % 5 == 0 then
                                texttospeech.speak(repsCompleted.." Reps Completed", {rate = ttsRate})
                                repsRestTimer.isActive = false
                            end
                        end
                        function goUpRest( ... )
                            texttospeech.speak("Up", {rate = ttsRate})
                            restTimer.isActive = false
                        end

                        numTalkDif = 3500
                        if repsCompleted % 5 == 0 then
                            repsRestTimer = timer.performWithDelay(500,goRepsRest)
                            repsRestTimer.isActive = true 
                            numTalkDif = 0
                        end
                        restTimer = timer.performWithDelay(4000 - numTalkDif,goUpRest)
                        restTimer.isActive = true
                   else
                        function goDownRest( ... )
                            restTimer2.isActive = false
                            texttospeech.speak("Down", {rate = ttsRate})
                        end
                        restTimer2 = timer.performWithDelay(500,goDownRest)
                        restTimer2.isActive = true
                   end
                   if(repsCompleted == thisReps and numHalfReps/2 > repsCompleted) then
                        texttospeech.speak('Set Finished, Well Done!', {rate = ttsRate})  
                        startButtonText.text = "Finished Set!"
                        hintText.text = "Resting!"
                        if restTimer~= nil and restTimer.isActive == true then
                        timer.cancel(restTimer)
                        end
                        Runtime:removeEventListener("accelerometer", checkForSets)
                        setsCompleted = setsCompleted + 1
                        function countSet()
                        if repsRestTimer ~= nil and  repsRestTimer.isActive == true then
                        timer.cancel(repsRestTimer)
                        end
                        if restTimer ~= nil and restTimer.isActive == true then
                        timer.cancel(restTimer)
                        end
                        if setsCompleted == thisSets then
                        playCompletedLevel()
                        texttospeech.speak('Workout Complete', {rate = ttsRate}) 
                        showSummaryScreen()
                        else
                        repsCompleted = 0
                        canRun = true
                        numHalfReps = 0
                        thisStartDelay = thisSetRestTime
                        startTimer = timer.performWithDelay(1000,countDownToStart,thisStartDelay)
                        end
                        end
                    countSet()
                   end
               canRun = true
            end
            if thisHoldTime ~= 0 then
                texttospeech.speak("HOLD", {rate = ttsRate}) 
                myNameTimer = timer.performWithDelay(1000, speakDelay, thisHoldTime)
                delayTimer = timer.performWithDelay(thisHoldTime * 1000,unDelay)
            else
                unDelay()
            end
        end
    end
end

print(thisSets)

function ohItsList( ... )
hintText.text = "Workout In Progress"
texttospeech.speak('Up', {rate = ttsRate})
numHalfReps = numHalfReps + 1
startButtonText.text = repsCompleted
Runtime:addEventListener("accelerometer", checkForSets)
end

function startIt()
startButtonText.text = thisStartDelay
startButton:removeEventListener("tap",startIt)


function countDownToStart()
    thisStartDelay = thisStartDelay - 1
    startButtonText.text = thisStartDelay
    if thisStartDelay == 0 then
    Runtime:removeEventListener("accelerometer",clearAcclData)
    ohItsList()
    end
end

function clearAcclData()
end
Runtime:addEventListener("accelerometer",clearAcclData)
startTimer = timer.performWithDelay(1000,countDownToStart,thisStartDelay)
end
startButton:addEventListener("tap",startIt)


function goHome()
    Runtime:removeEventListener("accelerometer", checkForSets)
    director:changeScene("scripts.interface","fade")
end


function showSummaryScreen()

shadowRect = display.newRect(0,screenTop,screenWidth,screenHeight)
shadowRect.alpha = 0
shadowRect:setFillColor(41/255,47/255,125/255)
shadowRect.x=centerX
shadowRect.y = centerY
g:insert(shadowRect)

shadowTrans = transition.to(shadowRect,{alpha = 1,delay = 500,time = 500})


summaryLogoText=display.newText("Summary", 0, 0, "Helvetica-Bold", screenWidth/10)
summaryLogoText.x=centerX
summaryLogoText.y =screenHeight/11
summaryLogoText:setFillColor(1,1,1)
g:insert( summaryLogoText ) 
summaryLogoText.alpha = 0

dividerLine = display.newRect(0,screenTop,screenWidth- screenWidth/10,screenHeight/250)
dividerLine.x=centerX
dividerLine.y = logoText.y + screenHeight/20
g:insert(dividerLine)
dividerLine.alpha = 0

summaryTrans = transition.to(summaryLogoText,{alpha = 1,delay=1000,time= 500})
dividerTrans = transition.to(dividerLine,{alpha = 1,delay=1000,time= 500})

repsCompletedText=display.newText("Reps: ".._G.myReps, 0, 0, "Helvetica-Bold", screenWidth/10)
repsCompletedText.x=centerX
repsCompletedText.y =screenHeight/11 * 4.25
repsCompletedText:setFillColor(1,1,1)
g:insert( repsCompletedText ) 
repsCompletedText.alpha = 0

repsTrans = transition.to(repsCompletedText,{alpha = 1,delay=1700,time= 500})

setsCompletedText=display.newText("Sets: ".._G.mySets, 0, 0, "Helvetica-Bold", screenWidth/10)
setsCompletedText.x=centerX
setsCompletedText.y =screenHeight/11 * 5.25
setsCompletedText:setFillColor(1,1,1)
g:insert( setsCompletedText ) 
setsCompletedText.alpha = 0

setsTrans = transition.to(setsCompletedText,{alpha = 1,delay=2400,time= 500})

caloriesBurnedText=display.newText("Calories: "..math.floor(_G.mySets * _G.myReps * .7), 0, 0, "Helvetica-Bold", screenWidth/10)
caloriesBurnedText.x=centerX
caloriesBurnedText.y =screenHeight/11 * 6.25
caloriesBurnedText:setFillColor(1,1,1)
g:insert( caloriesBurnedText ) 
caloriesBurnedText.alpha = 0

calorieTrans = transition.to(caloriesBurnedText,{alpha = 1,delay=3100,time= 500})


returnHomeText=display.newText("Return to Main Menu!", 0, 0, "Helvetica-Bold", screenWidth/20)
returnHomeText.x=centerX
returnHomeText.y =screenHeight/11 * 10.25
returnHomeText:setFillColor(1,1,1)
g:insert( returnHomeText ) 
returnHomeText.alpha = 0


returnHomeText:addEventListener("tap",goHome)
returnHomeTrans = transition.to(returnHomeText,{alpha = 1,delay=3800,time= 500})
end


return g

end