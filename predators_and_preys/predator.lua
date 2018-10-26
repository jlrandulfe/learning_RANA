
--The following global values are set via the simulation core:
-- ------------------------------------
-- IMMUTABLES.
-- ------------------------------------
-- ID -- id of the agent.
-- STEP_RESOLUTION 	-- resolution of steps, in the simulation core.
-- EVENT_RESOLUTION	-- resolution of event distribution.
-- ENV_WIDTH -- Width of the environment in meters.
-- ENV_HEIGHT -- Height of the environment in meters.
-- ------------------------------------
-- VARIABLES.
-- ------------------------------------
-- PositionX	 	-- Agents position in the X plane.
-- PositionY	 	-- Agents position in the Y plane.
-- DestinationX 	-- Agents destination in the X plane. 
-- DestinationY 	-- Agents destination in the Y plane.
-- StepMultiple 	-- Amount of steps to skip.
-- Speed 			-- Movement speed of the agent in meters pr. second.
-- Moving 			-- Denotes wether this agent is moving (default = false).
-- GridMove 		-- Is collision detection active (default = false).
-- ------------------------------------

-- Import Rana lua modules.
Agent = require "ranalib_agent"
Stat = require "ranalib_statistic"
Move = require "ranalib_movement"
Collision = require "ranalib_collision"
Event = require "ranalib_event"


function initializeAgent()
    say("Predator #: " .. ID .. " has been initialized")
    Agent.changeColor{r=255, g=0, b=0}
    
    Speed = 100
    GridMove = true
end


function takeStep()
    -- Event for scanning for preys
    Event.emit{speed=343, description="predator_scan"}
    -- Do random moves if iddle
    if not Moving then
        local movement = Stat.randomInteger(1, 5)
        if movement == 1 then
            if PositionY < ENV_HEIGHT then
                Move.to{x=PositionX, y=PositionY+1}
            end
        elseif movement == 2 then
            if PositionX < ENV_WIDTH then
                Move.to{x=PositionX+1, y=PositionY}
            end
        elseif movement == 3 then
            if PositionY > 0 then
                Move.to{x=PositionX, y=PositionY-1}
            end
        elseif movement == 4 then
            if PositionX > 0 then
                Move.to{x=PositionX-1, y=PositionY}
            end
        end
    end
end

function handleEvent(sourceX, sourceY, sourceID, eventDescription, eventTable)
    if eventDescription == "prey_answer" then	
        DestinationX = sourceX
        DestinationY = sourceY
    end
end


function cleanUp()
	say("Agent #: " .. ID .. " is done\n")
end
