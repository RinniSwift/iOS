
# Dictionary

*Under the hood, dictionaries store key and value pairs in a hashtable for storage.*
*Items do not contain any particular order*

## Hash Table
hash tables are basically arrays which are initially empty. To store data in a hashmap, a value is passed under a certain key. The hashtable uses that key to calculate an index in the array for the value to be stored. These arrays only store the value in the indices which were calculated from the keys hash value. Hash values are calculated by a hash function. 

## Hash Function
hash functions return hash values of a data passed in but how it works under the hood:
The function sums up the *unicode scalar* representation for each character in the word and also uses the SipHash algorithm. And that is simply the hash value.

###### Where next?
Once keys are passed in the hash function, we mod that abs(hashvalue) by number of items in the array and that will simply return an indice of which the value will be stored.

###### What if two values point to the same index?
That is called a collision. To avoid collisions, we simply use the chaining. where each array element contains a list with zero or more key-value pairs. The array elements are called **buckets** and the lists are called **chains** 