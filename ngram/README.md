# N-Grams

General order [N-Gram](https://en.wikipedia.org/wiki/N-gram) implementation using Laplace-Smoothing.
Useful for learning and predicting input patterns.
An N-Gram takes a list of possible events (the *alphabet* or *event space*) and collects statistical data on the occurrence of event-patterns of lenght *N*.

The N-Gram library works with arrays of events (integer indexed tables), as well as strings, which are interpreted as arrays of characters. 
See the `Ngram.lua` file for the usage of Ngram objects.

## Example

 The following example snippet shows the initialization of a *Bigram* (order 2 N-Gram), with the alphabet "a,b,c" and initial sequence as third parameter.
Two new events are added to the sequence and finally the probability distribution of the events is printed out, showing that, for example, event "b" has a probability of 60% to be next in the sequence.
```lua
bigram = mylib.Ngram(2, "abc", "abbabcaacbaccbbbbbbbb")
bigram:pushEvent("a")
bigram:pushEvent("b")
print(mylib.dump(bigram:pDist()))
-- { "b": 0.6, "c": 0.1333333, "a": 0.2666667, }
```