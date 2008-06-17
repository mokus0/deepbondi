{-
 -      ``Util/GetOpts''
 -      (c) 2008 James Cook
 -      
 -      very rough cut at a getopt work-alike.  consider adding
 -      documentation to 'OptSpec' and making the usage message more automagic.
 -      Also consider using predicates in place of constants for 'opt*Form'.
 -
 -      Alternatively, this whole thing could probably be more concisely
 -      expressed as a combinator-based parser.
 -}

module Util.GetOpts where

import Data.List
import System.Environment
import System.Exit

import qualified Data.Map as M

import Control.Arrow
import Data.Monoid

data OptSpec a 
        = Flag  { optShortForm  :: Char
                , optLongForm   :: String
                , flagValue     :: a
                }
        | Param { optShortForm  :: Char
                , optLongForm   :: String
                , paramValue    :: String -> a
                }

getOpts :: [OptSpec a] -> IO b -> IO ([a], [String])
getOpts optSpecs usage = do
        args <- getArgs
        getOpts' optSpecs usage args

getOpts' :: [OptSpec a] -> IO b -> [String] -> IO ([a], [String])
getOpts' optSpecs usage args = process [] [] args
        where
                shortForms = M.fromList (map (optShortForm &&& id) optSpecs)
                longForms  = M.fromList (map (optLongForm  &&& id) optSpecs)
                
                onErr code msg = do
                        putStrLn msg
                        usage
                        exitWith (ExitFailure code)
                
                process opts args [] 
                        = return (reverse opts, reverse args)
                process opts args ("--":rest)
                        = return (reverse opts, reverse args ++ rest)
                
                process opts args ("--help":rest)
                        = usage >> exitWith ExitSuccess
                
                process opts args (arg@('-':'-':flag):rest)
                        = case M.lookup flag longForms of
                                Nothing -> process opts (arg:args) rest
                                Just (spec@(Flag {}))   -> process (flagValue spec : opts) args rest
                                Just (spec@(Param {}))  -> case rest of
                                        (param:rest)    -> process (paramValue spec param : opts) args rest 
                                        []              -> onErr (-1) ("Error: " ++ arg ++ " requires a parameter.")
                process opts args (arg@('-':flags):rest)
                        = processShort opts args flags rest
                
                process opts args (arg:rest) = process opts (arg:args) rest
                
                processShort opts args [] rest
                        = process opts args rest
                processShort opts args (f:fs) rest
                        = case M.lookup f shortForms of
                                Nothing                 -> onErr (-1) ("Error: Unknown flag -" ++ f : "")
                                Just (spec@(Flag {}))   -> processShort (flagValue spec : opts) args fs rest
                                Just (spec@(Param {}))  -> onErr (-12) ("Error: short flags with params not yet implemented.")


--getOptsRaw :: [String] -> ([String], [String])
--getOptsRaw args = case break (=="--") args of
--        (pre, "--" : post)      -> f pre post
--        (pre, post)             -> f pre post
--        where f pre post = case partition ("--" `isPrefixOf`) pre of
--                (args, others)  -> (args, others ++ post)
