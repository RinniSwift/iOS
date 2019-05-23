### Introduction

**Swift Style Guide**
1. Use naming that is clarity *at the point of use*.
2. Add documentation comments to functions. Especially generic ones.
3. Types start with UperCaseLetters, functions, enums, and variables start with lowerCaseLetters.
4. Use type inference over explicit which can get in the way of readability. Don't use type inference in the case of ambiguity. (this is why functions have an explicit return type).
5. Default to structs instead of classes (reference types).
6. Use guard to exit functions early.
7. Eschew force unwrap or implicitly unwrapped optionals.
8. Favor map and filter over for loops. Makes the code more readable. but don't force it.
9. Default to 'let' unless you need mutability.
10. Write extensions whenever can.

**Value types**
- structs and enums
- assigning a value type means copying over the contents.

**Reference types**
- classes and pointers (accessed through *withUnsafeMutablePointer*)
- a type that "points to" another value.
- assigning a reference type means holding a reference to the content and accessing it through that reference.
- If something contains a reference type, the reference type doesnt get copied but the reference themselves get copied.
- reference types have identity.

**Identity**
- ``` == ``` *structural equality*. If two objects are equal. Objects can be equal with different identity. Value types don't have identity.
- ``` === ``` *pointer equality* or *reference equality*. If two variables refer to the same object.

**Functions**
- Higher order functions are functions that take in other functions as arguments. (e.g. map: takes a function to transform every element of a sequence)
- functions called inside a class or protocol are called *methods* and they have an implicit *self* parameter.
- **statically dispatched** functions are functions that are known at compile time. (e.g. functions and methods called on structs)
- **dynamically dispatched** functions are functions the compiler doesn't necessarily know at compile time (e.g. methods on classes or protocols: *@objc* class by using selectors and objc_msgSend)

**Resources**\
objc Advanced Swift *updated for Swift 3* book by Chris Eidhof, Ole Begemann, and Airspeed Velocity