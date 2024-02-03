# PDLIBS
Lua libraries used for game development on the Playdate.
The data structures on the library depend heavily on the [PlaydateSDK](https://sdk.play.date/) Objects library.
See the comments in the source files for usage of the classes.

## State
Simple Finite State Machine (FSM) object and state manager.

## Struct
Basic data structures I needed at some point, included `LinkedList` and `Queue`.

## Behavior
Basic modular Behavior Tree implementation based on the Behavior Tree Starter Kit (BTSK) presented in 
[Game AIPro](https://www.gameaipro.com/).
See the comments in the base class `Behaviour` and `BehaviourTree` and in the derived classes on the usage of the behaviour library.

Following is a simplified example of the construction of a Behavior Tree used in the Playdate game [Eclipse](https://berate.itch.io/eclipse)
```lua
local bhGuessNextEnemyStance = bh.Action(function ()
        -- Functionality of Leaf node
    end)

local behaviorTree = bh.BehaviorTree(
        -- A sequence executes the child behaviours until all are executed or one fails (AND)
        bh.Sequence({ 
            bhCollectBlackboard,
            bhGuessNextEnemyStance,
             -- A Selector executes the child behaviours until one succeeds or all fail (OR)
            bh.Selector({ 
                -- A Filter only execute second child if first child succeeds
                bh.Filter(bhShouldBlock, 
                    bh.Sequence({
                        -- A Do block always returns success
                        bh.Do(bh.Filter(bhShouldChangeStance,
                            bhTakeNextGuessedEnemyStanceType
                        )),
                        bhDoHoldBlock
                    })
                ),
                bhDoReleaseBlock
            }),
            -- Execute one of the childs at random
            bh.Random({ -- Random movement
                bhMoveIntoAttackRange,
                bhMoveOutOfAttackRange,
                bhDoMoveStop
            }),
            bh.Filter(bhCheckWantAttack,
                bhDoAttack
            )
        })
    )
```
