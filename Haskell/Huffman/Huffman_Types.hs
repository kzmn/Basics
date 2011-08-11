{- |
Module			:	Huffman_Types.hs
Description		:	This file creates basic types for Huffman encoding.
Copyright		:	(c) Copyright 2011 Richard Easterling. All Rights Reserved. 
License			:	Released under the MIT license.

Maintainer		:	thegreatkzmn@gmail.com
Stability		:	unstable
Portability		:	portable


-}
module Huffman_Types
(Bit,
HuffCode,
HuffTable)
where
    

data Bit = left | right
         deriving (Eq, Show)

type HuffCode = [Bit]

type HuffTable = [(Char, HuffCode)]