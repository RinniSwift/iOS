## Operations

*Check this [commit](https://github.com/RinniSwift/iOS/commit/8c0ee9f6be53bf0f2d61e92c6acb534ae54c742b#diff-4eb7b58a99e2a7e3fd20269d29f6d31b) with only questions to attemp your own answers*

Find the answers to the following questions

Repo: https://github.com/Make-School-Courses/MOB-2.3-Concurrency-Parallelism-in-iOS/blob/master/Lessons/07-Operations-Pt2/Lesson7.md


1. What are 3 ways to create Operation Queues?

```swift
// 1. using the long form approach
let operationQueue: OperationQueue = OperationQueue()

// 2. customizing with name and quality of service
let operationQueue = OperationQueue()
operationQueue.name = "my operation queue name"
operationQueue.qualityOfService = .default

// 3. creating a private queue
private let operationQueue = OperationQueue()
```

2. Can I execute as many operations as I want at the same time?\
Yes. As long as it is in the maximum number of operations it can handle.


3. Can I execute the SAME operation in more than one thread?\
No. The app will crash. It is only allowed if you create a new instance of the same operation and add it to the other thread/queue. Check [this playground](https://github.com/RinniSwift/iOS/blob/master/Concurrency/operations.playground/Contents.swift) to see an example.


3. How can I access the main queue as an OperationQueue?\
Access the main queue from the operation queue by using the ```OperationQueue.main``` call.


4. What are 3 ways to add work into Operation Queues?\
Using the ```addOperation()```
```swift
// 1. adding one operation object
operationQueue.addOperation(opObject)
// 2. adding block of code
operationQueue.addOperation {
  print("insert block of code here")
}
// 3. adding multiple operation objects
operationQueue.addOperation([opObject1, opObject2, opObject3])
```

5. When does an operation leave a given queue?\
Operations leave a queue when all of its tasks are completed and are moved to the finished stage or when there is a cancel on it and it leaves.


6. How can you add an Operation twice in an OperationQueue?\
By creating a new instance of the operation.


7. How can you modify how an operation queue executes operations?\
You can modify them by using different priority levels, you can cancel them, you can give them maximum number of operations (```maxCurrentOperationCount```), and you can pause.


8. What is waitUntilAllOperationsAreFinished?\
A method to call when you want to execute the operation when all operations on that queue are finished.


9. What is the default  QoS level for an operation queue?\
```background```, or if it is on the main queue, it is ```userInitiated```


10. What is the difference between cancel() and cancelAllOperations()\
```cancel()``` is called on the operation object and removes it from the operation queue, ```cancelAllOperations()``` is called on the operation queue and removes all tasks/operations on the operation queue.
