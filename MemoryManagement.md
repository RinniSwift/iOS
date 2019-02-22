# Memory Management

## Stacks
static memory: When a function is called, whichever variables the functions contain gets stored in the stack until the function exits which the memory of those variables will automatically be deallocated. Stacks are FILO. When functions contain nested functions, the execution of all the functions remain suspended until the very last function return its value (meaning: the first function that gets stored in the stack muts return value until the memory of the function gets deallocated). This makes memory lookup and access very fast by how it is well organized.
###### FILO
The most frequently reserved block is the first to be freed.
