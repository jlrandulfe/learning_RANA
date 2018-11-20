
Agent = require "ranalib_agent"
Stat = require "ranalib_statistic"

n_neurons = 1

function initializeAgent()
    say("Master Agent#: " .. ID .. " has been initialized")
    PositionX = -1
    PositionY = -1

    -- Add neurons
    for i=1, n_neurons do
        Agent.addAgent("soma.lua", Stat.randomInteger(10, ENV_WIDTH-10),
                       Stat.randomInteger(10, ENV_HEIGHT-10))	
    end

    Agent.addAgent("pulse_generator.lua", Stat.randomInteger(10, ENV_WIDTH-10),
                   Stat.randomInteger(10, ENV_HEIGHT-10))	
end


function takeStep()
	Agent.removeAgent(ID)
end


function cleanUp()
	say("Agent #: " .. ID .. " is done\n")
end
