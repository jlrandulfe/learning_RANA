# Project wiki

For more information about the project, visit [the wiki](https://github.com/jlrandulfe/learning_RANA/wiki)

# Main modules and workflow in RANA

## main.cpp

Initially, some static class methods and variables are run and set without
previously creating an instance (WHY???).

Afterwards, a *Qt* application object is created, as well as the *mainwindow*,
and the application is executed.

## mainwindow.cpp

File containing the class of the main window of the application. It contains
the methods that are called when the user interacts with the UI. During
initialization, the event signals are connected to the corresponding methods.
Moreovers, different timers are set, for dealing with certain events.

Some relevant methods that are called during the execution are the following:

- addGraphicAgent: If there is already an agent with that ID, it is removed.
Creates an agentItem with specified coordinates, id, color and angle. add the
item to the scene, and insert it in the graphAgents iterable.
- updateMap
- generateButton click event: It is the *Initialize* button in the interface. This
is the function that prepares the environment to be run i.e. Reads all of the
parameters specified by the user, and sets the environment variables of the
Control object.
- runButton click event: Starts the simulation, by running the corresponding
method of the control object.

Relevant variables:

- graphAgents
- Scene
- mapItem: QGraphicsPixMapItem. The scene variable contains the mapItem
- mapImage: QImage. By default filled of black colour. the mapItem.QPixMap is
set to this variable

## control.cpp

This file contains a class that opens and configures a Lua environment (state).
This class wraps the functionality inside the agent domain, which,
among others, calculates and updates the positionns of the agents. It also
contains the timers in charge of deciding when to update the simulation
parameters, as well as the top level control of the simulation threads.

The set environment method sets the main class variables, which are specified
by the constuctor call. It also runs a function that generates a new
environment (Essentially, creates an agent domain, which is an instance of
the flowControl class).


# Graphics modules

## agentitem.cpp

File containing the class that represent each agent in the scene. The attributes
are its id, color, angle, showid, and angleShow. The main methods are paint and
boundingRect(). The later is incomplete. The remaining methods are basically
used for setting or getting the values of the attributes.

The paint method gets a QPaint object and sets its color. If the option is
enabled, it draws the id of the agent. The method is incomplete as well.

This class is inherited from the QGraphicsItem class, and uses some of its
properties and attributes e.g. X and Y coordinates.



# Simulation core main modules

## flowcontrol.cpp

Top level class of the simulation core.


## supervisor.cpp

Contains a class representing the master agent.


## sector.cpp

There is on Sector object for each thread that has been specified in the UI


# Simulation core agent modules


# agentluainterface.cpp

Contains a class that defines the interface between the lua agents and the
simulation core agents.

It has methods that, at each step of the simulation, interact with the lua
module in order to evolve the position and event interaction of the agent.


# Found issues

- When compiling the code, the modules subfolder is under the wrong relative
path. The applications looks at ./src/modules.

- in mainwindow.ui, there is a missmatch in the name of the *Initialize* button.
In the interface, it has the text *Initialize*, but in the code its name is
*generateButton*. The missmatch leads to confussions when trying to understand
the code, and it's an fix.
