# Memory Management

---
## Memory Management in Swift
Memory management plays a big role in allocating memory so that the program can perform at the request of the user and could be allocated or freed for reuse when no longer needed. *ARC* helps with managing and storing data

### ARC
Automatic Reference Counting helps with storing references into memory and helps with cleaning up when it's not being used.\
Reference counting only applies on instances of a class.\
Each time you create a class instance, ARC automatically creates some memory to store the information. but with the deinit() method, ARC will free the memory space of that instance. ARC relates to variables with references of *strong*, *weak*, or *unknowned*\
**Strong**: all variables are strong by default and can be changed by declaring weak or unknowned\
**Weak**: [weak references between objects with indipendant lifetime] with the property of weak, it will not increment the reference count. These references are always declared as optionals because the variable can be set to nil. With ARC, it automatically sets the weak reference to nil once the instance is deallocated.\
**Unknowned**: [unknowned references between objects of the same lifetime] these references similar to weak references but must always hold a value. When the objects will be reached at the same time and dealloced at the same time.

### Memory Leaks
A memory leak is a portion of memory that is occupied forever and never used again. or. Memory that was alloced at some point but was never released and is no longer referenced by the app. The main reason for memory leaks are caused by retain cycles.

#### Retain Cycles
When an object has a strong reference to another object, it is retaining it. objects in this case are reference types (classes) It is not possible to create retain cycles on value types. When an object references a second one, it owns it. the second object willl stay alive until you declare it nil.\
When object A retains object B and object B retains object A, there is a retain cycle. When two objects hold strong reference to each other, they cannot be dealloced. Retain cycles are broken when one of the references in the cycle is declared *weak* or *unknowned*. 
> Weak or unknowned references allow one instance in a reference cycle to refer to the other reference without keeping a strong hold on it.
When to use weak or unknowned: define a capture in a closure as unknowned when the closure and the instance it captures will always refer to each other and always be deallocated at the same time. Define a closure to be weak when the captured reference may become nil at any point in time.

###### what's dangerous about leaks?
- Increased memory footprint of the app.\
Direct consequence of objects not being released. As the actions that create those objects are repeated, the occupied memory will grow. Leads to mempory warning and then crashes.
- Introduces unwanted side effects.\
Imagine an object that starts listening to a notification when it is created in the *init*, to stop the listening of the notification, it has to be balanced by using the *deinit*. But, if the object leaks, it will never die and it will never stop listening to the notification.
- Crashes\
Multiple leaked objects altering the database, UI, entire state of the app, causes crashes\

### Debugging Memory leaks
- using the debug navigator tool in Xcode. This tool is for checking what contains in memory. Memory leaks will be indicated with exclamation marks on the right of the object.
- knowing what object owns the closure or other object:\
e.g.1 dealing with custom cells in UITableView: When you create an action closure in the custom cell which will be called when the button is tapped: The cycle goes like this; the action closre belongs to the cell but the cell belongs on the tableView which the tableView belongs to the tableViewController\
e.g.2 dealing with grand central dispatch. The view controller doesnt have any reference to it since the dispatchQueue is a singleton so worst case the singleton keeps a reference to the closure. In most cases when closures are executed, it will drop its reference to self since self doesnt have a reference to the closure, there will be no cycle. If there is a cycle, use *unknowned* if the closure cannot exist longer than the object it captures.

#### What happens when you exaust the memory? 
- The task will stop performing. 
- task will not progress but will continue running until it hits the limit and program crashes

---
## Stacks (value types)
static memory: When a function is called, whichever variables the functions contain gets stored in the stack until the function exits which the memory of those variables will automatically be deallocated. Stacks are FILO. When functions contain nested functions, the execution of all the functions remain suspended until the very last function return its value (meaning: the first function that gets stored in the stack muts return value until the memory of the function gets deallocated). This makes memory lookup and access very fast by how it is well organized. stacks are *FILO*: The most frequently reserved block is the first to be freed.

## Heap (reference types)
dynamic memory: variables are allocated to the heap at run time. Elements of the heap have no dependencies of each other and can always be accessed randomly.

### Stack and Heap differences
In multi-threaded situations, each thread has their own stack, but heap is application specific. 


###### *resources*
- [memory management in swift](https://www.appcoda.com/memory-management-swift/)
- [memory leaks in swift](https://medium.com/flawless-app-stories/memory-leaks-in-swift-bfd5f95f3a74)
- [understanding memory leaks in closures](https://medium.com/@stremsdoerfer/understanding-memory-leaks-in-closures-48207214cba)
