module AST where

data M_prog a = M_prog ([M_decl a],[M_stmt a])
           deriving (Eq,Show,Read)
data M_decl a = M_var (String,[M_expr a],M_type a)
            | M_fun (String,[(String,Int,M_type a)], M_type a,[M_decl a],[M_stmt a])
           deriving (Eq,Show,Read)
data M_stmt a = M_ass (String,[M_expr a], M_expr a)
            | M_while (M_expr a, M_stmt a)
            | M_cond (M_expr a, M_stmt a,M_stmt a) 
            | M_read (String, [M_expr a])
            | M_print (M_expr a)
            | M_return (M_expr a)
            | M_block ([M_decl a],[M_stmt a])
           deriving (Eq,Show,Read)
data M_type a = M_int | M_bool | M_real 
           deriving (Eq,Show,Read)
data M_expr a = M_ival Integer
            | M_rval Float
            | M_bval Bool
            | M_size (String,Int)
            | M_id (String,[M_expr a])
            | M_app (M_operation a,[M_expr a])
           deriving (Eq,Show,Read)
data M_operation a = M_fn String | M_add | M_mul | M_sub | M_div | M_neg
                 | M_lt | M_le | M_gt | M_ge | M_eq | M_not | M_and | M_or
                 | M_float | M_floor | M_ceil
           deriving (Eq,Show,Read)

