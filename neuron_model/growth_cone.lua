
--The following global values are set via the simulation core:
-- ------------------------------------
-- IMMUTABLES.
-- ------------------------------------
-- ID               -- id of the agent.
-- STEP_RESOLUTION 	-- resolution of steps, in the simulation core.
-- EVENT_RESOLUTION	-- resolution of event distribution.
-- ENV_WIDTH        -- Width of the environment in meters.
-- ENV_HEIGHT       -- Height of the environment in meters.
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

Agent = require "ranalib_agent"
Stat = require "ranalib_statistic"
Event = require "ranalib_event"
Move = require "ranalib_movement"
Math = require "ranalib_math"

move = false

axon_link_length = 5

function initializeAgent()

    Agent.changeColor{g=255}
    -- Initialize the soma at the middle of the map
    say("Axon Agent#: " .. ID .. " has been initialized")
    
    
	Speed = 100
	GridMove = true

    destination_x = PositionX
    destination_y = PositionY

    coords = {x1=PositionX, y1=PositionY, x2=PositionX, y2=PositionY}
end


function takeStep()

    -- Get the distance from the last location where an axon agent was created.
    coords.x1 = PositionX
    coords.y1 = PositionY
    local distance = Math.calcDistance(coords)
    
    -- When the growth cone has travelled enough distance, a new axon segment
    -- agent is created.
	if distance > axon_link_length then
        Agent.addAgent("axon.lua", coords.x2, coords.y2)
        coords.x2 = PositionX
        coords.y2 = PositionY
	end

end

function handleEvent(sourceX, sourceY, sourceID, eventDescription, eventTable)
    if eventDescription == "electric_pulse" then
        say("Received an electric pulse\n")
        -- Set the growth cone direction to the electric pulse source
        DestinationX = sourceX
        DestinationY = sourceY
        Moving = true
    end
end


function cleanUp()
	say("Agent #: " .. ID .. " is done\n")
end
