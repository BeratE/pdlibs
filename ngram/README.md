# N-Grams

General order [N-Gram](https://en.wikipedia.org/wiki/N-gram) implementation using Laplace-Smoothing.
Useful for learning and predicting input patterns.
An N-Gram takes a list of possible events (the *alphabet* or *event space*) and collects statistical data on the occurrence of event-patterns of lenght *N*.

The N-Gram library works with arrays of events (integer indexed tables), as well as strings, which are interpreted as arrays of characters. 
See the `Ngram.lua` file for the usage of Ngram objects.

## Example

The following example snippet shows the initialization of a *Bigram* (order 2 N-Gram), with the alphabet "a,b,c" and initial sequence as third parameter.
Two new events are added to the sequence and finally the probability mass function (pmf) of the events is printed out, showing that, for example, event "b" has a probability of 60% to be next in the sequence.
```lua
bigram = mylib.Ngram(2, "abc", "abbabcaacbaccbbbbbbbb")
bigram:pushEvent("a")
bigram:pushEvent("b")
print(mylib.dump(bigram:pmf()))
-- { "b": 0.6, "c": 0.1333333, "a": 0.2666667, }
```

In the game [Eclipse](https://berate.itch.io/eclipse) and N-Gram is used to predict the next player move. 
The following example shows the pmf output of two different sequences for what the system thinks the player might do next, based on her previous actions.
```lua
-- ..., ATTACK, ATTACK, ATTACK, BLOCK, BLOCK, BLOCK, BLOCK, BLOCK, BLOCK, BLOCK
{ "ATTACK": 0.14, "STANCE": 0.05, "MOVE": 0.10, "BLOCK": 0.71, }
-- ..., BLOCK, ATTACK, ATTACK, ATTACK, ATTACK, MOVE, MOVE, MOVE, MOVE, ATTACK
{ "STANCE": 0.2, "ATTACK": 0.4, "BLOCK": 0.2, "MOVE": 0.2, } 
```
From this we can deduce, that the player will attack next with about 80% certainty.

