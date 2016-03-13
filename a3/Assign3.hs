module Assign3 where

-- Haskell module generated by the BNF converter

import LexAssignment
import ParAssignment
import SkelAssignment
import ErrM
import System.Environment
import AbsAssignment

main = do
	args <- getArgs
	conts <- readFile (args !! 0)
	let tok = tokens conts
	let ptree = pExpr tok       
	putStrLn $ show ptree
	case ptree of
		Ok  tree -> do
			let ast = transExpr tree
			putStrLn $ show ast
		Bad msg-> putStrLn msg