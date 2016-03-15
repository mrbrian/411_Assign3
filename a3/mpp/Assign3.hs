module Main where

-- Haskell module generated by the BNF converter

import Text.PrettyPrint 
import Text.PrettyPrint.GenericPretty
import LexMpp
import ParMpp
import ErrM
import System.Environment
import AbsMpp
import SkelMpp
import AST
  
instance (Out a) => Out (M_prog a) where
  doc (M_prog (a, b)) = parens $ text "M_prog" 
                           $$ nest 2 (docList a)
                           $$ nest 2 (docList b)
  docPrec _ = doc

instance (Out a) => Out (M_decl a) where
  docList [] = text "[]"
  docList (as) = brackets (vcat (punctuate (text ",") (map (\a ->  nest 0 (doc a)) as)))
  doc (M_var (a, b, c)) = text "M_var" $$ nest 2 (parens $ hsep (punctuate (text ",") [doc a, docList b, doc c] ))
  doc (M_fun (a, b, c, d, e)) = text "M_fun" $$ nest 2 (parens $ vcat (punctuate (text ",") [doc a, docList b, doc c, docList d, docList e]))
  doc (M_data (a, b)) = text "M_data" $$ nest 2 (parens $ vcat (punctuate (text ",") [doc a, docList b]))
  docPrec _ = doc

  
instance (Out a) => Out (M_stmt a) where
  docList [] = text "[]"
  docList (as) = brackets (vcat (punctuate (text ",") (map (\a ->  nest 0 (doc a)) as)))
  doc (M_ass (a, b, c))  = text "M_ass"    $$  nest 2 (parens $ (vcat (punctuate (text ",") [doc a, doc b, doc c])))
  doc (M_while (a, b))   = text "M_while"  $$  nest 2 (parens $ (vcat (punctuate (text ",") [doc a, doc b])))
  doc (M_cond (a, b, c)) = text "M_cond"   $$  nest 2 (parens $ (vcat (punctuate (text ",") [doc a, doc b, doc c])))
  doc (M_read (a, b))    = text "M_read"   $$  nest 2 (parens $ hsep (punctuate (text ",") [doc a, doc b]))
  doc (M_print (a))      = text "M_print"  $$  nest 2 (parens (doc a))
  doc (M_return (a))	 = text "M_return" $$  nest 2 (parens (doc a))
  doc (M_block (a, b))   = text "M_block"  $$  nest 2 (parens $ (vcat (punctuate (text ",") [doc a, doc b])))
  doc (M_case (a, b))   = text "M_case"  $$  nest 2 (parens $ (vcat (punctuate (text ",") [doc a, doc b])))
  docPrec _ = doc


instance (Out a) => Out (M_type a) where
  doc M_int  = text "M_int"
  doc M_bool = text "M_bool"
  doc M_real = text "M_real"
  doc M_char = text "M_bool"
  doc (M_type a) = text "M_real"
  docPrec _ = doc

instance (Out a) => Out (M_expr a) where
  docList [] = text "[]"
  docList (as) = brackets (vcat (punctuate (text ",") (map (\a ->  nest 0 (doc a)) as)))
  doc (M_ival a) = text "M_ival" <+> (doc a)
  doc (M_rval a) = text "M_rval" <+> (doc a)
  doc (M_bval a) = text "M_bval" <+> (doc a)
  doc (M_cval a) = text "M_cval" <+> (doc a)
  doc (M_size (a,b)) = text "M_size" $$ nest 2 (parens $ hsep (punctuate (text ",") [doc a, doc b]))
  doc (M_id (a, b))  = text "M_id"   $$ nest 2 (parens $ hsep (punctuate (text ",") [doc a, doc b]))
  doc (M_app (a, b)) = text "M_app"  $$ nest 2 (parens $ vcat (punctuate (text ",") [doc a, doc b]))
  docPrec _ = doc
		   
instance (Out a) => Out (M_operation a) where
  doc (M_fn a) =  text "M_fn" <+> (parens (doc a))
  doc (M_cid a) = text "M_cid" <+> (parens (doc a))
  doc (M_add)  =  text "M_add"  
  doc (M_mul)  =  text "M_mul"  
  doc (M_sub)  =  text "M_sub"
  doc (M_div)  =  text "M_div"
  doc (M_neg)  =  text "M_neg"
  doc (M_lt)   =  text "M_lt" 
  doc (M_le)   =  text "M_le" 
  doc (M_gt)   =  text "M_gt" 
  doc (M_ge)   =  text "M_ge" 
  doc (M_eq)   =  text "M_eq" 
  doc (M_not)  =  text "M_not"
  doc (M_and)  =  text "M_and"
  doc (M_or)   =  text "M_or" 
  doc (M_float) = text "M_float"
  doc (M_floor) = text "M_floor"
  doc (M_ceil)  = text "M_ceil" 
  docPrec _ = doc  
  	   
		   
main = do
    args <- getArgs
    conts <- readFile (args !! 0)
    let tok = tokens conts
    let ptree = pProg tok       
    putStrLn $ show ptree
    case ptree of
        Ok  tree -> do
            let ast = transProg tree
            putStrLn $ show ast
            pp ast
        Bad msg-> putStrLn msg