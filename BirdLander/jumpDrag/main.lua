-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- font check function I didn't want to loose. 
-- local sysFonts = native.getFontNames()
-- for k,v in pairs(sysFonts) do print(v) end

display.setDefault( "fillColor", 0, 0, 0)
display.setDefault( "strokeColor", 0, 0, 0)
display.setDefault( "textColor", 0, 0, 0)
display.setDefault( "lineColor", 0, 0, 0)

w = display.contentWidth
h = display.contentHeight

display.setStatusBar(display.HiddenStatusBar);

local physics = require "physics"
physics.start()
gravDown = 8
physics.setGravity( 0, gravDown)

bg1 = display.newRect( 0, 0, w, h)
bg1:setFillColor(200,160,110)

gameLevel = display.newGroup()
controlLevel = display.newGroup()
feedBackLevel = display.newGroup()
menueLevel = display.newGroup()
topLevel = display.newGroup()

 coinGrab = audio.loadSound("gameSounds/coinGrab.wav")
 flap2 = audio.loadSound("gameSounds/flap2.wav")
 hit1 = audio.loadSound("gameSounds/hit1.wav")
 landed1 = audio.loadSound("gameSounds/landed1.wav")
 smashDown1 = audio.loadSound("gameSounds/smashDown1.wav")
 splashDown1 = audio.loadSound("gameSounds/splashDown1.wav")
 tap1 = audio.loadSound("gameSounds/tap1.wav")
 tap2 = audio.loadSound("gameSounds/tap2.wav")
 unlock1 = audio.loadSound("gameSounds/unlock1.wav")

-- audio.play(hit1)

------------------------------------------------------------------------------
---- Here is where we give the players FEEDBACK -----------------



--objectx = display.newText( "@10FirstGames", 30, h/2 + 20, "Helvetica", 16 )

active = false

function clearMessage()
	thisMessage.text = ""
	display.remove(thisMessage)
	thisMessage = nil
	active = false
end

function clearOtherMessage()
	otherMessage.text = ""
	display.remove(otherMessage)
	otherMessage = nil
	active = false
end

function feedBack(eventName, string, arg)
	if active == false then
		thisMessage = display.newText("",  w + w/4, h/2 + 55, "ArcadeClassic", 78 )
		thisMessage.text = string
		thisMessage.x = thisMessage.x + thisMessage.contentWidth
		feedBackLevel:insert(thisMessage)
		transition.to( thisMessage, { time=3000, alpha=1, x=(0 - (thisMessage.contentWidth + 10)) } )
		timerName = timer.performWithDelay(3000, clearMessage)
		active = true
	elseif eventName == "Landed" then
		timer.cancel( timerName )
		transition.to( thisMessage, { time=100, alpha=0 } )
		timerName = timer.performWithDelay(100, clearMessage)

		otherMessage = display.newText("",  w + w/4, h/2 + 55, "ArcadeClassic", 78 )
		otherMessage.text = string
		otherMessage.x = otherMessage.x + otherMessage.contentWidth
		feedBackLevel:insert(otherMessage)
		transition.to( otherMessage, { time=3000, alpha=1, x=(0 - (otherMessage.contentWidth + 10)) } )
		timerName = timer.performWithDelay(3000, clearOtherMessage)
		active = true
	elseif eventName == "longShot" then
		timer.cancel( timerName )
		transition.to( thisMessage, { time=100, alpha=0 } )
		timerName = timer.performWithDelay(100, clearMessage)

		otherMessage = display.newText("",  w + w/4, h/2 + 55, "ArcadeClassic", 78 )
		otherMessage.text = string
		otherMessage.x = otherMessage.x + otherMessage.contentWidth
		feedBackLevel:insert(otherMessage)
		transition.to( otherMessage, { time=3000, alpha=1, x=(0 - (otherMessage.contentWidth + 10)) } )
		timerName = timer.performWithDelay(3000, clearOtherMessage)
		active = true
	end
end

function showMessage(playerLandingForce)
	audio.play(landed1)
	if playerLandingForce < 5 then 
		feedBack("Landed", "Soft Touch! ")
	elseif playerLandingForce < 10 then
		feedBack("Landed", "Solid landing! ")
	elseif playerLandingForce <= 50 then
		feedBack("Landed", "Landed! ")
	elseif playerLandingForce > 50 then
		feedBack("Landed", "Ruff Landing! ")
	end
end

function missTarget()
	if playerLanded == false then
		misses = misses + 1
	end
	if misses < 5 then
		rand = math.random(100)
		if rand > 80 then
			feedBack("missLanding", "Almost.", misses)
		elseif rand > 60 then
			feedBack("missLanding", "OHhhhh.", misses)
		elseif rand > 40 then
			feedBack("missLanding", "Dang it!", misses)
		elseif rand > 20 then
			feedBack("missLanding", "Miss!", misses) 
		elseif rand < 20 then
			feedBack("missLanding", "Fail."	, misses)
		end
	elseif misses < 10 then
		rand = math.random(100)
		if rand > 80 then
			feedBack("missLanding", "Over 5 fails now.", misses)
		elseif rand > 60 then
			feedBack("missLanding", "Man...", misses)
		elseif rand > 40 then
			feedBack("missLanding", "Come on!", misses)
		elseif rand > 20 then
			feedBack("missLanding", "You got this!", misses)
		elseif rand < 20 then
			feedBack("missLanding", "Ahhhhhh.", misses)	
		end
	elseif misses < 15 then
		rand = math.random(100)
		if rand > 95 then
			feedBack("missLanding", "Over 10 fails now.", misses)
		elseif rand > 90 then
			feedBack("missLanding", "OHhhhh!", misses)
		elseif rand > 85 then
			feedBack("missLanding", "Almost?", misses)
		elseif rand > 80 then
			feedBack("missLanding", "Dang it!", misses)
		elseif rand < 75 then
			feedBack("missLanding", "Miss!"	, misses)
		elseif rand > 70 then
			feedBack("missLanding", "Fail.", misses)
		elseif rand > 65 then
			feedBack("missLanding", "Dont give up!", misses)
		elseif rand > 60 then
			feedBack("missLanding", "Man...", misses)
		elseif rand > 55 then
			feedBack("missLanding", "NO! NO! NO!", misses)
		elseif rand > 50 then
			feedBack("missLanding", "You got this!"	, misses)
		elseif rand > 45 then
			feedBack("missLanding", "Ahhhhhh..", misses)
		elseif rand > 40 then
			feedBack("missLanding", "Dont give up!", misses)
		elseif rand > 35 then
			feedBack("missLanding", "...", misses)
		elseif rand > 30 then
			feedBack("missLanding", "I don't...", misses)
		elseif rand < 30 then
			feedBack("missLanding", "It hurst me...", misses)	
		end
	end
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

function initVars()

sideSpeed = 0
speedHorz = 0
downSpeed = 0
speedVert = 0
sideSpeedAtDeath = 0
downSpeedAtDeath = 0
sideSpeedAtLanding = 0
downSpeedAtLanding = 0
sideSpeedAtMiss = 0
mostBounces = 0

topHeight = 0
curHeight = 0

iBounce = 0
aroundTheWorld = 0
howManyFeet = 0
lastHit = 0
upFlaps = 0
leftFlaps = 0
rightFlaps = 0
totalFlaps = 0
playerLanded = false
killCount = 0
playerObjectLanded = false
playerLandingForce = 0
landedRecently = false
inTheZone = false -- it means you are in the landing zone. 
misses = 0
screenLap = 0
lowLaps = 0
cutPower = false
nextLevelNow = false
lastFlapX = 0
lastFlapY = 0
landedAtX = 0
landedAtY = 0
cutPower = false
playerHitSound = 0
timeToCheck = true

end


-- level 1 ---------------------------------------------------------------------
local function level1()
setupLevel = display.newGroup()
gameLevel:insert(setupLevel)

initVars()

sky = display.newRect(0, 0, w, h/2)
sky:setFillColor(40,170,230)

ground = display.newRect(-w/2, 230, w*2, 10)
ground:setFillColor(140,198,63)
physics.addBody(ground, "static", { density = 1.0, friction = 0.1, bounce = .1} )
ground.myName = "ground"

--noFlyZone = display.newRect(200,-80, 160, 280)
--physics.addBody( noFlyZone, "kinematic", { friction=0} )
--noFlyZone:setFillColor(0,0,0,10)
--noFlyZone.isPlatform = true
--noFlyZone.isSensor = true
--noFlyZone.myName = "noFlyZone"

playerObject = display.newRect(30, -100, 20, 20)
playerObject:setFillColor(255,0,0)
playerObject:setStrokeColor(0, 0, 0) 
playerObject.strokeWidth = 2
physics.addBody(playerObject, { density = 5.0, friction = 1.0, bounce = 0 } )

platform1 = display.newRect(20,200, 40, 30)
platform1:setFillColor(50, 50, 50) 
physics.addBody( platform1, "kinematic", { friction=0.7, bounce = 0.1 } )
platform1.isPlatform = true -- custom flag, used in drag function
platform1.myName = "ground"

platform2 = display.newRect(60,200, 40, 30)
platform2:setFillColor(50, 50, 50) 
physics.addBody( platform2, "kinematic", { friction=0.7, bounce = 0.1 } )
platform2.isPlatform = true -- custom flag, used in drag function
platform2.myName = "ground"

nest = display.newRect(260,190, 40, 40)
physics.addBody( nest, "kinematic", { friction=0.7 } )
nest:setFillColor(90,50,20,255)
nest.isPlatform = true
nest.myName = "theNest"

landingZone = display.newRect(260,160, 40, 40)
physics.addBody( landingZone, "kinematic", { friction=0.7 } )
landingZone:setFillColor(0,0,0,0)
landingZone.isPlatform = true
landingZone.isSensor = true
landingZone.myName = "landingZone"

setupLevel:insert(sky)
--setupLevel1:insert(noFlyZone)
setupLevel:insert(nest)
setupLevel:insert(ground)
setupLevel:insert(playerObject)
setupLevel:insert(platform1)
setupLevel:insert(platform2)
setupLevel:insert(landingZone)

end
---------------------------------------------------------------------------------

-- level 2 ---------------------------------------------------------------------
local function level2()
setupLevel = display.newGroup()
gameLevel:insert(setupLevel)

initVars()

sky = display.newRect(0, 0, w, h/2)
sky:setFillColor(40,170,230)

ground = display.newRect(-w/2, 230, w*2, 10)
ground:setFillColor(140,198,63)
physics.addBody(ground, "static", { density = 1.0, friction = 0.1, bounce = .1} )

--noFlyZone = display.newRect(200,-80, 160, 280)
--physics.addBody( noFlyZone, "kinematic", { friction=0} )
--noFlyZone:setFillColor(0,0,0,10)
--noFlyZone.isPlatform = true
--noFlyZone.isSensor = true
--noFlyZone.myName = "noFlyZone"

playerObject = display.newRect(30, -100, 20, 20)
playerObject:setFillColor(255,0,0)
playerObject:setStrokeColor(0, 0, 0) 
playerObject.strokeWidth = 2
physics.addBody(playerObject, { density = 5.0, friction = 1.0, bounce = 0 } )

platform1 = display.newRect(20,100, 40, 30)
platform1:setFillColor(50, 50, 50) 
physics.addBody( platform1, "kinematic", { friction=0.7, bounce = 0.1 } )
platform1.isPlatform = true -- custom flag, used in drag function

nest = display.newRect(230,60, 40, 40)
physics.addBody( nest, "kinematic", { friction=0.7 } )
nest:setFillColor(90,50,20,255)
nest.isPlatform = true
nest.myName = "theNest"

landingZone = display.newRect(230,30, 40, 40)
physics.addBody( landingZone, "kinematic", { friction=0.7 } )
landingZone:setFillColor(0,0,0,0)
landingZone.isPlatform = true
landingZone.isSensor = true
landingZone.myName = "landingZone"

setupLevel:insert(sky)
--setupLevel1:insert(noFlyZone)
setupLevel:insert(ground)
setupLevel:insert(playerObject)
setupLevel:insert(platform1)
setupLevel:insert(nest)
setupLevel:insert(landingZone)
end

-- level 3  ---------------------------------------------------------------------
local function level3()
setupLevel = display.newGroup()
gameLevel:insert(setupLevel)

initVars()

sky = display.newRect(0, 0, w, h/2)
sky:setFillColor(40,170,230)

ground = display.newRect(-w/2, 230, w*2, 10)
ground:setFillColor(140,198,63)
physics.addBody(ground, "static", { density = 1.0, friction = 0.1, bounce = .1} )

--noFlyZone = display.newRect(200,-80, 160, 280)
--physics.addBody( noFlyZone, "kinematic", { friction=0} )
--noFlyZone:setFillColor(0,0,0,10)
--noFlyZone.isPlatform = true
--noFlyZone.isSensor = true
--noFlyZone.myName = "noFlyZone"

playerObject = display.newRect(30, -100, 20, 20)
playerObject:setFillColor(255,0,0)
playerObject:setStrokeColor(0, 0, 0) 
playerObject.strokeWidth = 2
physics.addBody(playerObject, { density = 5.0, friction = 1.0, bounce = 0 } )

platform1 = display.newRect(160,60, 40, 30)
platform1:setFillColor(50, 50, 50) 
physics.addBody( platform1, "kinematic", { friction=0.7, bounce = 0.1 } )
platform1.isPlatform = true -- custom flag, used in drag function

platform2 = display.newRect(200,90, 40, 30)
platform2:setFillColor(50, 50, 50) 
physics.addBody( platform2, "kinematic", { friction=0.7, bounce = 0.1 } )
platform2.isPlatform = true -- custom flag, used in drag function

nest = display.newRect(160,120, 40, 40)
physics.addBody( nest, "kinematic", { friction=0.7 } )
nest:setFillColor(90,50,20,255)
nest.isPlatform = true
nest.myName = "theNest"

landingZone = display.newRect(160,90, 40, 40)
physics.addBody( landingZone, "kinematic", { friction=0.7 } )
landingZone:setFillColor(0,0,0,0)
landingZone.isPlatform = true
landingZone.isSensor = true
landingZone.myName = "landingZone"

setupLevel:insert(sky)
--setupLevel1:insert(noFlyZone)
setupLevel:insert(nest)
setupLevel:insert(ground)
setupLevel:insert(playerObject)
setupLevel:insert(platform1)   
setupLevel:insert(platform2)
setupLevel:insert(landingZone)

end
---------------------------------------------------------------------------------

-- level 4  ---------------------------------------------------------------------
local function level4 ()
setupLevel = display.newGroup()
gameLevel:insert(setupLevel)

initVars()

sky = display.newRect(0, 0, w, h/2)
sky:setFillColor(40,170,230)

ground = display.newRect(-w/2, 230, w*2, 10)
ground:setFillColor(140,198,63)
physics.addBody(ground, "static", { density = 1.0, friction = 0.1, bounce = .1} )

--noFlyZone = display.newRect(200,-80, 160, 280)
--physics.addBody( noFlyZone, "kinematic", { friction=0} )
--noFlyZone:setFillColor(0,0,0,10)
--noFlyZone.isPlatform = true
--noFlyZone.isSensor = true
--noFlyZone.myName = "noFlyZone"

playerObject = display.newRect(30, -100, 20, 20)
playerObject:setFillColor(255,0,0)
playerObject:setStrokeColor(0, 0, 0) 
playerObject.strokeWidth = 2
physics.addBody(playerObject, { density = 5.0, friction = 1.0, bounce = 0 } )

platform1 = display.newRect(10,80, 40, 30)
platform1:setFillColor(50, 50, 50) 
physics.addBody( platform1, "kinematic", { friction=0.7, bounce = 0.1 } )
platform1.isPlatform = true -- custom flag, used in drag function

platform2 = display.newRect(50,110, 40, 30)
platform2:setFillColor(50, 50, 50) 
physics.addBody( platform2, "kinematic", { friction=0.7, bounce = 0.1 } )
platform2.isPlatform = true -- custom flag, used in drag function

nest = display.newRect(10,140, 40, 40)
physics.addBody( nest, "kinematic", { friction=0.7 } )
nest:setFillColor(90,50,20,255)
nest.isPlatform = true
nest.myName = "theNest"

landingZone = display.newRect(10,110, 40, 40)
physics.addBody( landingZone, "kinematic", { friction=0.7 } )
landingZone:setFillColor(0,0,0,0)
landingZone.isPlatform = true
landingZone.isSensor = true
landingZone.myName = "landingZone"

setupLevel:insert(sky)
--setupLevel1:insert(noFlyZone)
setupLevel:insert(nest)
setupLevel:insert(ground)
setupLevel:insert(playerObject)
setupLevel:insert(platform1)   
setupLevel:insert(platform2)
setupLevel:insert(landingZone)

end
---------------------------------------------------------------------------------


-- level 5  ---------------------------------------------------------------------
local function level5()
setupLevel = display.newGroup()
gameLevel:insert(setupLevel)

initVars()

sky = display.newRect(0, 0, w, h/2)
sky:setFillColor(40,170,230)

ground = display.newRect(-w/2, 230, w*2, 10)
ground:setFillColor(0,113,188)
ground.myName = "ground"
--physics.addBody(ground, "static", { density = 1.0, friction = 0.1, bounce = .1} )

--noFlyZone = display.newRect(200,-80, 160, 280)
--physics.addBody( noFlyZone, "kinematic", { friction=0} )
--noFlyZone:setFillColor(0,0,0,10)
--noFlyZone.isPlatform = true
--noFlyZone.isSensor = true
--noFlyZone.myName = "noFlyZone"

playerObject = display.newRect(210, -100, 20, 20)
playerObject:setFillColor(255,0,0)
playerObject:setStrokeColor(0, 0, 0) 
playerObject.strokeWidth = 2
physics.addBody(playerObject, { density = 5.0, friction = 1.0, bounce = 0 } )

platform1 = display.newRect(160,60, 40, 30)
platform1:setFillColor(50, 50, 50) 
physics.addBody( platform1, "kinematic", { friction=0.7, bounce = 0.1 } )
platform1.isPlatform = true -- custom flag, used in drag function

platform2 = display.newRect(200,90, 40, 30)
platform2:setFillColor(50, 50, 50) 
physics.addBody( platform2, "kinematic", { friction=0.7, bounce = 0.1 } )
platform2.isPlatform = true -- custom flag, used in drag function

nest = display.newRect(160,120, 40, 40)
physics.addBody( nest, "kinematic", { friction=0.7 } )
nest:setFillColor(90,50,20,255)
nest.isPlatform = true
nest.myName = "theNest"

landingZone = display.newRect(155,90, 40, 40)
physics.addBody( landingZone, "kinematic", { friction=0.7 } )
landingZone:setFillColor(0,0,0,0)
landingZone.isPlatform = true
landingZone.isSensor = true
landingZone.myName = "landingZone"

setupLevel:insert(sky)
--setupLevel1:insert(noFlyZone)
setupLevel:insert(nest)
setupLevel:insert(ground)
setupLevel:insert(playerObject)
setupLevel:insert(platform1)   
setupLevel:insert(platform2)
setupLevel:insert(landingZone)

end
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------  End OF Levels  ----------------------------------------
----------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function checkForAroundTheWorld(lowLaps)
	if aroundTheWorld < lowLaps then
		aroundTheWorld = lowLaps
	end
end


function killItOff()
	if sideSpeedAtDeath < math.floor(sideSpeed) then
		sideSpeedAtDeath = math.floor(sideSpeed)
	end
	if downSpeedAtDeath < math.floor(downSpeed) then
		downSpeedAtDeath = math.floor(downSpeed)
	end
	checkForAroundTheWorld(lowLaps)
	audio.play(smashDown1)
	feedBack("death", "You Just Died")
	killCount = killCount + 1
	playerObject.y = playerObject.y - 300
	playerObject.linearDamping = 5
	playerObject:applyLinearImpulse( 0, -10, playerObject.x, playerObject.y )
	playerObject:applyLinearImpulse( 0, -10, playerObject.x, playerObject.y )
	playerObject:applyLinearImpulse( 0, -10, playerObject.x, playerObject.y )
end


function makeTopGhost()
	topGhost = display.newRect(20, 0, 10, 10)
	setupLevel:insert(topGhost)
	topGhost:setFillColor(255,255,255,0)
	topGhost:rotate( 45 )
end

function followPlayer(playerObject)
		topGhost.y = 20
		topGhost.x = playerObject.x
		if playerObject.y < 0 then
		topGhost:setFillColor(255,255,255,200)
			--physics.setGravity( 0, gravDown * 10)
		else
			topGhost:setFillColor(255,255,255,0)
			if falling == false then
			physics.setGravity( 0, gravDown)
			end
		end
end

function keepPlayerOnScreen(playerObject)
	speedHorz, speedVert = playerObject:getLinearVelocity()
	if speedHorz < 0 then
		speedHorz = speedHorz * -1
	end
	if speedVert < 0 then
		speedVert = speedVert * -1
	end
	if sideSpeed < speedHorz/10 then
		sideSpeed = speedHorz/10
	end
	if downSpeed < speedVert/10 then
		downSpeed = speedVert/10
	end

	if playerObject.y > 0 then
		curHeight = playerObject.y
		curHeight = math.floor(curHeight/10)
	elseif playerObject.y < 0 then
		curHeight = (playerObject.y * -1) + h/2
		curHeight = math.floor(curHeight/10)
	end 

	if topHeight < curHeight then
		topHeight = curHeight
	end 


	if playerObject.x > w+20 then
		playerObject.x = -15
		screenLap = screenLap + 1
		if playerObject.y > 0 then
			lowLaps = lowLaps + 1
			checkForAroundTheWorld(lowLaps)
		end
	elseif playerObject.x < -20 then
		playerObject.x = w+15
		screenLap = screenLap + 1
		if playerObject.y > 0 then
			lowLaps = lowLaps + 1
			checkForAroundTheWorld(lowLaps)
		end
	end
	if playerObject.y > h/2 then
		audio.play(splashDown1)
		killItOff()
	end
	if playerObject.y > 0 then
		playerObject.linearDamping = 0
	end
end

 -- 

function clearDistMarker()
	display.remove(xDistanceRect)
	display.remove(xDistancePlayerMarkerRect)
	display.remove(distLine)

end

function getDistanceSoar()
	landedAtX = playerObject.x
	landedAtY = playerObject.y
	if screenLap == 0 then
		xDist = landedAtX - lastFlapX
		if xDist < 0 then
			xDist = xDist * -1 
		end
		if xDist > 150 then
			xDistanceRect = display.newRect(lastFlapX,playerObject.y - 25, 2, 10)
			xDistancePlayerMarkerRect = display.newRect(playerObject.x,playerObject.y - 25, 2, 10)
			distLine = display.newLine(xDistanceRect.x,xDistanceRect.y, xDistancePlayerMarkerRect.x,xDistancePlayerMarkerRect.y )
			
			gameLevel:insert(xDistanceRect)
			gameLevel:insert(xDistancePlayerMarkerRect)
			gameLevel:insert(distLine)

			xDist = xDist/10
			howManyFeet = math.floor (xDist)
			timer.performWithDelay(2000, clearDistMarker)
			feedBack("longShot", "From " .. howManyFeet .. " feet away!", howManyFeet)
		end
	elseif screenLap > 1 then
		xDist = ((landedAtX - lastFlapX) - w)*-1
		print("screenLap = true 2")
		feedBack("longShot", "WHAT! AROUND THE WORLD!!!")
		howManyFeet = "off screen ".. screenLap .." times"
	elseif screenLap > 0 then
		xDist = ((landedAtX - lastFlapX) - w)*-1
		print("screenLap = true")
		feedBack("longShot", "From off screen!")
		howManyFeet = "off Screen"
	end
end

------------------------------------------------------------------------------------------------------------------------
--------- Player Controll Group  --------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
function goLeft()
	if cutPower == true then
		-- do nothing now
	elseif cutPower == false then
		checkForAroundTheWorld(lowLaps)
		playerObject:applyLinearImpulse( -3, -3, playerObject.x, playerObject.y )
		lastFlapX = playerObject.x
		lastFlapY = playerObject.y
		screenLap = 0
		lowLaps = 0
		iBounce = 0
		leftFlaps = leftFlaps + 1
		lastHit = timeText.text
		audio.play(flap2)
	end
end

function goRight()
	if cutPower == true then
		-- do nothing now
	elseif cutPower == false then
		checkForAroundTheWorld(lowLaps)
		playerObject:applyLinearImpulse( 3, -3, playerObject.x, playerObject.y )
		lastFlapX = playerObject.x
		lastFlapY = playerObject.y
		screenLap = 0
		lowLaps = 0
		iBounce = 0
		rightFlaps = rightFlaps + 1
		lastHit = timeText.text
		audio.play(flap2)
	end
end

function jump()
	if cutPower == true then
		-- do nothing now
	elseif cutPower == false then
		checkForAroundTheWorld(lowLaps)
		playerObject:applyLinearImpulse( 0, -10, playerObject.x, playerObject.y )
		lastFlapX = playerObject.x
		lastFlapY = playerObject.y
		screenLap = 0
		lowLaps = 0
		iBounce = 0
		upFlaps = upFlaps + 1
		lastHit = timeText.text
		audio.play(flap2)
	end
end
 
function setUpControlls(playWithOneHand)
	controlGroup = display.newGroup()
	controlLevel:insert(controlGroup)
	controlGroup.y = 0
	controlGroup.x = 0

	controlBg = display.newRect( 0, h/2, w, h/2)
	controlBg:setFillColor(200,160,110)

	lButt = display.newImage( "leftBut.png", left, top )
	lButt.x = 60
	lButt.y = 400

	upButt = display.newImage( "upBut.png", left, top ) --lol
	upButt.x = 160
	upButt.y = 400

	rButt = display.newImage( "rightBut.png", left, top )
	rButt.x = 260
	rButt.y = 400

	controlGroup:insert(controlBg)
	controlGroup:insert(lButt)
	controlGroup:insert(upButt)
	controlGroup:insert(rButt)

	if playWithOneHand == true then
		lButt:addEventListener("tap", goLeft)
		upButt:addEventListener("tap", jump)
		rButt:addEventListener("tap", goRight)
		--bButt:addEventListener("tap", dive)
	elseif playWithOneHand == false then
		rButt.x = 160
		rButt.y = 400
		upButt.x = 260
		upButt.y = 400
		lButt:addEventListener("tap", goLeft)
		upButt:addEventListener("tap", jump)
		rButt:addEventListener("tap", goRight)
		--bButt:addEventListener("tap", dive)
	end
end




------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-------  playChallenge  --------------------------------------------------------
local function playChallenge()


makeTopGhost()

function levelTimer(varX, varY)
	timeHolder = display.newGroup()
	secsText = 00
	minsText = 0

	timeText = display.newText(minsText.. ":0" ..secsText, 40, 40, "ArcadeClassic", 24)
	timeText:setTextColor(0,0,0)
	timeText.x = varX
	timeText.y = varY

	local function updateTime (event)
		secsText = secsText + 1
		if secsText < 10 then secsText = "0" ..secsText elseif secsText > 59 then
			secsText = "0" .. "0"
			minsText = minsText+1
		end
			timeText.text = minsText .. ":" ..secsText
	end
	theLevelTimer = timer.performWithDelay(1000, updateTime, 0)
	timeHolder:insert(timeText)
	feedBackLevel:insert(timeHolder)
end

function clearLevelTimer()
	timer.cancel(theLevelTimer)
	display.remove(timeHolder)
	secsText = "0" .. "0"
	minsText = 0
end

levelTimer(40, 10 + h/2)

function checkPlayerHit()
	-- check every other frame
	if timeToCheck == false then
		-- dont check
		timeToCheck = true
	elseif timeToCheck == true then
		timeToCheck = false
		if playerHitSound > 2 then
			if inTheZone == true then
				print("Super Jump-----------------------------------------------------------------------------------")
				playerObject:applyLinearImpulse( 3, 0, playerObject.x, playerObject.y )
				playerHitSound = 0
			end
		end
		if playerHitSound > 1 then
			if inTheZone == true then
				print("Jump-----------------------------------------------------------------------------------")
				playerObject:applyLinearImpulse( 0, -4, playerObject.x, playerObject.y )
				playerHitSound = 0
			end
		end
		if playerHitSound > 0 then
			playerHitSound = playerHitSound - 1
		end
	end
end

function gameIsRunning(event)
	followPlayer(playerObject)
	keepPlayerOnScreen(playerObject)
	checkPlayerHit()
end


Runtime:addEventListener( "enterFrame", gameIsRunning )


---------------- This happens after the player hits anything ----------
-- It checks to see what the player hit. and decides what to do. --------
-- lots of landing logic -----------------------------------------------
-------------------------------------------------------------------------------

function endLevel()
	nextLevelNow = true
end

function landed(event)
	if inTheZone == true then
			if playerObject.isAwake == false then
				if playerLanded ==  false then

					if sideSpeedAtLanding< math.floor(sideSpeed) then
						sideSpeedAtLanding = math.floor(sideSpeed)
					end
					if downSpeedAtLanding < math.floor(downSpeed) then
						downSpeedAtLanding = math.floor(downSpeed)
					end

					showMessage(playerLandingForce)
					getDistanceSoar()
					timer.performWithDelay(20, endLevel) ------------------------------------------------------------
					playerLanded = true
				end
			else
				timer.performWithDelay(20, landed)
			end
	else
		missTarget()
		if sideSpeedAtMiss < math.floor(sideSpeed) then
			sideSpeedAtMiss = math.floor(sideSpeed)
			print("miss at " .. sideSpeedAtMiss .. " speed")
		end
	end
end

function checkForLanding(self, event)
	if event.other.myName == "landingZone" then
		if event.phase == "began" then
			inTheZone = true
			timer.performWithDelay(20, landed) -------------------------------------------------------------------------
		elseif event.phase == "ended" then
			inTheZone = false
		end
	end
	if event.other.myName == "ground" then
		if event.phase == "began" then
			iBounce = iBounce + 1
			if iBounce > mostBounces then
				mostBounces = iBounce
				print("Most bounces there: " .. mostBounces)
			end
		end
	end
end

function checkForLandingForce(event)
	landedRecently = false
end



function forceOfLanding(self, event)
	--print(working)

	if event.force > 1 then
		audio.play(hit1)
		playerHitSound = playerHitSound + 1
		if landedRecently == false then
			landedRecently = true
			timer.performWithDelay(1000, checkForLandingForce)
			playerLandingForce = event.force
			playerLandingForce = math.floor (playerLandingForce)
			--timer.performWithDelay(1000, clearMessage)
			if playerLandingForce > 50 then
				
				timer.performWithDelay(10, killItOff)
			end
		end
	end
end

playerObject.collision = checkForLanding
playerObject.postCollision = forceOfLanding
playerObject:addEventListener( "collision", playerObject)
playerObject:addEventListener( "postCollision", playerObject)

end -- end playGame()
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------




----Titel page------------------------------------------------------------------
function titleBg()
setupTitle = display.newGroup()
playWithOneHand = true

testRect = display.newRect(0, 0, 10, 10)
testRect:setFillColor(140,198,63)
setupTitle:insert(testRect)

titleBg = display.newImage( "titleBg.png", left, top )
setupTitle:insert(titleBg)

playWithOneHandBut = display.newImage( "playWithOneHandBut.png", left, top )
setupTitle:insert(playWithOneHandBut)
playWithOneHandBut.x = 160
playWithOneHandBut.y = 305

playWithTwoHandsBut = display.newImage( "playWithTwoHandsBut.png", left, top )
setupTitle:insert(playWithTwoHandsBut)
playWithTwoHandsBut.x = 160
playWithTwoHandsBut.y = 415

function playGameWithOneHand()
	audio.play(tap1)
	setUpControlls(true)
	level1()
	playChallenge()
	makeTopGhost()
	display.remove(setupTitle)
end

function playGameWithTwoHands()
	audio.play(tap1)
	setUpControlls(false)
	level1()
	playChallenge()
	makeTopGhost()
	display.remove(setupTitle)
end

playWithOneHandBut:addEventListener( "tap", playGameWithOneHand)
playWithTwoHandsBut:addEventListener( "tap", playGameWithTwoHands)

end
--------------------------------------------------------------------------------
function listener1()
	killLevelPicker  = true
end

function levelPickerFunction()

	nextLevelNow = false
	timeToUse = 100
	
	levelPicker = display.newGroup()
	menueLevel:insert(levelPicker)

	--draw BackGround
	levelPickerBG = display.newRect( -40, -40, w, h)
	levelPickerBG:setFillColor(200,160,110)
	levelPicker:insert(levelPickerBG)
	levelPicker.x = -500 
	levelPicker.y = 40 

	b1 = display.newRect(0, 0, 80, 80)
	b1:setFillColor(40,170,230)
	b1.x = 20
	b1.y = 40
	levelPicker:insert(b1) 
	function tapB1()
		audio.play(unlock1)
		display.remove(setupLevel)
		setupLevel = nil
		level1()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	b1:addEventListener( "tap", tapB1)

	b2 = display.newRect(0, 0, 80, 80)
	b2:setFillColor(40,170,230)
	b2.x = 120
	b2.y = 40
	levelPicker:insert(b2)
	function tapB2()
		audio.play(unlock1)
		display.remove(setupLevel)
		setupLevel = nil
		level2()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	b2:addEventListener( "tap", tapB2) 

	b3 = display.newRect(0, 0, 80, 80)
	b3:setFillColor(40,170,230)
	b3.x = 220
	b3.y = 40
	levelPicker:insert(b3)
	function tapB3()
		audio.play(unlock1)
		display.remove(setupLevel)
		setupLevel = nil
		level3()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	b3:addEventListener( "tap", tapB3) 

	b4 = display.newRect(0, 0, 80, 80)
	b4:setFillColor(40,170,230)
	b4.x = 20
	b4.y = 150
	levelPicker:insert(b4)
	function tapB4()
		audio.play(unlock1)
		display.remove(setupLevel)
		setupLevel = nil
		level4()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	b4:addEventListener( "tap", tapB4) 

	b5 = display.newRect(0, 0, 80, 80)
	b5:setFillColor(40,170,230)
	b5.x = 120
	b5.y = 150
	levelPicker:insert(b5)
	function tapB5()
		audio.play(unlock1) 
		display.remove(setupLevel)
		setupLevel = nil
		level5()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	b5:addEventListener( "tap", tapB5) 

	b6 = display.newRect(0, 0, 80, 80)
	b6:setFillColor(40,170,230)
	b6.x = 220
	b6.y = 150
	levelPicker:insert(b6)
	function tapB6()
		display.remove(setupLevel)
		setupLevel = nil
		level6()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	--b6:addEventListener( "tap", tapB6) 

	b7 = display.newRect(0, 0, 80, 80)
	b7:setFillColor(40,170,230)
	b7.x = 20
	b7.y = 260
	levelPicker:insert(b7)
	function tapB7()
		display.remove(setupLevel)
		setupLevel = nil
		level7()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	--b7:addEventListener( "tap", tapB7) 

	b8 = display.newRect(0, 0, 80, 80)
	b8:setFillColor(40,170,230)
	b8.x = 120
	b8.y = 260
	levelPicker:insert(b8)
	function tapB8()
		display.remove(setupLevel)
		setupLevel = nil
		level8()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	--b8:addEventListener( "tap", tapB8) 

	b9 = display.newRect(0, 0, 80, 80)
	b9:setFillColor(40,170,230)
	b9.x = 220
	b9.y = 260
	levelPicker:insert(b9)
	function tapB9()
		display.remove(setupLevel)
		setupLevel = nil
		level9()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	--b9:addEventListener( "tap", tapB9) 

	b10 = display.newRect(0, 0, 80, 80)
	b10:setFillColor(40,170,230)
	b10.x = 20
	b10.y = 370
	levelPicker:insert(b10)
	function tapB10()
		display.remove(setupLevel)
		setupLevel = nil
		level10()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	--b10:addEventListener( "tap", tapB10) 

	b11 = display.newRect(0, 0, 80, 80)
	b11:setFillColor(40,170,230)
	b11.x = 120
	b11.y = 370
	levelPicker:insert(b11)
	function tapB11()
		display.remove(setupLevel)
		setupLevel = nil
		level11()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	--b11:addEventListener( "tap", tapB11) 

	b12 = display.newRect(0, 0, 80, 80)
	b12:setFillColor(40,170,230)
	b12.x = 220
	b12.y = 370
	levelPicker:insert(b12)
	function tapB12()
		display.remove(setupLevel)
		setupLevel = nil
		level12()
		makeTopGhost()
		playChallenge()
		handle = transition.to( levelPicker, {time = timeToUse, x = levelPicker.x - 500, onComplete=listener1 })
	end
	--b12:addEventListener( "tap", tapB12)

	function sendItIn()
		handleIn = transition.to( levelPicker, {time = timeToUse, x = 40})
	end

	timer.performWithDelay(2000, sendItIn)

end

function endLevel()
	if nextLevelNow == true then
		playerObject:applyLinearImpulse( 0, -10, playerObject.x, playerObject.y )
		cutPower = true
		levelPickerFunction() -- ends the level and calls the menue
		totalFlaps = upFlaps + leftFlaps + rightFlaps
		print("") -- spacer
		print("") -- spacer
		print("Level win with " .. totalFlaps .. " flaps!") -- how many flaps used in level
		print("And with the time of " .. timeText.text)     -- What the clock ended at
		print("And with the last touch at " .. lastHit)     -- The time on the clock with the last player action
		print("from " .. howManyFeet .. " feet away")		-- Distance of player from nest on last player action x
		print("You missed atleast " .. misses .. " times")
		print("At one point the bird whent across the screen " .. aroundTheWorld .. " times by itself!")
		print("You died " .. killCount .. " times")			-- How many deaths
		print("Top sideSpeed was " .. math.floor(sideSpeed) ..  " feet a second.") -- top side speed in level 
		print("Top downSpeed was " .. math.floor(downSpeed) ..  " feet a second.") -- top down speed in level 
		print("sideSpeedAtDeath was " .. sideSpeedAtDeath)						   -- top side speed at death 
		print("downSpeedAtDeath was " .. downSpeedAtDeath)						   -- top down speed at death 
		print("sideSpeedAtLanding was " .. sideSpeedAtLanding)					   -- top side speed at landing 
		print("downSpeedAtLanding was " .. downSpeedAtLanding)					   -- top down speed at landing 
		print("Top side speed at miss was " .. sideSpeedAtMiss)					   -- top side speed at miss 
		print("The heighst you flew was " .. topHeight .. " feet up.")			   -- the Heighest you went.  
		clearLevelTimer()
		if upFlaps < 1 then
			print("EPIC - no use of Up flaps")				-- How many UP flaps
		end
		if leftFlaps < 1 then
			print("No use of left flaps")					-- How many LEFT flaps
		end
		if rightFlaps < 1 then
			print("No use of right flaps")					-- How many RIGHT flaps
		end     
		if iBounce > 0 then
			print("And you bounced " .. iBounce .. " in to the landing") -- did they bounce in to the landing and how many times
		end
	end
		if killLevelPicker == true then
			display.remove(levelPicker)
			levelPicker = nil
			killLevelPicker = false
		end
end

Runtime:addEventListener( "enterFrame", endLevel )
titleBg()

-- other things I want to track: -----------------------------------------------------------------------------
-- has the playerobject gone acrosse the screen without being touched. how many times.                 -- done
-- bounce to landing?                                                                                  -- done

-- speed of player object
-- -- speed at time of crash to death ()  down speed and side speed                                    -- done
-- -- speed at miss? (flyby) (buzzing the tower)                                                       -- done

-- Distance of player from nest on last player action Y (we already have the x)
-- height of player object
-- -- height of fall to death
-- -- height of fall to water. 
-- -- height of fall to landing. 

--- other things I want to have in the levels ----------------------------------------------------------------
-- Bird AI / enemy birds (this would be good for the title screen)
-- clouds
-- wind (blow you to the side), rain (make it harder to fly), huricane (random-ish grav movements)
-- moving obsticals
-- Coins or other pickups for bonus levels
-- fly Zone targets for bonus levels 
-- things that kill the bird - like the water. 

--- other things I want in the game ----------------------------------------------------------------
-- a good achievent system based on everything you do being tracked. 
-- a good way to show what you have done on each level. 
-- a way to twitter and facebook youre acoomlishments
-- everything in jetpack joyride
-- 500 levels
-- an easy way to rate the game
-- some good music - with 500 levels I should get more than one track...
-- a better way to move between levels

-- a way to get to some optins so you can
-- -- change your controll setup
-- -- change the sound

