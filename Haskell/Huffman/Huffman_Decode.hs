{- |
Module			:	Huffman_Encode.hs
Description	    :	This file handles all functions for the encoding process.
Copyright		:	(c) Copyright 2011 Richard Easterling. All Rights Reserved. 
License			:	Released under the MIT license.

Maintainer		:	thegreatkzmn@gmail.com
Stability		:	unstable
Portability		:	portable

-}

module Huffman_Decode
()
where
    
import Huffman_Utils

decodeString :: HuffTree a -> [Bit] -> [a]
decodeString tree bits = decodeStringHelper tree bit tree []

decodeStringHelper :: HuffTree a -> [Bit] -> HuffTree a -> [a] -> [a]
decodeStringHelper _ _ EmptyTree _ = []
decodeStringHelper tree bits (Leaf weight symbol) 