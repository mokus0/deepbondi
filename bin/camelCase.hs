#!/usr/bin/env runhaskell
module Main where

import Data.Char

main = interact (unlines . map camelCase . lines)

camelCase = concat . map2 lowerCase titleCase . splitWords

map2 f g    []  = []
map2 f g (x:xs) = f x : map g xs

lowerCase = map toLower
titleCase = map2 toUpper toLower

wordSep c = isSpace c || isPunctuation c
splitWords str = case break wordSep (dropWhile wordSep str) of
    (word,     "") -> if null word then [] else [word]
    (word, _:rest) -> word : splitWords rest

