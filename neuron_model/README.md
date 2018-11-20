
## Initial behaviour

As a first step, the growth cone was modelled in a way that it is aware of
incomming external electrical pulses events. When this happens, it grows towards
the direction of the received event.

The next functionality introduced was taking into account the excitation state
of the neuron. According to the Hebbian rule, the axon grows and gets a stronger
connection when the neuron it is pointing to gets triggered right after the
axon's neuron gets triggered. If the sequence of events is the opposite, the
connection gets weaker. Hence, when a neuron gets triggered, its growth cone
will look for neurons that are being triggered in the following instants of
time, and will grow in those directions.

Finally, once the growth cone reaches the destination neuron, a connection
between them is established.
