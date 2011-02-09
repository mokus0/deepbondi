#!/usr/bin/env runhaskell
-- Quick and dirty import sorter for use with textmate's (or similar)
-- filter-through-command operation.
module Main where

import Data.List (sortBy)
import Data.Ord (comparing)

main = do
    text <- getContents
    let imports = lines text
    mapM_ putStrLn (sortBy (comparing modName) imports)

modName = modName' . words
modName' ("import" : "qualified" : name : rest) = Just (name : rest)
modName' ("import" : name : rest) = Just (name : rest)
modName' _ = Nothing
