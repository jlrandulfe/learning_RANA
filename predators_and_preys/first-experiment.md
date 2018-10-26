# Master agent

In RANA, the interface only allows to summon one type of agent. As in this exercise
2 different kinds of agents have to be used, a master agent was developed, that create
the 2 different kinds of agentson the map: Preys and Predators.

The initial locations are random for all of them. The amount of agents of each
kind is specified in the initial parameters.

```lua
-- Add preys
for i=1, n_preys do
    Agent.addAgent("prey.lua",
                    Stat.randomInteger(1, ENV_WIDTH),
                    Stat.randomInteger(1, ENV_HEIGHT))	
end
-- Add predators
for i=1, n_predators do
    Agent.addAgent("predator.lua",
                    Stat.randomInteger(1, ENV_WIDTH),
                    Stat.randomInteger(1, ENV_HEIGHT))	
end
```

After initializing the agent, on the first step it takes it is destroyed. This is
not done in the initialization step because of restrictions in the RANA engine.


# Prey agent

The initially developed behaviour of the preys is a random move at each iteration
step. The random moves can be Nort, East, South, West, and staying in the same place.

The *randomInteger()* function from the *ranalib_statistic* is used for determining the
random direction

```lua
function takeStep()
    -- Agent movement.
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
        elseif movement == 5 then
        end
    end
end
```

# Predator agent

The movement of the predator agent is the same as the prey, excepting that
staying in the same place is not included in the random moves it can do. This is
a way of making predators move faster than the preys.

Same as for the preys, the *randomInteger()* function from the *ranalib_statistic*
is used for determining the random direction.


# Chasing behaviour

## First approach: Making preys die when predators are next to them

In order to detect if a predator has reached the prey, the *GridMove* flag was
set to True. Also, the movement had to be performed with the *Move.to{x, y}* command
(directly setting PositionX and PositionY does not work). The 
*Collision.radialCollisionScan(radius)* function is used for detecting when the predator
has reached the prey. This condition is checked on every step the prey takes, and if
it is assesed *True*, the prey is removed from the map i.e. it is hunt by a predator.

```lua
-- Check if a predator has reached the prey
local table = Collision.radialCollisionScan(10)
if table ~= nil then
    say("Prey agent #: " .. ID .. " is dead\n")
    Agent.removeAgent(ID)
elseif
    -- Do other stuff
    ...
end
```


## Second approach: Making predators scan the surrounding area for searching for preys

In order to scan the area and look for preys, the *Collision.radialCollisionScan(radius)* 
function was tried. However, using this function entail a crucial drawback i.e. The
predator is not able to distinguish which kind of agent it detected.

In order to overcome this problem, RANA events were used. First of all, on each step
the predators emit an event that propagates to the rest of the map. It is called 
*predator_scan*.

```lua
-- Event for scanning for preys
Event.emit{speed=343, description="predator_scan"}
```

Secondly, it was added an event handler function to the prey agent, that is sensitive
to the aforementioned event sent by the predator agent. Once detected an event, it
is calculated the distance to the source. If the distance is close enough (in the
example it was decided to be 2 meters), the prey dies. If the distance is not so close,
but still is within a certain radius (in the example was decided 30 meters), the
prey emits back another event called *prey_answer*. For calculating the distance,
the *ranalib_math.calcDistance* function was used.

```lua
-- Prey event handler:
function handleEvent(sourceX, sourceY, sourceID, 
                     eventDescription, eventTable)
    if eventDescription == "predator_scan" then	
        -- If they are at the same position, the prey dies.
        coords = {x1=SourceX, y1=SourceY, x2=PositionX,
                  y2=PositionY}
        coords.x1 = sourceX
        coords.y1 = sourceY
        local distance = Math.calcDistance(coords)
        if (distance < 2) then
            say("Prey agent #: " .. ID .. " is dead\n")
            Agent.removeAgent(ID)
        -- Else, answer back to the predator.
        elseif (distance < 30) then
            Event.emit{targetID=sourceID, speed=343,
                       description="prey_answer"}
        end
    end
end
```

Finally, an event handler function is added to the predator as well. This function
checks for *prey_answer* events, and if one is detected, the predator destination
is set to the position of the prey.

```lua
-- Predator event handler
function handleEvent(sourceX, sourceY, sourceID, eventDescription, eventTable)
    if eventDescription == "prey_answer" then	
        DestinationX = sourceX
        DestinationY = sourceY
    end
end
```


# Conclusion

The described agents were implemented and tested in RANA, and proved to be successful,
showing the following characteristics:

* The predators and preys wonder around the map doing random movements
* When a prey is near a predator, the predator starts chasing the prey
* When a predator and prey are at the same location, the prey is removed from the map

However, a couple of features of the agents should be improved. First of all, the
movement of the predator and prey agent does not seem very realistic, as they are
shaking around their location. A smoother movement that implies bigger shifts in their
position should be tried instead.

Also, when more than one prey is in the vicinity of a predator, the later starts
behaving in an undesired manner, as it is not able to choose one of the preys and
starts to oscillate between the directions towards all of the detected preys.
Instead,[^1] the predator should focus in one prey (preferably the closest one) and
start chasing it until it hunts it or another prey gets closer to the predator.
