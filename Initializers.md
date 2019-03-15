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
\
Above we are assigning some value to the variable gender at the time of initialization. If you do't want to use the init method:
```Swift
struct Human {
	var gender: Gender = .male 	// setting a default value

	// or

	var gender: Gender?	// declaring variable as optional
}
```

