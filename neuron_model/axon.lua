
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
Map = require "ranalib_map"

axon_link_length = 5
init = true

function initializeAgent()

    Agent.changeColor{r=255}
    -- Initialize the soma at the middle of the map
    say("Axon Agent#: " .. ID .. " has been initialized")

	Speed = 0
	GridMove = true
    Moving = false
end


function takeStep()
    if init == true then
        -- Add the growth cone agent
        growth_cone_x = PositionX + (axon_link_length+1)/2
        growth_cone_y = PositionY
        Agent.addAgent("growth_cone.lua", growth_cone_x, growth_cone_y)
        init = false 
    end
end


function cleanUp()
	say("Agent #: " .. ID .. " is done\n")
end