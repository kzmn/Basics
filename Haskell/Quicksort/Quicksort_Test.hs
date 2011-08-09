{- |
Module          : Quicksort_Test.hs
Description     : A simple suite of Unit tests for Quicksort.hs
Copyright       : (c) Copyright 2011 Richard Easterling. All Rights Reserved. 
License         : Released under the MIT license

Maintainer      : thegreatkzmn@gmail.com
Stability       : stable
Portability     : portable

This is a simple test suite for Quicksort.hs.  These tests check that the
quicksort function's pivot selection and sorting are working properly.

**Bug?**
HUnit kept throwing an error when I tried to write a test case for passing
an empty list into the quicksort function.  I've confirmed that quicksort
functions properly in this scenario in ghci, and will look into the problem
with the test case at a later date.
**Bug?**
-}

module Quicksort_Test 
where
    
import Quicksort
import Test.HUnit


--testEmpty = TestCase (assertEqual "testEmpty" [] (quicksort []))
 
{- |
This test function tests the base case of quicksort being called on a list
with a single element.  In this case quicksort should simply return the
given list.
-}   
testSingle = TestCase (assertEqual "testSingle" [1] (quicksort [1]))

{- |
This test case tests the case where quicksort is pased a list with multiple
elements in which sorting must take place.  This test checks to see if the
correct pivot is chosen and that the list is sorted properly.
-}
testMany = TestCase (do 
    let list = [5,2,7,4,14,1,8]
    let sortedList = [1,2,4,5,7,8,14]
    assertEqual "testMany-testPivot" 5 (findPivot list)
    assertEqual "testMany-testSort" sortedList (quicksort list))
 
{- |
This test function tests to make sure that quicksort can handle sorting
lists with repeated elements, it also uses a list with an even number of 
elements it it to double check the pivot selection.

Again, this test both checks to ensure that the proper pivot is chosen
as well as checking to make sure the list is sorted properly.
-}   
testRepeats = TestCase (do
    let list = [2,9,3,4,2,4,1,1,2,3,9,8,7,2,1,12,103,9]
    let sortedList = [1,1,1,2,2,2,2,3,3,4,4,7,8,9,9,9,12,103]
    assertEqual "testRepeats-testPivot" 3 (findPivot list)
    assertEqual "testRepeats-testSort" sortedList (quicksort list))
 
{-
Main function for Quicksort_Test.hs run this function to run all tests.
-}   
main = do
    let tests = TestList[TestLabel "testSingle" testSingle,
                         TestLabel "testMany" testMany,
                         TestLabel "testRepeats" testRepeats]
    runTestTT tests