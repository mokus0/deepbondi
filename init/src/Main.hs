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
 -
 -      I think I would like to eliminate the command-line processing in
 -      favor of strict configuration-by-environment.
 -}

module Main where

import System.Info
import Data.Version

import Control.Monad

import Util.GetOpts

import Shell.Basics
import Shell.Bash

import Actions.Preflight
import Actions.Path
import Actions.Interactive

data Options = 
        Options { shell         :: Maybe String
                , shellVersion  :: Maybe String
                }

defaultOptions =
        Options { shell         = Just "bash"
                , shellVersion  = Nothing
                }

options :: [OptSpec (Options -> IO Options)]
options = [ Param 's' "shell"           (\sh opts -> return $ opts {shell = Just sh})
          , Param 'v' "shell-version"   (\v  opts -> return $ opts {shellVersion = Just v})
          ]

usage = putStrLn "No usage help yet.  Use the source, Luke."

main = do
        (opts, args) <- getOpts options usage
        opts <- foldM (flip ($)) defaultOptions opts
        -- need an existential type and some lookups
        let sh = unknownBash
        
        comment sh ("init script generator compiled by " ++ compilerName ++ " " ++ showVersion compilerVersion)
        
        export sh "os" os
        export sh "arch" arch
        
        preflight   sh
        path        sh
        interactive sh
