# State
Simple Finite State Machine (FSM) library, holding the following classes.
## State
Abstract class representing a state with an `onEnter()`, an `onUpdate()` and an `onExit()` method. 
Override these methods in a derived class.

## StateMachine
A State machine containing a reference to the current and previous state. 
Offers functionality to update states and manage transitions. See comments in the `StateMachine.lua` file on the usage.
