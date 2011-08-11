{- |
Module			:	Huffman_Types.hs
Description		:	This file creates basic types for Huffman encoding.
Copyright		:	(c) Copyright 2011 Richard Easterling. All Rights Reserved. 
License			:	Released under the MIT license.

Maintainer		:	thegreatkzmn@gmail.com
Stability		:	unstable
Portability		:	portable


-}
module Huffman_Utils
(Bit,
HuffCode,
HuffTable,
HuffTree,
getWeight)
where
    
import Data.List(sort)
    
{- |
Type: Bit
The Bit type is used to represent the bits that will be used in the encoding
scheme.  We will use the characters L and R rather than the traditional 1 and
0 here but will convert to a proper bytetream when writing to a file.
-}
data Bit = L | R
         deriving (Eq, Show)

{- |
Type: HuffCode
This type represents a huffman code, which is simply a list of bits.
-}
type HuffCode   = [Bit]

{- Type: HuffTable
This type represents a list of tuples containing Huffman Codes and their
corresponding character.
-}
type HuffTable  = [(Char, HuffCode)]

{- |
Data Type: HuffTree
This data type defines the tree structure used by the huffman encoding
algorithm.  A tree can be an EmptyTree which is simply nothing, a Leaf
which has an integer weight and a character from the alphabet that is being
encoded, and finally a node that has an integer weight and two sub trees.
-}
data HuffTree a = EmptyTree
                | Leaf{weight :: Int,
                       character :: Char}
                | Node {weight :: Int,
                        leftChild :: HuffTree a,
                        rightChild :: HuffTree a}
                deriving(Show, Read)
   
{- |
Function: getWeight
This function simply returns the weight of the given tree.
-}             
getWeight :: HuffTree a -> Int
getWeight EmptyTree = 0
getWeight (Leaf weight char) = weight
getWeight (Node weight leftChild rightChild) = weight

{- |
Function: makeNode
This function combines two subtrees to make a new node.
-}
makeNode :: HuffTree a -> HuffTree a -> HuffTree a
makeNode leftChild rightChild = Node weight leftChild rightChild where
    weight = ((getWeight leftChild) + (getWeight rightChild))

{- |
Function: getRoot
Given a list of HuffTrees this function will recursively combine these trees
into Nodes and will return the root Node when finished.
-}     
getRoot :: [HuffTree a] -> HuffTree a
getRoot [] = error "Can not get the root of an empty list."
getRoot (t0:[]) = makeNode t0 EmptyTree
getRoot (t0:t1:[]) = makeNode t0 t1
getRoot (t0:t1:ts) = (getRoot.sort) newList where
    newList = (makeNode t0 t1):ts
    

{- |
An instance of Ord for HuffTrees.  HuffTrees are simply ordered by weight.
-}   
instance Ord (HuffTree a) where
    compare x y = compare (getWeight x) (getWeight y)

{- |
An instance of Eq for HuffTrees.  HuffTrees are equal if their weights are
equal.
-}    
instance Eq (HuffTree a) where
    x == y = (getWeight x) == (getWeight y)

                                    


