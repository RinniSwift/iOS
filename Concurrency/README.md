
## CPU's then and now
code executed by a CPU core is a thread. So your app is going to have many threads.
In the past a processor had one single core which means it can only deal wiht one task at a time.
Time-slicing was introduced so CPU's can run tasks concurrently(at the same time) using context-switching
As processors gained more core, they were capabale of multi-tasking using parallelism
Now, CPU's use hyperthreading (divides CPU clock cycles between different programs to run more than one program at a time)

# Concurrency and Application Design
*Threads have been around for a while. OS X and iOS take an asynchronous design approach to solve the concurrency problem with the following technologies: GCD and Operation Queues.*

### Thread
The developer has to decide how many threads to create and adjust the number dynamically as system conditions change. So creating asynchronous tasks with threads, developers need to create tasks for execution as well as creating and managing threads. That is why OS X and iOS provides technologies to allow you to perform any task asynchronously without having to manage the threads yourself.

**GCD**\
Moves the thread management code down to the system level. All you have to do is define tasks you want to execute and put them in the appropriate dispatch queue. GCD takes care of creating the needed threads and scheduling tasks to run on those threads.

**Operation Queues**\
Are *Objective-C* objects that act very much like dispatch queues. You define the tasks you want to execute and add them to an aperation queue. Which handles scheduling and execution of those tasks.


# Grand Central Dispatch *GCD or Dispatch*

*GCD organizes tasks into specific queues, and later on the tasks on the queues will get executed in a proper and available thread from the pool. The dispatch framework is a very fast and efficient concurrency framework*

## Synchronous and Asynchronous execution
Each work item can be executed either synchronously(serially) or asynchronously(concurrently). 
with synchronous tasks, you'll block the execution queue, but with async tasks, your call will instantly return and the queue can automatically continue the execution of remaing tasks.

###### Synchronous
synchronous work items are called with the sync method. The program waits until the execution finishes before method call returns to continue the remaing tasks. functions with return types are most likely to be synchronous

###### Asynchronous
asynchronous work items are called with the async method. The method returns immediately. completion blocks are most likely to be asynchronous.
With dispatch queues, you can execute your code synchronously or asynchronously. with synchronous execution, the queue waits for the work. With asynchronous, the code returns emmidiately without waiting for the task to be complete.

> On every dispatch queue, tasks will be executed in the same order as you add them to the queue (FIFO) the first task in the line will be executed first but 
> the task completion is not guaranteed. task completion is up to the code complexity. not order.

## Serial Queues
Also known as *private dispatch queues* executes one task at a time in the order that they were added to the queue. The currently executed tasks are run on distinct threads and serial queues are often used to synchronize access to a specific resource.

## Concurrent queues
Also known as *global dispatch queues* execute one or more tasks concurrently. But tasks are still started in order of how they were added. 

## Main Dispatch Queue 
The main dispatch queue is a globally available serial queue that executes tasks on the application’s main thread. 

## QoS
A Quality of Service class allows you to categorize work to be performed by NSOperation, NSOperationQueue, NSThread objects, and dispatch queues.\
When setting up global dispatch queues, you don't specify the priority directly but you are required to specify a quality of service which guides GCD into determining the priority level to give the task.\
GCD provides 4 quality of services:

- ```.userInteractive```: work that is interacting with the user and requires instant visual layout such as tasks that update the UI on the main thread; refreshing the ui, performing animations. Focuses on responsiveness and performance.
- ```.userInitiated```: work that the user initiated and requires immediate results. e.x. opening a document, doing something when user taps on button. The work is required to continue  user interaction. Focuses on responsiveness and performance.
- ```.utility```: work that may take some time that doesn't require emmediate results. e.x. downloading or importing data. Focuses on a balance between responsiveness, performance, and energy efficiency.
- ```.background```: work that operates in the background and isn't visible to the user. e.x. indexing, synchronizing, and backups. Focuses on energy efficiency.

*Explanation*: Use QoS level of userInitiated or lower for optimization.

And two special quality of services:
- ```.default```: the priority falls between user-initiated and utility.
- ```.unspecified```: this represents the absence of qos and cues the system an environmental qos should be inferred.
These two special cases we won't be exposed to but they do exist.


> If your app uses operations and queues to perform work, you can specify a QoS for that work. 
> NSOperation and NSOperationQueue both have a property called ```qualityOfService``` of type ```NSQualityOfService``` 
> ```swift
> let myOperation: NSOperation = MyOperation()
> myOperation.qualityOfService = .Utility
> ```
> DisptachQueues have a property you declare when calling initializing the queue
> ```swift
> let queue = DispatchQueue.global(qos: .utility)
> ```
> NSThread have a property of ```qualityOfService``` of type ```NSQualityOfService```
> ```swift
> let queue = DispatchQueue.global(qos: .utility)
> ```

#### Priority Inversions
When high priority work becomes dependant on lower priority work, or it becomes the result of lower priority work, a *priority inversion* occurs. As a result, blocking, spinning, or polling may occur.\
In the case of synchronous work, the system will resolve by raising the QoS of the lower priority queue for the duration of the inversion. \
In the case of asynchronous work, the system will resolve on a serial queue.


## Technologies that use dispatch queues

- **dispatch groups**: A way to monitor a set of block objects for execution.
- **dispatch semaphores**: They're genrally similar to semaphores but are more efficient. 
- **dispatch sources**: It generates notifications in response to specific types of system events. Example is used to monitor events such as process notifications, signals, and descriptor events.

# Operation Queues
*Operation Queues is the cocoa equivalent of a concurrent dispatch queue. And is implemented using the* **NSOperationQueue** *class. Whereas dispatch queues execute tasks in FIFO, operation queues take other factors into account determining the execution of tasks.*

The tasks you submit to an operation queue must be instances of the NSOperation class. The **NSOperation** is an abstract base class. So you must define custom subclasses to perform your tasks. And they allow you to encapsulate a unit of work into a package that you can submit for execution at some time in the future.

**Key Attributes**
- generates key-value observing
- subsribes a single unit of work
- higher level of abstraction over GCD
- object oriented vs. functions and closures in GCD
- execute concurrently -- but can be serial by using dependencies
- offers more developer control -- over the operations lifecycle (*insight and control into the execution of tasks*)

**Control over operation lifecycle**
- *Max number of operations*: You can specify the max number of queues in an ```OperationQueue``` that can run simultaneously.
- *Execution priority levels*: You can configure the priority level of an operation in an operation queue.
- *Pause, Resume, Cancel*: Operations can also be paused resumed and canceled.

**4 operation lifecycle events**
- *Pending*: starts off pending when you add operations to the queue
- *Ready*: as soon as the conditions are fulfilled, it enters a ready state and in case there is an open slot, it will start executing
- *Finished*: task will be removed out of the OperationQueue
- *Canceled*: each state can be cancelled at any point. Except finish state

**Executing Operations**\
Typically you submit them to an operation queue. The operations gets executed either *directly*, running on a secondary thread, or *indirectly*, using the ```libdispatch``` library (aka, GCD). Another way to execute operations are by calling the ```start()``` method. Because operations can still not be in the stage where it is ready to process, calling the *start()* can put some burden on your app.

**Operation Properties** *the KVO key paths associated with an operations state at various life cycles -- read only*
- *isReady*: Lets clients know when an operation is ready to execute. ```true``` when the operation is ready to execute now or ```false``` if there are still unfinished operations on which it is dependent.
- *isExecuting*: Once the ```start()``` method is invoked, your operation moves to the isExecuting state. ```true``` if the operation is actively working on its assigned task or ```false``` if it is not.
- *isCancelled*: Informs clients that the cancellation of an operation was requested. If true, the app calls the cancel method, then it will transition to the isCancelled state, before moving onto the isFinished state.
- *isFinished*: Lets clients know that an operation finished its task successfully or was cancelled and is exiting. If it was not canceled, then it will move directly from isExecuting to isFinished. Marking operations as finished is critical to keeping queues from backing up with in-progress or cancelled operations.

*NOTE: all of these states are handled by the Operation class. The only states you can manipulate are the isExecuting and isCanceled by calling the cancel() method on the object*

More on using Operations [here](https://github.com/RinniSwift/iOS/blob/master/Concurrency/operations.playground/Contents.swift)\
and [here](https://github.com/RinniSwift/iOS/blob/master/Concurrency/BlockOperation_ex2.playground/Contents.swift)\
Check [this file](https://github.com/RinniSwift/iOS/blob/master/Concurrency/operationQA.md) for more Q&A about Operations.


---
# Networking in Swift

*All network sessions use a background queue to perform network operations. Network requests usually take a long time to complete. If it were to be called on the main thread/queue, all other operations or tasks would have to wait until the network operation completes. Leading the app to become unresponsive.*
*Always call network operations on the background queue by using GCD. Return back to the main queue once recieved results since all interactions and visual displays occur in the main thread.*

## URL, URLRequests, URLSessions, and URLSessionTask

###### URL
> URL class represents a local or remote URI.
```swift
var url = URL(string: "https://apple.com")
```

###### URLRequest
> URLRequest represents a proper request for a URL
```swift
var request = URLRequest(url: url!)
request.httpMethod = "GET"
```

###### URLSession
> URLSession is a class that allows to perform a URLRequest. Most of the time we use a singleton instance called "shared" if we don't need any special configuration. Other than that, we can create URLSessionConfigurations which contain these most common instances: default, ephumeral, and background.
```swift
var session = URLSession.shared
var sessionDefault = URLSession(configuration: .default)

\\ downloading a webpage
var dataTask = session.dataTask(with: url) { data, response, error in
	...
}
dataTask.resume()
```

###### URLSessionTask
> URLSessionTask is a class that performs the actual transfer of data. The most common session task is URLSessionDataTask(retrieves the contents of the url as a Data object) !The URLSession class instantiates the task itself under the hood. Also remember to resume all tasks with the resume() method or the task wont start.
```swift
var url = URL(string: "https://apple.com")
```


# Semaphores
Semaphores acts as the decision maker about what shared resource gets displayed on the thread indicating with the wait() and signal() function. They consist of threads queue and counter value.
- *Threads Queue*: Used by the semaphore to keep track of what has acces to the shared resource first. This is in FIFO order. (First thread entered will be the first to get access to the shared resource once avaiable)
- *Counter Value*: used by the semaphore to decide if a thread should get access to the shared resource or not. This value changes when called *signal()* or *wait()* functions.\
\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Call *wait()* before using the shared resource. To ask if the shared resource is available or not. should not be called on the main thread since it will freeze the app.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Call *signal()* after using the resource. Signaling the semaphore that we are done interacting with it.

**Thread safe**: *Code that can be safely called from multiple threads and not cause any issues.*

- Below Is a sample simulation of 2 people using a Switch--shared resource.

```swift
let semaphore = DispatchSemaphore(value: 1)
DispatchQueue.global().async {
    semaphore.wait()
    sleep(1) // Person 1 playing with Switch
    print("Person 1 - done with Switch")
    semaphore.signal()
}
DispatchQueue.global().async {
    semaphore.wait()
    print("Person 2 - wait finished")
    sleep(1) // Person 2 playing with Switch
    print("Person 2 - done with Switch")
    semaphore.signal()
}
```
*Explanation*: declare the semaphore counter value to 1 indicating that we only want the resource to be accessible by one thread. Then we call the ```wait()``` to make sure we can access the resource and execute the task and don't forget to call the ```signal()``` to signal that we are done using the resource.\

More on using semaphores [here](https://github.com/RinniSwift/iOS/blob/master/Concurrency/semaphores.playground/Contents.swift).

## Semaphores and GCD
Dispatch groups are used when you have a load of things you want to do that can happen all at once.\
Semaphores are used when you have a resource that can be accessed by N threads at the same time. They are used mainly for multiple tasks that use the same resource.


### Resources
- [A quick look at semaphores in Swift](https://medium.com/swiftly-swift/a-quick-look-at-semaphores-6b7b85233ddb)
- [The beauty of semaphores](https://medium.com/@roykronenfeld/semaphores-in-swift-e296ea80f860)
