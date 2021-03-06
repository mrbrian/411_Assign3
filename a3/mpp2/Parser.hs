{-# LANGUAGE QuasiQuotes, TemplateHaskell #-}

module Parser  where

import Language.LBNF.Compiletime
import Language.LBNF(lbnf, dumpCode, bnfc)



bnfc [lbnf|

rules Prog ::= Block;

rules Block ::= Declarations Program_body;

rules Declarations ::= Declaration ";" Declarations
|;

rules Declaration ::= Var_declaration
| Fun_declaration
| Data_declaration;

rules Var_declaration ::= "var" Var_specs ":" Type;

rules Var_specs ::= Var_spec More_var_specs;

rules More_var_specs ::= "," Var_spec More_var_specs
|;

rules Var_spec ::= Ident Array_dimensions;

rules Array_dimensions ::= "[" Expr "]" Array_dimensions
|;

rules Type ::= "int"
| "real"
| "bool"
| "char"
| Ident;

rules Fun_declaration ::= "fun" Ident Param_list ":" Type "{" Fun_block "}";

rules Fun_block ::= Declarations Fun_body;

rules Param_list ::= "(" Parameters ")";

rules Parameters ::= Basic_declaration More_parameters
|;
rules More_parameters ::= ","  Basic_declaration More_parameters
|;

rules Basic_declaration ::= Ident Basic_array_dimensions ":" Type;

rules Basic_array_dimensions ::= "[" "]" Basic_array_dimensions
|;

rules Data_declaration ::= "data" Ident "=" Cons_declarations;

rules Cons_declarations ::= Cons_decl More_cons_decl;

rules More_cons_decl ::= "|" Cons_decl More_cons_decl
|;

rules Cons_decl ::= CID "of" Type_list
| CID;

rules Type_list ::= Type More_type;

rules More_type ::= "*" Type More_type
|;

rules Program_body ::= "begin" Prog_stmts "end"
| Prog_stmts;

rules Fun_body ::= "begin" Prog_stmts "return" Expr ";" "end"
| Prog_stmts "return" Expr ";";

rules Prog_stmts ::= Prog_stmt ";" Prog_stmts
|;

rules Prog_stmt ::= "if" Expr "then" Prog_stmt "else" Prog_stmt
| "while" Expr "do" Prog_stmt
| "read" Location
| Location ":=" Expr
| "print" Expr
| "{" Block "}"
| "case" Expr "of" "{" Case_list "}";

rules Location ::= Ident Array_dimensions;

rules Case_list ::= Case More_case;

rules More_case ::= "|" Case More_case
|;

rules Case ::= CID Var_list "=>" Prog_stmt;

rules Var_list ::= "(" Var_list1 ")"
|;

rules Var_list1 ::= Ident More_var_list;

rules More_var_list ::= "," Ident More_var_list
|;

rules Expr ::=  Expr "||" Bint_term
| Bint_term;

rules Bint_term ::= Bint_term "&&" Bint_factor
| Bint_factor;

rules Bint_factor ::= "not" Bint_factor
| Int_expr Compare_op Int_expr
| Int_expr;

rules Compare_op ::= "=" | "<" | ">" | "=<" |">=";

rules Int_expr ::= Int_expr Addop Int_term
| Int_term;

rules Addop ::= "+" | "-";

rules Int_term ::= Int_term Mulop Int_factor
| Int_factor;

rules Mulop ::= "*" | "/";

rules Int_factor ::= "(" Expr ")"
| "size" "(" Ident Basic_array_dimensions ")"
| "float" "(" Expr ")"
| "floor" "(" Expr ")"
| "ceil" "(" Expr ")"
| Ident Modifier_list
| CID Cons_argument_list
| IVAL
| RVAL
| BVAL
| CVAL
| "-" Int_factor;

rules Modifier_list ::= Fun_argument_list
| Array_dimensions;

rules Fun_argument_list  ::=  "(" Arguments ")";
rules Cons_argument_list ::=  Fun_argument_list
|;

rules Arguments ::= Expr More_arguments
|;

rules More_arguments ::= "," Expr More_arguments
|;

token CID '#'('_' | digit | letter)*;
token IVAL digit+;
token RVAL digit+ '.' digit+;
token BVAL ({"false"} | {"true"});
token CVAL '"' (letter | {"\n"} | {"\t"}) '"';

comment "/*" "*/" ;
comment "%" ;

|]
