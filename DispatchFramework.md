
#Grand Central Dispatch
##GCD or Dispatch

*GCD organizes tasks into specific queues, and later on the tasks on the queues will get executed in a proper and available thread from the pool. The dispatch framework is a very fast and efficient concurrency framework*

##CPU's then and now
code executed by a CPU core is a thread. So your app is going to have many threads.
In the past a processor had one single core which means it can only deal wiht one task at a time.
Time-slicing was introduced so CPU's can run tasks concurrently(at the same time) using context-switching
As processors gained more core, they were capabale of multi-tasking using parallelism
Now, CPU's use hyperthreading.

##Synchronous and Asynchronous execution
Each work item can be executed either synchronously or asynchronously. 
with synchronous tasks, you'll block the execution queue, but with async tasks, your call will instantly return and the queue can automatically continue the execution of remaing tasks.
######Synchronous
synchronous work items are called with the sync method. The program waits until the execution finishes before method call returns to continue the remaing tasks. functions with return types are most likely to be synchronous
######Asynchronous
asynchronous work items are called with the async method. The method returns immediately. completion blocks are most likely to be asynchronous.
With dispatch queues, you can execute your code synchronously or asynchronously. with synchronous execution, the queue waits for the work. With asynchronous, the code returns emmidiately without waiting for the task to be complete.

> On every dispatch queue, tasks will be executed in the same order as you add them to the queue (FIFO) the first task in the line will be executed first but 
> the task completion is not guaranteed. task completion is up to the code complexity. not order.

#Serial and Concurrent queues
there are two types of dispatch queues: serial queues executes tasks one at a time. comcurrent tasks, execute tasks in parallell(same time)


#Main Queue (serial queue)
every task on the main queue runs on the main thread.

#Global Queue (concurrent queue)
concurrent queue shared throughout the operating system. including the background queue

#Custom Queue(serial or concurrent queue)
custom queues are mapped into global queues by specifying a QoS
