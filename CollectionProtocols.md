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

> **Iterators and value semantics**. All iterators in the example have value semantics. This means that if there is a copy, the iterators will act independantly of each other. But *without value semantics*(reference semantics), the original and the copy don't act indipendently. The *storage of the box* is actually shared between the two iterators. Example of a reference semantic is ```AnyIterator``` it wraps the iterator in an internal box object(a class instance)
> Mostly we create iterators implicitly more than explicitly through a for loop. 

This is what a for loop does under the hood: the compiler creates a fresh iterator for the sequence and calls next on the iterator repeatedly until nil is returned which looks like:

```swift
var iterator = someSequence.makeIterator()
while let element = iterator.next() {
   doSomething(with: element)
}
```
This iterator can be used explicitly instead of a for-in loop by calling the iterators next until it returns nil.

---

> **Activity**\
> Implementing a string iterator that iterates over and increments the prefix

```swift
struct PrefixIterator: IteratorProtocol {

   // protocol stub--this is not necessary since it can infer the type when called the PrefixSequence
   // typealias Element = Substring
   
   let string: String
   var offset: String.index

   init(string: String) {
   	self.string = string
   	self.offset = string.startIndex
   }

   // protocol stub
   mutating func next() -> Substring? {
   	guard offset < string.endIndex else { return nil }
   	offset = string.index(after: offset)
   	return string[string.startIndex..<offset]
   }
}
```
> Now that we have the iterator protocol, we can use this in the makeIterator() method in a 'sequence'
```swift
struct PrefixSequence: Sequence {
   let string: String

   func makeIterator() -> PrefixIterator {
   	return PrefixIterator(string)
   }
}
```
> Now we can iterate over the sequence--in this case, a string-- and return all substrings from start to incrementing until the last elements.
```swift
for prefix in Prefixsequence(string: "Rinni") {
   print(prefix)
}
// "R"
// "Ri"
// "Rin"
// "Rinn"
// "Rinni"
```
> We have just created infinite sequences. We can also construct another function or parameter to slice off the finite piece.

---

**AnyIterator** is an iterator that wraps another iterator. (does not have value semantics) It also has a second initializer that takes the next function directly as its argument. e.g. We can define the fibonacci iterator as a function that returns an ```AnyIterator```:

```swift
func fibsIterator() -> AnyIterator<Int> {
   var state = (0, 1)
   return AnyIterator {
   	let upcomingNumber = state.0
   	state = (state.1, state.0 + state.1)
   	return upcomingNumber
   }
}

let fibsSequence = AnySequence(fibsIterator)
Array(fibsSequence.prefix(10)) // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
```

Another alternative is to use the ```sequence(first:next:)``` returns a sequence as the first element as the first argument passed in and ```sequence(state:next:)``` more powerful because we can keep a mutable state around the next closure.

```swift
let randomNumbers = sequence(first: 100) { (previous: UInt32) in
   let newValue = UInt32.randome(in: 0...previous)
   guard newValue > 0 else { return nil }
   return newValue
}
Array(randomNumbers) 

let fibsSequence = sequence(state: (0, 1)) {
   // compiler needs type inference help here
   (state: inout(Int, Int)) -> Int? in
   let upcomingNumber = state.0
   state = (state.1, state.0 + state.1)
   return upcomingNumber
}
Array(fibsSequence.prefix(10))
```

---


**Resource**\
objc Advanced Swift *updated for Swift 3* book by Chris Eidhof, Ole Begemann, and Airspeed Velocity