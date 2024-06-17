
# Lists
my_list = [1, 2, 3, 4, 5]
print(my_list)
print(type(my_list))
print(len(my_list))


#Methods:
# append(item): Adds an item to the end of the list.
my_list.append(6)
print(my_list)

# insert(index, item): Inserts an item at a specified position.
my_list.insert(0, 0)
print(my_list)

# remove(item): Removes the first occurrence of an item.

my_list.remove(3)
print(my_list)

# pop(index): Removes and returns the item at the given index.
item = my_list.pop(0)
print(my_list)

# clear(): Removes all items from the list.
my_list.clear()
print(my_list)

# index(item, start, end): Returns the index of the first occurrence of the item.

my_list = [1, 2, 3, 4, 5]
idx = my_list.index(3)
print(my_list)

# count(item): Returns the number of occurrences of the item.
count = my_list.count(2)
print(my_list)

# sort(key=None, reverse=False): Sorts the list in place.

my_list.sort()
print(my_list)

# reverse(): Reverses the list in place.

my_list.reverse()
print(my_list)

# Tuples
# Example:
my_tuple = (1, 2, 3, 4, 5)


# Methods:

# count(item): Returns the number of occurrences of the item.
count = my_tuple.count(2)
print(my_tuple)

# index(item, start, end): Returns the index of the first occurrence of the item.
idx = my_tuple.index(3)
print(my_tuple)

# DICTIONARY
# exmaple 
capitals = {'India':'New Dehli' , 'Japan':'Tokoyo' , 'Bangladesh':'Dhaka'}
print(capitals)
print(type(capitals))
print(len(capitals))

# Methods

print(capitals.keys()) # Return all the keys in dictionaries.
print(capitals.values()) # Return all the values in the dictionaries.

print(capitals.items()) # It return the list of dictionary key-value pairs
print(capitals.get('India')) # It will retuen the value of the Key

# SET
# -> It is an unordered collection of objects
# -> It does not allow any duplicated and are enclosed in curly brackets {}.
# -> They are immutable.

set = {3,4,5.19,"Arreyan" , "Hemanth"}
print(set)

# Len 
print(len(set))

# In operator
set = {3,4,5.19,"Arreyan" , "Hemanth"}
item_in = "Arreyan" in set
print(item_in) # True
item_iin = False in set
print(item_iin) # False bcoz it is not present in the set.

# METHODS IN SET
# 1. Union
set1 = {1,2,3,4,5,6}
set2 = {4,6,7,3,9,0}
print(set1.union(set2)) # It will include all the items from both sets without repetition.

# 2. Intersection
set1 = {1,2,3,4,5,6}
set2 = {4,6,7,3,9,0}
print(set1.intersection(set2)) # It will return only the common items from both the sets.

# 3. Difference
set1 = {1,2,3,4,5,6}
set2 = {4,6,7,3,9,0}
print(set1.difference(set2)) # It wil only include all the items fron set1 excluding the items from set2

# 4. Issubset
set1 = {1,2,3,4,5,6}
set2 = {4,6,7,3,9,0}
print(set1.issubset(set2)) # False bcoz set2 doesnot contain all the items from set1