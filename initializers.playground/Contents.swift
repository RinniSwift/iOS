
class HumanBeing {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "not set")
        // Convenience init call the designated init method
    }
}

class Man: HumanBeing {
    var age:Int = 0
    
    override init(name: String) {
        super.init(name: name)
    }
    init(name: String, age:Int) {
        super.init(name: name)
        self.name = name
        self.age = age
    }
    
}

let manObj1 = Man() // calls convenience init of Human class
let manObj2 = Man(name: "Robert") // calls overriden init
let manObj3 = Man(name: "John", age: 10) // calls custom init
manObj1.name // prints “not set”
manObj2.name // prints “Robert”
manObj3.name // prints “John”
