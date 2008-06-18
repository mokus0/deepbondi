{-
 -      ``Shell/Basics''
 -      (c) 2008 James Cook
 -}

module Shell.Basics where

type Cmd = [String]

class ShellBasics shell where
        fmtComment :: shell -> String -> String
        fmtCommand :: shell -> Cmd -> String
        setEnvCmd  :: shell -> String -> String -> Cmd
        exportCmd  :: shell -> String -> String -> Cmd

comment sh str  = putStr (fmtComment sh str)
command sh strs = putStr (fmtCommand sh strs)
setEnv  sh var val = putStr (fmtCommand sh $ setEnvCmd sh var val)
export  sh var val = putStr (fmtCommand sh $ exportCmd sh var val)
        
echo sh strs = command sh ("echo" : strs)

