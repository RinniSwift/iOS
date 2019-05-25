## Optionals

Declares operations that may or may not return a value.\
Swift handle it's optionals with enums. As well as including 'associated values'. These are values that can also have another value associated with them.

```Swift
public enum Optional<Wrapped>: ExpressibleByNilLiteral {
   case none
   case some(Wrapped)
}
```

Optionals conform to the ExpressibleByNilLiteral so that you can write nil instead of ```.none```\
Even if we never write the word 'Optional', when we create 	```Int?``` it is equivalent to writing ```Optional<Int>```. You must unwrap optional values before using them and there are many ways to. We use these for "failable" values:

- *if let*
- *while let*
- *Doubly nested optionals*

**if let**\
Optional binding is similar to the switch statement.

```swift
var array = ["r", "i", "n"]
if let index = array.index(of: "i") {
   array.remove(at: index)
}
```
You can also bind other entries in the same if statement.\

**while let**\
Similar to the if let. This is a loop that only terminates when a nil is returned. This is useful for the readline() function which will return nil once it hits the last line or even until the string has a nil value when mutating it.

```swift
while let line = readline() {
   print(line)
}
```

**doubly nested optionals**\
The type the optional wraps can itself be an optional, which leads to optionals nested inside optionals. 

```swift
let stringNumbers = ["1", "2", "three"]
let maybeInts = stringNumbers.map{ Int($0) }
```
When looping over the ```maybeInts```, the array is an optional array of ints and the item is also an optional. Making the next value of each iteration a Int?? or Optional<Optional<Int>>. There are 2 other functions that either loops over non-nil values or nil values using the ```for case in```.

```swift
for case let i? in maybeInts {
   print(i, terminator: " ")
}
// 1 2

for case nil in maybeInts {
   print("no value")
}
// no value
```


---

**Resource**\
objc Advanced Swift *updated for Swift 3* book by Chris Eidhof, Ole Begemann, and Airspeed Velocity



