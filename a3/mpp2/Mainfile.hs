module Main where

import Parser
import ASTConv

import Language.LBNF.Compiletime
import Language.LBNF.Runtime

import System.Environment


main = do 
   args <- getArgs
   conts <- readFile (args!!0)
   let 
     tok    = myLexer conts
     ptree  = pProg tok
   case ptree of
      Ok tree -> do 
         let ast = transProg tree 
         putStrLn $ show ast 
      Bad str -> putStrLn str    