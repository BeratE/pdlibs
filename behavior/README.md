# Behavior
Modular [Behavior-Tree](https://en.wikipedia.org/wiki/Behavior_tree_(artificial_intelligence,_robotics_and_control)) (BT) implementation.
The library contains the following list of nodes.

## Leaf nodes
Basic Leaf nodes in the behavior tree
* `Action(f)` Execute given function `f`.
* `Condition(f)` Same as above, but any status other than `SUCCESS` will fail.
* `Print(s)` Print `s` to console output. Useful for debugging. Also takes functions.

## Special leaf nodes
Stack and variable operations. 
Take optional `ns` namespace string.
See `var.lua` on the usage of variables.

* `stack.Push(stack, val, ns)` Push `val` onto the stack named `stack`.
* `stack.Pop(stack, var, ns)` Pop `stack` and write to `var`, if given.
* `stack.Empty(stack, ns)` Return `SUCCESS` if `stack` is empty, fail otherwise. 
* `var.Set(var, val, ns)` Set variable named `var` to value `val`.
* `var.IsNil(var, ns)` Return `SUCCESS` if `var` is `nil`, fail otherwise.

## Decorator nodes
Decorator nodes modulate the behavior of their single child node.
* `Succeed(b)` Execute behavior `b` and always return `SUCCESS`.
* `Fail(b)` Execute behavior `b` and always return `FAILURE`.
* `Run(b)` Execute behavior and always return `RUNNING`.
* `Invert(b)` Invert completion status of given behavior.
* `Chance(p, b, s)` Execute with `p`% (number/function) chance. Return status `s` if missed.
* `Repeat(limit, b)` Repeat behavior until fail or limit reached.
* `Delay(delay, b)` Execute behavior only after `delay` milliseconds.

## Composite nodes
Composite nodes take a list of children `{b1, b2, ..}` as argument.
* `Selector({b1, b2, ..})` (OR) Execute children sequentially until one succeeds.
* `Sequence({b1, b2, ..})` (AND) Execute children sequentially until one fails.
* `Parallel(sp, fp, {b1, b2, ..})` Update all behaviors with given success/fail policy.
* `Filter(b1, b2)` Execute `b2` only if `b1` succeeds (Special `Sequence`).
* `Monitor(b1, b2)` Execute `b2` until `b1` fails (Special `Parallel`).
* `Random({b1, b2, ..})` Select random child and execute until it completes.
* `ActiveSelector({b1, b2, ..})` Aborts low priority children in favor of high-priority ones.

## Usage

The basic functionality is as follows. Each node calls `onUpdate()` when updated, which returns either a completion status (`SUCCESS`/`FAILURE`) or an execution hint (`INVALID`, `RUNNING`, or `ABORTED`). </br>
Deriving classes should override the `onUpdate()` method and, if necessary, the `onActivate()` and `onTerminate()` functions, which are called once before the first and after the last call to `onUpdate()`, respectively. 
The `onAbort()` function can be overridden to handle an aborted behavior.
The basic API of a node consists of the functions `update()`, `abort()` and `getStatus()`.
See the comments in the `Behaviour.lua` base class file and in the derived class files on the usage of the behaviour library.

Following is a simplified example of a branch in a behaviour tree used in the Playdate game [Eclipse](https://berate.itch.io/eclipse)
```lua
local <const> bh = mylib.behavior
-- ...
local bhMoveIntoAttackRange = 
    bh.Selector({
        bh.Monitor(
            bh.Sequence({
                bh.Invert(bhIsEnemyAttacking),
                bh.Invert(bhIsInAttackRange)}),
            bh.Run(bhDoMoveLeft)),
        bhDoMoveStop})
```

The following behavior tree shows the usage of Stack nodes. 
The first two nodes in the sequence push two values into `mystack`. 
The sequence then pops the values into the variables `foo` and `bar`.
Finally, the action node prints the string `"20 10"`

```lua
local bhTestStack = 
    bh.Sequence({
        bh.stack.Push("mystack", 10),
        bh.stack.Push("mystack", 20),
        bh.stack.Pop("mystack", "foo"),
        bh.stack.Pop("mystack", "bar"),
        bh.Action(function ()
            print(mylib.var.get("foo") .. " " .. mylib.var.get("bar"))
        end)
    })
```

You can access variables using the `var.get(varName, ns)` and `var.set(varName, value, ns)` functions. 
The third namespace parameter is optional.

Alternatively, you can call `var.setEnvGlobal()` before the declaration of any node to declare `foo` and `bar` to global variables.
The body of the action function then becomes `print(foo .. " " .. bar)`.

> **_NOTE:_**  The scope of a node is captured on its *creation*. Changing the environment *while* creating a node, e.g. in a sequence, will not have an effect on the environment of the declared variables. In the above example, the node `Print(mylib.var.get("foo"))` would print `nil`, since the function will be evaluated at decleration, and at that time `foo` will be unassigned. Wrap the argument into a function to simulate *deferred execution*.

Note that all behavior trees share the same default namespace for variables. 
This makes it easy to share data or pass messages between different behavior trees. You can generate a random namespace using the function `var.ns.generate()`, which returns the namespace name you can pass on as third parameter to following library functions.