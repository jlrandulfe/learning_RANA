
## Initial behaviour: Axon growing towards a source of electric pulses

As a first step, the growth cone was modelled in a way that it is aware of
incomming external electrical pulses events. When this happens, it grows towards
the direction of the received event.

For testing this behaviour, an agent emiting electric pulses was introduced in
the map. On every step, it casted an event called "electric_pulse". When the
growth cone agent deteces this pulse, it starts growing towards the emitter of
the electric pulse, creating axon agents on its way.

In the figure below, the red dot is the soma of the neuron processing incomming
electric pulses, the blue dots are its axon segments, the green dot is its
growth cone, and the white dot is the source of the electric pulses.

![Neuron growing towards an electric pulse source](https://github.com/jlrandulfe/learning_RANA/blob/master/resources/growing_neuron.gif "Growing neuron")


## Implementation of the Hebbian rule in the neurons

The next functionality introduced was taking into account the excitation state
of the neuron. According to the Hebbian rule, the axon grows and gets a stronger
connection when the neuron it is pointing to gets triggered right after the
axon's neuron gets triggered. If the sequence of events is the opposite, the
connection gets weaker. Hence, when a neuron gets triggered, its growth cone
will look for neurons that are being triggered in the following instants of
time, and will grow in those directions.

Finally, once the growth cone reaches the destination neuron, a connection
between them is established.
