# State
Simple Finite State Machine (FSM) implementation.
See comments in the `State.lua` and `StateMachine.lua` files on the usage.

## State
Abstract class representing a state.
Contains the following methods, override in derived classes.
* `onEnter()`: Called once when entering the state.
* `onExit()`: Called once when exiting the state.
* `onUpdate()`: Called on every update iteration of the state machine.

## StateMachine
State machine for managing states and transitions. Offers the following interfacing functions.
* `switch(state)`: Switch to the new state.
* `revert()`: Revert to the previos state.
* `update()`: Update the current state.