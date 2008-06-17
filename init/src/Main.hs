#!/usr/bin/env runhaskell
{-
 -      ``Main''
 -      (c) 2008 James Cook
 -
 -      how to run this and 'source' its output?
 -      This seems to work (in bash 3.2.17 and 2.05b.0(1)):
 -
 -      $ source /dev/stdin << HERE
 -      > `runhaskell Main`
 -      > HERE
 -      
 -      (this also behaves rationally if "HERE" occurs in the output of Main)
 -      
 -      Order of preference for how this should execute (based primarily on speed):
 -        - precompiled binary
 -        - "runhugs -98"
 -        - "runhaskell"
 -}

module Main where

import System.Info
import Util.GetOpts
import Data.Monoid
import Control.Monad
import Data.Maybe
import Data.Version
import System

data Options =
        Options { setPath               :: Maybe Bool
                , interactive           :: Maybe Bool
                } deriving (Eq, Show)

defaultOptions = Options { setPath      = Just True
                         , interactive  = Just True
                         }

instance Monoid Options where
        mempty  = Options { setPath     = Nothing
                          , interactive = Nothing
                          }
        mappend a b -- note reverse order; b overrides a
                = Options { setPath     = setPath b     `mplus` setPath a
                          , interactive = interactive b `mplus` interactive a
                          }

options :: [OptSpec Options]
options = [ Flag 'r'    "rc"                    (mempty { setPath     = Just False })
          , Flag 'p'    "profile"               (mempty { setPath     = Just True  })
          , Flag 'i'    "interactive"           (mempty { interactive = Just True  })
          , Flag 'n'    "non-interactive"       (mempty { interactive = Just False })
          ]

usage = mapM putStrLn [ ""
                      , "Usage:  I'm not telling you, read the source!"
                      , ""
                      ]

main = do
        (optList, args) <- getOpts options usage
        
        when (not (null args)) $ do
                putStrLn ("Error: I don't know what to do with this: " ++ unwords args)
                usage
                exitWith (ExitFailure (-1))
        
        let opts = mconcat (defaultOptions:optList)
        let optSet f = fromJust (f opts)
        
        comment ("init script generator compiled by " ++ compilerName ++ " " ++ showVersion compilerVersion)
        
        export "os" os
        export "arch" arch
        
        when (optSet setPath)     (comment "path")
        when (optSet interactive) (comment "interactive")


-- operations that need to be abstracted and checked for proper escaping
comment :: String -> IO ()
comment str = mapM_ putStrLn ["# " ++ line | line <- lines str]

setEnv var val = putStrLn (var ++ "=" ++ val)
export var val = putStr "export " >> setEnv var val

echo :: [String] -> IO ()
echo = putStrLn . unwords . ("echo":)

