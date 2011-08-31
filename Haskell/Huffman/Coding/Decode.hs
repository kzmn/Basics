{- |
Module			:	Huffman.Coding.Decode
Description	    :	This file handles all functions for the encoding process.
Copyright		:	(c) Copyright 2011 Richard Easterling. All Rights Reserved. 
License			:	Released under the MIT license.

Maintainer		:	thegreatkzmn@gmail.com
Stability		:	unstable
Portability		:	portable

-}

module Decode
(decodeBits)
where
    
import Utils
import Encode

{- |
Function: decodeBits
Given a Huffman Tree and a list of bits, this function will decode the bits
and return a list with the pre-encoded data.
-}
decodeBits :: HuffTree a -> [Bit] -> [a]
decodeBits tree bits = decodeBitsHelper tree bits tree []

{- |
Function: decodeBitsHelper
This helper function handles the bulk of the logic for the decoding process.
This function recursively decodes the given bits depending on a number of 
cases.

Case1:  If an EmptyTree is given for the second HuffTree parameter simply
return an empty list, we can't decode anything without our current position
in the tree.

Case2: If the second tree parameter is a leaf, append it's symbol to the
return value and then return to the top of the tree.

Case3: If the bits list parameter is empty, return the reversed return list.*

Case4&5: If the second tree parameter is a node, check to see what the first
bit in the bits list is and traverse accordingly.

*During the decoding process we append newly decoded symbols to the front of
the return list and then reverse the return list at the end.  This is much 
more efficient than appending to the end of the list each time because 
haskell must traverse the entire list each time something is appended at the
end of it.
-}
decodeBitsHelper :: HuffTree a -> [Bit] -> HuffTree a -> [a] -> [a]
decodeBitsHelper _ _ EmptyTree _ = []
decodeBitsHelper tree bits (Leaf weight symbol)  ret =
    decodeBitsHelper tree bits tree (symbol:ret)
decodeBitsHelper _ [] _ ret = reverse ret
decodeBitsHelper tree (L:bits) (Node weight leftChild rightChild) ret =
    decodeBitsHelper tree bits leftChild ret
decodeBitsHelper tree (R:bits) (Node weight leftChild rightChild) ret =
    decodeBitsHelper tree bits rightChild ret