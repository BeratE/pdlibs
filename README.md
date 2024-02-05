# PDLIBS
Lua libraries used for game development on the Playdate.
The data structures on the library depend heavily on the [PlaydateSDK](https://sdk.play.date/) Objects library.
See the comments in the source files for usage of the classes.

## State
Simple Finite State Machine (FSM) library, holding the following classes.
### State
Abstract class representing a state with an `onEnter()`, an `onUpdate()` and an `onExit()` method. 
Override these methods in a derived class.

### StateMachine
A State machine containing a reference to the current and previous state. Offers functionality to update states and manage transitions. See comments in the `StateMachine.lua` on the usage.

## Struct
General purpose *data structures*.
### Queue
A simple queue data structure.

### TransientQueue
A queue data structure that holds items for a maximum number of ticks, given in the init argument (default 15).
Call `tick()` to update the queue.


## Behavior
Modular behavior tree (BT) implementation.
See the comments in the base class file `Behaviour.lua` and in the derived classes on the usage of the behaviour library.


The behavior library is divided into the following submodules:
* Leaf
* Decorator
* Composite
* State

### Example Usage
Following is an example of a branch in a behaviour tree used in the Playdate game [Eclipse](https://berate.itch.io/eclipse)
```lua
local bhMoveIntoAttackRange = bh.Selector({
    bh.Monitor(
        bh.Sequence({
            bh.Invert(bhIsEnemyAttacking),
            bh.Invert(bhIsInAttackRange),}),
        bh.Run(bhDoMoveLeft)),
    bhDoMoveStop})
```
