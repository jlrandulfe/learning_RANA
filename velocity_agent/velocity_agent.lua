
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

Move = require "ranalib_movement"
Agent = require "ranalib_agent"
Map = require "ranalib_map"
Stat = require "ranalib_statistic"

-- Circular trajectory radius
local radius = 25
-- Absolute speed
local speed = 100


function initializeAgent()

    Agent.changeColor{g=255}
    -- Initialize the soma at the middle of the map
    say("Agent#: " .. ID .. " has been initialized")
    
    GridMove = true

    PositionX = ENV_WIDTH/2 + radius
    PositionY = ENV_HEIGHT / 2

    -- Paint the start point of the agent.
    Map.modifyColor(ENV_WIDTH/2 + radius, ENV_HEIGHT/2, {255, 0, 0})
    Map.modifyColor(ENV_WIDTH/2 - radius, ENV_HEIGHT/2, {255, 0, 0})
    Map.modifyColor(ENV_WIDTH/2, ENV_HEIGHT/2 + radius, {255, 0, 0})
    Map.modifyColor(ENV_WIDTH/2, ENV_HEIGHT/2 - radius, {255, 0, 0})

    coords = {x1=PositionX, y1=PositionY, x2=PositionX, y2=PositionY}
end


function takeStep()

    -- Distances to the centre of the map
    local dx = PositionX - ENV_WIDTH/2
    local dy = PositionY - ENV_HEIGHT/2

    -- Velocity components for describing a circular trajectory around the
    -- map centre.
    local vx =  -(speed * dy/radius)
    local vy = speed * dx/radius

    Move.setVelocity{x=vx, y=vy}
    
end