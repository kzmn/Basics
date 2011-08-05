
{- |
Module          : Quicksort.hs
Description     : A simple quicksort with median of three pivot selection.
Copyright       : (c) Copyright 2011 Richard Easterling. All Rights Reserved. 
License         : Released under the MIT license

Maintainer      : thegreatkzmn@gmail.com
Stability       : stable
Portability     : portable

Quicksort is a simple recursive sorting algorithm with O(log n) average time
and O(n^2) worst-case time.

Quicksort is also used as an example of how much simpler and more concise
haskell programs can be compared to it's imperitive counterparts.  These
examples, however, are extremely simplified versions of quicksort that
simply make the first element of the list the pivot.  In this implementation
I have included a simple median of three pivot selection that decreases the
chance of worst-case behavior significantly.
-}

module Quicksort
(quicksort)where -- Export only quicksort function, others should be private.

import Data.List
    
{- |
This quicksort function recursively sorts the given list using a median
of three pivot selection process.
-}
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort [x] = [x]
quicksort (x:xs) =
	let	pivot = findPivot (x:xs)
	 	smaller = quicksort (filter (<= pivot) xs)
		bigger 	= quicksort (filter (> pivot) xs)
	in	smaller ++ [pivot] ++ bigger

{- |
The findPivot function determines the pivot of the given list.  If the list
has one or two elements, the pivot is simply the first elemnet, otherwise,
this function sends the first, last, and middle elements of the list to the
medianOfThree function.
-}
findPivot :: (Ord a) => [a] -> a
findPivot [x] = x
findPivot [x,y] = x
findPivot (x:xs) =
	let firstElm = x
	    lastElm = last xs
	    middleElm = (x:xs) !! (quot (length (x:xs))  2)
	    median = findMedianOfThree firstElm lastElm middleElm
	in  median

{- |
The findMedianOfThree function takes three Ord typed elements, puts them
in a list, sorts the list, and finally selects the median element from the
sorted list.
-}
findMedianOfThree :: (Ord a) => a -> a -> a -> a
findMedianOfThree a b c =
	let list = [a,b,c]
	    sorted = sort list
	    median = sorted !! 1
	in  median