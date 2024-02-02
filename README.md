# PDLIBS
Lua libraries used for game development on the Playdate.
The objects depend heavily on the PlaydateSDK Objects library.
See the comments in the source files for usage of the classes.

## State
Simple Finite State Machine object and state manager.

## Struct
Basic data structures I needed at some point. 

## Behavior
Basic modular Behavior Tree implementation based on the Behavior Tree Starter Kit presented in 
[Game AIPro](https://www.gameaipro.com/).

Following is an example of the construction of a BehaviorTree for an Enemy used in [Eclipse](https://berate.itch.io/eclipse)
```lua
local behaviorTree = bh.BehaviorTree(
        bh.Sequence({
            bhCollectBlackboard,
            bhGuessNextEnemyStance,
            bh.Selector({
                bh.Filter(bhShouldBlock,
                    bh.Sequence({
                        bh.Do(bh.Filter(bhShouldChangeStance,
                            bhTakeNextGuessedEnemyStanceType
                        )),
                        bhDoHoldBlock
                    })
                ),
                bhDoReleaseBlock
            }),
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
