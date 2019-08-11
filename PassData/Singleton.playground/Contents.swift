import UIKit

class SingletonA {
    
    static let shared = SingletonA()
    private init() { }
    
    var username: String?
}

struct SingletonB {
    
    static let shared = SingletonB()
    private init() { }
    
    var username: String?
    
}

var userOne = SingletonA.shared
var userTwo = SingletonA.shared
userTwo.username
userTwo.username = "Sarin"

userTwo.username
userOne.username
