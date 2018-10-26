
Agent = require "ranalib_agent"
Stat = require "ranalib_statistic"

n_preys = 40
n_predators = 5

function initializeAgent()
    say("Master Agent#: " .. ID .. " has been initialized")
    PositionX = -1
    PositionY = -1
    -- Add preys
    for i=1, n_preys do
        Agent.addAgent("prey.lua", Stat.randomInteger(1, ENV_WIDTH),
                       Stat.randomInteger(1, ENV_HEIGHT))	
    end
    -- Add predators
    for i=1, n_predators do
        Agent.addAgent("predator.lua", Stat.randomInteger(1, ENV_WIDTH),
                       Stat.randomInteger(1, ENV_HEIGHT))	
    end
end


function takeStep()
	Agent.removeAgent(ID)
end


function cleanUp()
	say("Agent #: " .. ID .. " is done\n")
end
