{- |
Module			:	Huffman_Encode.hs
Description	    :	This file handles all functions for the encoding process.
Copyright		:	(c) Copyright 2011 Richard Easterling. All Rights Reserved. 
License			:	Released under the MIT license.

Maintainer		:	thegreatkzmn@gmail.com
Stability		:	unstable
Portability		:	portable


-}

module Huffman_Encode
()
where

import Huffman_Utils

{- |
Function: encode
This function takes the given huffTree and encodes it into an alphabet.
-}
encode :: HuffTree a -> Alphabet a
encode tree = encodeHelper [] tree

{- |
Function: encodeHelper
This helper function handles most of the logic for the encoding process.
-}
encodeHelper :: [Bit] -> HuffTree a -> Alphabet a
encodeHelper bits EmptyTree = []
encodeHelper bits (Leaf weight symbol) = [AlphabetEntry bits symbol]
encodeHelper bits (Node weight leftChild rightChild) =
    leftEncode ++ rightEncode where
        leftEncode = encodeHelper(bits ++ [L]) leftChild
        rightEncode = encodeHelper(bits ++ [R]) rightChild
 
{- |
Function: findCode
This function takes an encoded Alphabet and a symbol and returns the Huffman
code for that symbol.
-}        
findCode :: Eq a => Alphabet a -> a -> [Bit]
findCode [] _ = []
findCode ((AlphabetEntry bits symbol):entries) symbolToFind
    | symbol == symbolToFind = bits
    | otherwise = findCode entries symbolToFind
    
{- |
Function: encodeList
This function takes a list of Ord types and returns he huffman tree and list
of Bits.
-}
encodeList :: Ord a => [a] -> (HuffTree a, [Bit])
encodeList list = (tree, bits) where
    tree = makeTree list
    encoding = encode tree
    bits = concat $ map (findCode encoding) list