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
- *if var*
- *while let*
- *while var*
- *Doubly nested optionals*
- *Optional chaining*

**if let**\
Optional binding is similar to the switch statement.\
**if var**\
If wanting to make changes to the optional value. The one copied will not affect the value inside the original copy. *Optional are value types, and unwrapping them unwraps the value inside.*

```swift
var array = ["r", "i", "n"]
if let index = array.index(of: "i") {
   array.remove(at: index)
}

let number = "1"
if var i = Int(number) {
   i += 1
   print(i)
}
// 2
```
You can also bind other entries in the same if statement.

**while let**\
Similar to the if let. This is a loop that only terminates when a nil is returned. This is useful for the readline() function which will return nil once it hits the last line or even until the string has a nil value when mutating it.\
**while var**\
Making changes to an optional value but the value will not change the original one.

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

**Optional chaining**\
You can chain calls on optional values as such:

```swift
let result = str?.uppercased()
let resultLower = str?.uppercased().lowercased()
```
The reason why we didn't need the```?``` after the ```uppercased()``` is becasue optional chaining is a *"flattening"* operation. ```str?.uppercased()``` returned an optional so if you wrote ```str?.uppercased()?.lowercased()```, this would get you an optional optional. So we just write the second chain without an optional to represent that the optionality is already captured. But! If the ```uppercased()``` returned an optional, then your need the ```?``` to express that you were chaining *that* optional. e.g.:

```swift
extension Int {
   var half: Int? {
   	guard self > 1 else { return nil }
   	return self / 2
   }
}

20.half?.half?.half // Optional(2)
```
Optional chaining can be used instead of ```if let``` as well.

```swift
let splitViewController: UISplitViewController? = nil
let myDelegate: UISplitViewControllerDelegate? = nil
if let viewController = splitViewController {
   viewController.delegate = myDelegate
}

// using optional chaining works as well:
splitViewController?.delegate = myDelegate
```

---

**Resource**\
objc Advanced Swift *updated for Swift 3* book by Chris Eidhof, Ole Begemann, and Airspeed Velocity



