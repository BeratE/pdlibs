# Struct
General purpose *data structures*.

## Queue
A simple queue data structure. Avoids the use of expensive `table.insert` and `table.remove` functions.

## BoundedQueue
Same as `Queue`, but stores a maximum number of item and pops off last item if bound is reached and a new item is pushed. 
Acts as a normal Queue if no bound is given. 

## TransientQueue
A queue data structure that holds items for a maximum number of ticks, given in the init argument (default 15).
Call `tick()` to update the queue and discard items older than maximum number of ticks.