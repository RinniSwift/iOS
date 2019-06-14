import Foundation

let phrase = "Mobile is the greatest!"
let tokenOperation = BlockOperation()

for token in phrase.split(separator: " ") {
    tokenOperation.addExecutionBlock {
        print(token)
        sleep(2)
    }
}

// TODO: create completionBlock
tokenOperation.completionBlock = {
    print("All operations completed!")
}

duration {
    //TODO: start the operation
    tokenOperation.start()
}
