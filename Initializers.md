# Initializers in Swift

*Initailization is the process of preparing an instance of a class, struct, or enum for use. This process involves setting initial values for each stored property on that instance and any other setup or initialization before the instance is ready for use.*\
**Stored properties** cannot be left in an undetermined state. All stored properties must be assigned by the time of initialization. e.g:

```Swift
enum Gender {
	case female
	case male
	case unknown
}

struct Human {
	var gender: Gender	// stored property

	init(gender: Gender) {
		self.gender = gender	// stored property being set by the time of initialization
	}
}
```
Above we are assigning some value to the variable gender at the time of initialization. If you do't want to use the init method:
```Swift
struct Human {
	var gender: Gender = .male 	// setting a default value

	// or

	var gender: Gender?	// declaring variable as optional
}
```
\
Different ways to implement initializers are: 
1. *Customizing initialization*
2. *Initializer parameters without argument labels*
3. *Default initializers*
```Swift
// 1. The swift compile will decide which to call based on the argument label
struct Human1 {
	var gender: Gender
	var age: Int = 10

	init(age: Int) {
		self.age = age
	}

	init(gender: Gender) {
		self.gender = gender
	}

	init(gender: Gender, age: Int) {	// this will be called when instantiating human1
		self.gender = gender
		self.age = age
	}
}
let human1 = Human1(gender: .female, age: 19)

// 2. nameless initializers
struct Human2 {
	var gender: Gender
	var age: Int

	init(_ gender: Gender, _ age: Int) {
		self.gender = gender
		self.age = age
	}
}
let human2 = Human2(.female, 19)

// 3. default initializer
struct Human3 {
	var gender: Gender = .female
	var age: Int = 19
}
let human3 = Human3()
```
\
All of a classes properties--including that of any in the super class it inherits from--must be set during initialization. What if we want it to be optional where you can assign a value or not in the parameters? This is where *convenience initializers* come in handy.\
**Convenience initializers** are supporting an initializer for a class.You can design convenience inits to call a *designated initializer* by calling self.init. A convenience init must call another init within the same class, must ultimately call another designated initializer.\
**Designated Initializers** are primary initializers which fully initializes all properties in the class.
```swift
struct Human {
	var name: String

	init(name: String) {	// designated init
		self.name = name
	}

	convenience init() {	// convenience init
		self.init(name: "not set")
	}
}

let desHuman = Human(name: "Rinni")	// calls designated init. name = "Rinni"
let conHuman = Human() 			// calls convenience init. name = "not set"
```
Above you can see that we designed the convenience init to call the designated init.\
\

**Initializer Inheritance**\
how to use initializers with subclasses
```swift
class Human {
	var age: Int

	init(age: Int) {
		self.age = age
	}

	convenience init() {
		self.init(age: 0)
	}
}

class Man: Human {
	var name: String

	override init(age: Int) {
		super.init(age: age)
	}

	init(name: String, age: Int) {
		super.init(age: age)
		self.name = name
		self.age = age
	}
}
```


---
###### *resources*
- [Medium - Iniatializers in swift](https://medium.com/@abhimuralidharan/initializers-in-swift-part-1-intro-convenience-and-designated-intializers-9adf5632fb52)
