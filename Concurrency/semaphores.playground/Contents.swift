import UIKit


let semaphore = DispatchSemaphore(value: 1)
DispatchQueue.global().async {
    print("Person 1 - wait")
    semaphore.wait()
    print("Person 1 - wait finished")
    sleep(1) // Person 1 playing with Switch
    print("Person 1 - done with Switch")
    semaphore.signal()
}
DispatchQueue.global().async {
    print("Person 2 - wait")
    semaphore.wait()
    print("Person 2 - wait finished")
    sleep(1) // Person 2 playing with Switch
    print("Person 2 - done with Switch")
    semaphore.signal()
}


func downloadMovies(numberOfMovies: Int) {
    // Create a semaphore
    let semaphore = DispatchSemaphore(value: numberOfMovies)
    
    // Run the tasks on a background thread.
        // Launch 8 tasks
        // Each task should wait (pretend downloading takes 2 seconds) and inform the console once it's done.
    for i in 1...8 {
        DispatchQueue.global().async {
            semaphore.wait()
            sleep(2)
            print("task \(i)")
            // Let the semaphore know when you release the resource
            semaphore.signal()
        }
    }
}
downloadMovies(numberOfMovies: 2)
