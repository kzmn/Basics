
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
(quicksort)where

import Data.List
    
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort [x] = [x]
quicksort (x:xs) =
	let	pivot = findPivot (x:xs)
	 	smaller = quicksort (filter (<= pivot) xs)
		bigger 	= quicksort (filter (> pivot) xs)
	in	smaller ++ [pivot] ++ bigger

findPivot :: (Ord a) => [a] -> a
findPivot [x] = x
findPivot [x,y] = x
findPivot (x:xs) =
	let firstElm = x
	    lastElm = last xs
	    middleElm = (x:xs) !! (quot (length (x:xs))  2)
	    median = findMedianOfThree firstElm lastElm middleElm
	in	median

findMedianOfThree :: (Ord a) => a -> a -> a -> a
findMedianOfThree a b c =
	let list = [a,b,c]
	    sorted = sort list
	    median = sorted !! 1
	in	median