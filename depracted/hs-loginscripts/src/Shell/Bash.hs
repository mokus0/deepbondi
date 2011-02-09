{-
 -      ``Shell/Bash''
 -      (c) 2008 James Cook
 -}

module Shell.Bash where

import Data.Version
import Shell.Basics

data Bash = Bash Version
unknownBash = Bash (Version [] [])

instance ShellBasics Bash where
        fmtComment sh@(Bash v) str      = unlines ["# " ++ line | line <- lines str]
        fmtCommand sh@(Bash v)          = (++ "\n") . unwords
        setEnvCmd  sh@(Bash v) var val  = [var ++ "=" ++ val]
        exportCmd  sh@(Bash v) var val  = "export" : setEnvCmd sh var val
