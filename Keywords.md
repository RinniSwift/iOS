# A collection of Swift used keywords

- `@objc`
- `escaping`
- `available`
- `final`

## Declarations
Declarations introduce new names or constructs into your program. You use *declarations* to introduce; classes, functions, methods, variables, constants, enums, structs, and protocols.

- **Import declaration** let's you use modules, symbols that are outside of the file scope.\
`import MODULE` this will import the entire module\
`import MODULE.SUBMODULE`, `import MODULE.SYMBOLNAME` this will import only the specified symbol or submodule. Which gives you more details limits since this does not import the entire module.

- **Constant declaration** this defines an immutable binding between the constant name and the value. After a value of a constant is set, it cannot be changed. If a constant is initialized with a class object, the object can change but the binding between the constant name and the object cannot. When a constant is declared inside a class or struct, it is considered a *constant property*; unlike *computed properties* where they have getters and setters. *Constant properties* are properties that can be used by all instances, like static constants, static variables, and variable properties.

> When a constant is declared at global scope, it must be intialized with a value. It has to have a value set before it's value gets read.

- **Variable declaration** this defines mutable values. 

> Declaring variables in the global scope or local scope of a function is referred to as a *stored variable*. Declaring variables in the context of a class or struct is referred to as a *stored variable property*.\
> Variables can also be declared as *computed variables* or *computed properties*. Declaring variables in the global scope or local scope of a function is referred to as a *computed variable*. Declaring variables in the context of a class or struct is referred to as a *computed property*

**Stored variable declaration**
```swift
var NAME: TYPE = EXPRESSION
```

**Computed variable declaration**
```swift
var NAME: TYPE {
   get {
     STATEMENTS
   }
   set(SETTERNAME) {
     STATEMENTS
   }
}
```

> The **Getter and Setter**. The *getter* is used to read the value, the *setter* is used to write the value. The setter is optional and when you only want to have a getter, you can omit both clauses and simply return the value. This is called a *read-only computed property* as seen below. But if there's a setter, there must also be a getter.\
> the SETTERNAME is optional. This can be left blank and the new value to use in the following clause is accessed as `newValue`. And in the get clause is simply omitting the `return`.

> You can also declare a stored variable or stored property with `willSet` and `didSet` observers. When you define variables with property observers in a global scope or a in a local function, they are referrred as *stored variable observers*. Declaring them in the context of a class or struct they are referred as *property observers*.

**Stored variable observer declaration**
```swift
var NAME: TYPE = EXPRESSION {
   willSet(SETTERNAME) {
     STATMENTS
   }
   didSet(SETTERNAME) {
     STATEMENTS
   }
}
```

> These observers provide a way to observe and respond appropriately when the value of a property is being set. The observer is not called when the variable or property is first initialized. -- It's called outside of the initialization context.\
> the `willSet` gets called right before the variable or property is set. And a value is passed as a constant to the willSet clause.\
> the `didSet` gets called right when the new value is set. The old variable or property is passed to the didSet clause.\
> the SETTERNAME in both parameters are optional. The new value in the `willSet` is accessed as `newValue` and the old value in the `didSet` is acccessed as `oldValue`. And you can use either didSet or willSet. They don't have to be called at the same time.



```swift
var NAME: TYPE {   // read-only computed property
   return EXPRESSION
}
```

## Statements

## Expressions


## Stored Type Properties and Computed Properties
> Computed properties have getters and/or setters and must always be set as a variable property
> Stored type properties can be set as a variable or constant and must always be intialized a default value.
> Stored type protperties are lazily initialized on their first access and do not need to be marked with the lazy modifier.


> **Resources**:
> - [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#grammar_import-declaration), The Swift Programming Language
> - [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html#ID264), The Swift Programming Language

