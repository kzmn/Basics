{- |
Module			:	Huffman_Types.hs
Description	    :	This file creates basic types for Huffman encoding.
Copyright		:	(c) Copyright 2011 Richard Easterling. All Rights Reserved. 
License			:	Released under the MIT license.

Maintainer		:	thegreatkzmn@gmail.com
Stability	    :	unstable
Portability		:	portable


-}
module Huffman_Utils
(Bit(L,R),
HuffCode,
HuffTree(EmptyTree,Leaf,Node),
AlphabetEntry(AlphabetEntry),
Alphabet,
makeTree)
where
    
import Data.List(sort, length, group)
import Control.Arrow
    
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
                        symbol :: a}
                | Node {weight :: Int,
                        leftChild :: HuffTree a,
                        rightChild :: HuffTree a}
                deriving(Show, Read)

{- |
Data Type: AlphabetEntry
This data type represents an entry in the alphabet that we are going to
encode.
-}                
data AlphabetEntry a = AlphabetEntry [Bit] a deriving (Eq, Show)

{- |
Type:  Alphabet
This type represents the alphabet of symbols that we are going to encode.
-}
type Alphabet a = [AlphabetEntry a] 
   
{- |
Function: getWeight
This function simply returns the weight of the given tree.
-}             
getWeight :: HuffTree a -> Int
getWeight EmptyTree = 0
getWeight (Leaf weight symbol) = weight
getWeight (Node weight leftChild rightChild) = weight

{- |
Function: makeNode
This function combines two subtrees to make a new node.
-}
makeNode :: HuffTree a -> HuffTree a -> HuffTree a
makeNode leftChild rightChild = Node weight leftChild rightChild where
    weight = ((getWeight leftChild) + (getWeight rightChild))

{- |
Function: combineTree
Given a list of HuffTrees this function will recursively combine these trees
into Nodes and will return the root Node of the combined tree when finished.
-}     
combineTree :: [HuffTree a] -> HuffTree a
combineTree [] = error "Can not get the root of an empty list."
combineTree (t0:[]) = makeNode t0 EmptyTree
combineTree (t0:t1:[]) = makeNode t0 t1
combineTree (t0:t1:ts) = (combineTree.sort) newList where
    newList = (makeNode t0 t1):ts
 
{- |
Function: freqCount
This function counts the number of times that each symbol appears in the
given list.
-}   
freqCount :: Ord a => [a] ->[(Int, a)]
freqCount = map (length &&& head).group.sort

{- |
Function: makeTree
This function builds a HuffTree out of a list of orderable types.
-}
makeTree :: Ord a => [a] -> HuffTree a
makeTree list = newTree where
    newTree = combineTree treeNodes
    treeNodes = (map(\(weight, symbol)-> Leaf weight symbol).freqCount) list
    

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

                                    


