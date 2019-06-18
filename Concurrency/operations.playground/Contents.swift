
import Foundation
import PlaygroundSupport

let printerOperation = BlockOperation() // 1) create printerOperation as BlockOperation

// 2) add code blocks to the operation
printerOperation.addExecutionBlock { print("I") }
printerOperation.addExecutionBlock { print("am") }
printerOperation.addExecutionBlock { print("printing") }
printerOperation.addExecutionBlock { print("block") }
printerOperation.addExecutionBlock { print("operation") }

printerOperation.completionBlock = { // 3) set completion block
    print("I'm done printing")
}

let operationQueue = OperationQueue() // 4) Create an OperationQueue
operationQueue.addOperation(printerOperation) // 5) add operation to queue


// 1. What did you notice about the order in which the submitted blocks execute?
//    The order of the submitted blocks were not in order.
// 2. How about the completionBlock's execution order?
//    THe completionBlock's order executed after all operations were completed.


/*
 
 creating an operation queue
 
 */

PlaygroundPage.current.needsIndefiniteExecution = true

// Queue
let operationQueuee = OperationQueue()
operationQueuee.qualityOfService = .userInitiated

class MyOperation: Operation {
    
    override func main() {
        print("MyOp started")
        // typically wrong running tasks
    }
}

let myOp = MyOperation()

myOp.completionBlock = {
    print("MyOp Completed")
}

operationQueuee.addOperation(myOp)
