
# Grand Central Dispatch *GCD or Dispatch*

*GCD organizes tasks into specific queues, and later on the tasks on the queues will get executed in a proper and available thread from the pool. The dispatch framework is a very fast and efficient concurrency framework*

## CPU's then and now
code executed by a CPU core is a thread. So your app is going to have many threads.
In the past a processor had one single core which means it can only deal wiht one task at a time.
Time-slicing was introduced so CPU's can run tasks concurrently(at the same time) using context-switching
As processors gained more core, they were capabale of multi-tasking using parallelism
Now, CPU's use hyperthreading (divides CPU clock cycles between different programs to run more than one program at a time)

## Synchronous and Asynchronous execution
Each work item can be executed either synchronously or asynchronously. 
with synchronous tasks, you'll block the execution queue, but with async tasks, your call will instantly return and the queue can automatically continue the execution of remaing tasks.

###### Synchronous
synchronous work items are called with the sync method. The program waits until the execution finishes before method call returns to continue the remaing tasks. functions with return types are most likely to be synchronous

###### Asynchronous
asynchronous work items are called with the async method. The method returns immediately. completion blocks are most likely to be asynchronous.
With dispatch queues, you can execute your code synchronously or asynchronously. with synchronous execution, the queue waits for the work. With asynchronous, the code returns emmidiately without waiting for the task to be complete.

> On every dispatch queue, tasks will be executed in the same order as you add them to the queue (FIFO) the first task in the line will be executed first but 
> the task completion is not guaranteed. task completion is up to the code complexity. not order.

## Serial and Concurrent queues
there are two types of dispatch queues: serial queues executes tasks one at a time. comcurrent tasks, execute tasks in parallell(same time)


## Main Queue (serial queue)
every task on the main queue runs on the main thread.

## Global Queue (concurrent queue)
concurrent queue shared throughout the operating system. including the background queue

## Custom Queue(serial or concurrent queue)
custom queues are mapped into global queues by specifying a QoS

# Networking in Swift

*Always use a background queue to perform network operations. Network requests usually take a long time to complete. If it were to be called on the main thread/queue, all other operations or tasks would have to wait until the network operation completes. Leading the app to become unresponsive.*
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





