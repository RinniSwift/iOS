
# Dictionary

*Under the hood, dictionaries store key and value pairs in a hashtable for storage.*
*Items do not contain any particular order*

## Hash Table
hash tables are basically arrays which are initially empty. To store data in a hash table, a value is passed under a certain key. The hashtable uses that key to calculate an index in the array for the value to be stored. These arrays only store the value in the indices which were calculated from the keys hash value. Hash values are calculated by a hash function. 

## Hash Function
hash functions return hash values of a data passed in but how it works under the hood:
The function sums up the *unicode scalar* representation for each character in the word and also uses the SipHash algorithm. 
The values that are returned by the hash function are called hash values, hash codes, hash sums, hash numbers, or simply hashes.

---
## Where next?
Once keys are passed in the hash function, we mod that abs(hashvalue) by number of buckets in the array and that will simply return an indice of which index the value will be stored in.

## Collision
Collisions are when your hash function creates duplicate indexes. To avoid collisions, we simply use linear probing or chaining. 
###### linear probing or open addressing
One way of dealing with collisions is with open addressing. This is when you shift the item to the next index until it finds a empty index. this can be O(n) linear time instead of O(1) constant time.
###### seperate chaining
Another way of dealing with collisions is to create buckets that have some sort list structure where items can be appended to. The array elements are called **buckets** and the lists are called **chains**



###### *resources*
- [raywenderlich hash tables](https://www.raywenderlich.com/206-swift-algorithm-club-hash-tables)
- [building a hash data structure in swift](https://medium.com/journey-of-one-thousand-apps/building-a-hash-data-structure-in-swift-e9b2733d9e20)