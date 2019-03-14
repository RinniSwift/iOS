# Types in Swift


## Reference Types
##### *Classes*
When instances share the same copy of the data it creates a shared instance.
> - Use reference types when comparing instance identity with '==='. When you care about everything being identical down to its memory address.
> - Use reference types when you want to create a shared state. When you want to create a single instance that can be accessed and mutated in multiple parts of the app. When you want everything holding that instance to stay in sync.

##### Mutability in reference types
> reference types' properties can be mutated even declaring it as *let*. This is because when reference values are declared as constants, the reference must remain constant(can't change the instance) but you can mutate the instance.



## Value Types
##### *Structs, enums, tuples, arrays, strings, dictionaries*
When instances keep a unique copy of the data.
When capturing or storing value types, values are copied rather than referenced, they cannot create retain cycles since value types don't use reference counting although values can hold references to other objects. 
> - Use value types when comparing instance data with '=='. When you care about comparing the internal values over where the value is stored in memory.
> - Use value types when copies should have indipendent state. When you are trying to create unique objects from that instance.
> - Use value types when code will use this data across multiple threads. Value types can avoid potential bugs when used across multiple threads since the data is not relied on another part of the application. 

##### Mutability in value types
> value types' declared as constants mean that the instance must remain constant no properties of the instance will ever change.



###### *resources*
- [Value and Reference type in swift](https://developer.apple.com/swift/blog/?id=10)
- [Reference vs. Value types in swift](https://www.raywenderlich.com/9481-reference-vs-value-types-in-swift)