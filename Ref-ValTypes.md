# Types in Swift


## Reference Types
##### *Classes*
When instances share the same copy of the data it creates a shared instance.
> - Use reference types when comparing instance identity with '==='. When you care about everything being identical down to its memory address.
> - Use reference types when you want to create a shared state. When you want to create a single instance that can be accessed and mutated in multiple parts of the app. When you want everything holding that instance to stay in sync.

##### Mutability in reference types
> reference types' properties can be mutated even declaring it as *let*. This is because when reference values are declared as constants, the reference must remain constant(can't change the instance) but you can mutate the instance.

#### Classes 
Example of classes are NSArray and its subclass; NSMutableArray. Whenever iterating over it and making changes, it will mutate the original one since it keeps a reference to it. Unlike typical arrays in Swift which are structs, looping through values and mutating it creates a copy of each value.


## Value Types
##### *Structs, enums, tuples, arrays, strings, dictionaries*
When instances keep a unique copy of the data.
When capturing or storing value types, values are copied rather than referenced, they cannot create retain cycles since value types don't use reference counting although values can hold references to other objects. 
> - Use value types when comparing instance data with '=='. When you care about comparing the internal values over where the value is stored in memory.
> - Use value types when copies should have indipendent state. When you are trying to create unique objects from that instance.
> - Use value types when code will use this data across multiple threads. Value types can avoid potential bugs when used across multiple threads since the data is not relied on another part of the application. 

##### Mutability in value types
> value types' declared as constants mean that the instance must remain constant no properties of the instance will ever change.

#### Structs
Structs are extremely fast compared to objects. An example would be an array of structs compared to an array of objects. The struct lives directly inside the array's memory. Whereas an array of objects contains just the references to the objects. And the compiler puts structs on the stack rather than a heap.\
Structs have a single owner. Whereas if we pass a struct into a funtcion, the function recieves a copy of the struct and it can only change its own copy. This is called *value semantics*. Contrasting with objetcs which get passed by reference and can have many owners which is called *reference semantics*.

---
###### *resources*
- [Value and Reference type in swift](https://developer.apple.com/swift/blog/?id=10)
- [Reference vs. Value types in swift](https://www.raywenderlich.com/9481-reference-vs-value-types-in-swift)