# Common Concurrency Questions

1.What is concurrency?

Concurrency is the process of dividing up work of a program, algorithm, or problem into smaller components or units.

For tasks to run concurrently, they can be achieved on a single core, or multicore. With single core devices, it achieves with time-slicing. In which the OS uses context switching to alternate between multiple threads. On multi core devices, threads can be spread across all avaialable cores, allowing parallel processing.

2.What is parallelism?

Parallelism in iOS is when two or more tasks are executed at the same time, preferrably at the same clock cycle. To achieve parallelism, we mainly need more than one thread or queues. Without multiple threads, parallelism cannot be achieved. 

> Conucrrency is about structure while parallelism is about execution.
> Parallelism can be achieved without concurrency because it does not need to involve changes to the structure of the executed task.

3.What are most commonly used APIs to implement concurrency in iOS?

GCD such as semaphores. Operations which are of type NSOperations

4.What is a queue? What is their relationship with FIFO?

A queue is a data structure. In iOS, we use queues to handle concurrency. And what queues have are the FIFO operations. So when you add one, lets give an example; object, it will be the first one to be called no matter if it is a function or object.

5.What are all the different types of queues and their priorities?

- Serial queues: execute tasks in order as they are added
- Concurrent queues: execute tasks concurrently meaning they don't necessarily go in order. But we can modify the tasks order by using priority classes.

- Main Queues
- Global Queues
- Custom Queues

Priority classes:

- user initiated
- user interface
- utility
- background

6.What is the difference between an asynchronous and a synchronous task?

Asynchronous tasks, assuming they get added into a queue, will not be assured that the task will get executed right when we call it. This also goes with synchronous tasks but the difference with synchronous tasks, is that before the task gets executed, the queue must free all of its remaining tasks on there before 


7.What is the difference between a serial and a concurrent queue?

Serial queues are queues that execute tasks serially which means one from another. Next tasks execute only if the one before has completed. Concurrent queues execute tasks at the same time with no specific order.

8.How does GCD work?

GCD is a framework in iOS that deals with concurrency. It is an implementation of task parallelism based on the Thread Pool design pattern. tasks are executed and seperated into their appropriate queues. The developer just has to declare the tasks and GCD handles what goes on in the background. This is mainly to move the management of the thread pool out of the developers hands and closer to the OS.


9.Explain the relationship between a process, a thread and a task.

A process is part of a computer program that is being executed. A process can be made up of multiple threads of execution that execute tasks concurrently.

A thread is contained inside a process. 

A task is a set of instructions the program loads in memory. it contains 


10.Are there any threads running by default? Which ones?

Apps launch on the main thread or the UI thread. Then as we create new tasks, without specifying a QoS, is treated as default.


11.How does iOS support multithreading?

iOS has frameworks and tools that help in dealing with multithreads. iOS supports multithreading by creating concurrent threads it can switch between, so multiple tasks can be executed at the same time. With this context switching it appears as if the tasks are executed simultaneously.


12.What is NSOperation? and NSOperationQueue?

NSOperation is an instance of NSObject which will be the tasks or class instances and NSOperationQueue will be where the tasks get executed.

13.What is QoS?

Quality of Service.

14.Explain priority inversion.

when higher priorities depend on lower priorities so the lower priority task must shift its priority up.

15.Explain dependencies in Operations.
16.When do you use GCD vs Operations?

17.How do we know if we have a race condition?

inconsistent, wrong values, unexpected results.

18.What is deadlock?

when two tasks are waiting for each other to finish. When you call sync on main

19.What is context switching in multithreading?

20.What are the ways we can execute an Operation? How are they different?

- creating instances of operations and adding to queue
- using the start method

21.What is DispatchSemaphore and when can we use it?


22.What happens if you call sync() on the current or main queue?

deadlock.











