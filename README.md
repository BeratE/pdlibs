# PDLIBS
Lua libraries used for game development on the Playdate.
The data structures on the library depend heavily on the [PlaydateSDK](https://sdk.play.date/) Objects library.
See the comments in the source files for usage of the classes.

## State
Simple Finite State Machine (FSM) object and state manager.

## Struct
Basic data structures I needed at some point, including `LinkedList` and `Queue`.

## Behavior
Basic modular Behavior Tree implementation based on the Behavior Tree Starter Kit (BTSK) presented in 
[Game AIPro](https://www.gameaipro.com/).
See the comments in the base class `Behaviour` and in the derived classes on the usage of the behaviour library.

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
