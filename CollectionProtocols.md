### Collection Protocols

#### Sequence Protocol
A sequence protocol lets you iterate over a the same type of values. Most common way is a *for-in* loop. Implement Sequence with operations that have to depend on sequential access to a series of values.\
Making your own custom types conform to the Sequence protocol enables the *for-in* loop and *contains* method. To add the conformance to your own custom type, you must provide a ```makeIterator()``` method that returns an *iterator*. 

#### Iterator Protocol
Sequences provide access to their elements by creating an iterator. The iterator produces the values of the sequence one at a time and keeps track of its iteration state. The only method defined in the *Iterator Protocol* is ```next()``` which must return the next element on each subsequent call or nil. 

```swift
protocol IteratorProtocol {
   associatedtype Element
   mutating func next() -> Element?
}
```

This is what a for loop does under the hood: the compiler creates a fresh iterator for the sequence and calls next on the iterator repeatedly until nil is returned which looks like:

```swift
var iterator = someSequence.makeIterator()
while let element = iterator.next() {
   doSomething(with: element)
}
```
This iterator can be used explicitly instead of a for-in loop by calling the iterators next until it returns nil.



---

**Resource**\
objc Advanced Swift *updated for Swift 3* book by Chris Eidhof, Ole Begemann, and Airspeed Velocity