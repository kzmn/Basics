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

type HuffTable  = [(Char, HuffCode)]

{- |
Data Type: HuffTree
This data type defines the tree structure used by the huffman encoding
algorithm.  A tree can be an EmptyTree which is simply nothing, a Leaf
which has an integer weight and a character from the alphabet that is being
encoded, and finally a node that has an integer weight and two sub trees.
-}
data HuffTree   = EmptyTree
                | Leaf Int Char
                | Node Int HuffTree HuffTree
                deriving(Show, Read)
   
{- |
Function: getWeight
This function simply returns the weight of the given tree.
-}             
getWeight :: HuffTree -> Int
getWeight EmptyTree = 0
getWeight (Leaf weight char) = weight
getWeight (Node weight leftChild rightChild) = weight

