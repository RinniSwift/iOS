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
		self.gender = gender
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

	init(gender: Gender, age: Int) {
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
