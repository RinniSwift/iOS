
import Foundation
import PlaygroundSupport

/*
 
 1. Creating a block operation
 2. adding tasks to a block operation
 3. adding a completion block to the block operation
 4. Creating an operation queue
 5. Adding an operation -- in this case, a block operation -- to the operation queue
 
 */

// 1) create printerOperation as BlockOperation
let printerOperation = BlockOperation()

// 2) add code blocks to the operation
printerOperation.addExecutionBlock { print("I") }
printerOperation.addExecutionBlock { print("am") }
printerOperation.addExecutionBlock { print("printing") }
printerOperation.addExecutionBlock { print("block") }
printerOperation.addExecutionBlock { print("operation") }

// 3) set completion block
printerOperation.completionBlock = {
    print("I'm done printing")
}

// 4) Create an OperationQueue
let operationQueue = OperationQueue()
// 5) add operation to queue
operationQueue.addOperation(printerOperation)

// 1. What did you notice about the order in which the submitted blocks execute?
//    The order of the submitted blocks were not in order. This is because Operation Queues run concurrently
// 2. How about the completionBlock's execution order?
//    THe completionBlock is always executed after all operations are completed.

/*
 
 -------------
 
 */

/*
 
 1. Creating an operation queue
 2. Creating an operation object
 3. Adding operation objects to the operation queue
 
 */

PlaygroundPage.current.needsIndefiniteExecution = true

// Operation Queue with .userInitiated QoS
let operationQueuee = OperationQueue()
operationQueuee.qualityOfService = .userInitiated

// Operation Object -- non concurrent operations
class MyOperation: Operation {
    override func main() {
        print("MyOp started") // typically long running tasks
        
    }
}

// creating an instance of the operation object
let myOp = MyOperation()
// adding a completion block to the operation object
myOp.completionBlock = {
    print("MyOp Completed")
}

// adding operation to the queue
operationQueuee.addOperation(myOp)

// operationQueuee only contains one object to complete which will only execute that one.


/*
 
 -------------
 
 */

/*
 
 1. Creating a new operation object
 2. Creating a new operation queue
 3. |error| adding the new created operation to the older operation queue and the new operation queue
 4. |error handle| created new instance of the new created operation and adding to the new operation queue
 
 */


class NewOperation: Operation {
    override func main() {
        print("NewOp started")
    }
}
let newOp = NewOperation()

let newOperationQueue = OperationQueue()
newOperationQueue.qualityOfService = .userInitiated

// |error|
operationQueue.addOperation(newOp)
newOperationQueue.addOperation(newOp)   // ERROR: cannot add newOp to both operation queues (line 107 & 108)

// |error handling| create new instance
let newInstOp = NewOperation()
newOperationQueue.addOperation(newInstOp)
