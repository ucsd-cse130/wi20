data Date = Date Int Int Int
data Time = Time Int Int Int

deadlineDate :: Date
deadlineDate = Date 4 27 2018

deadlineTime :: Time
deadlineTime = Time 23 59 59










data Paragraph = 
    Text String
  | Heading Int String
  | List Bool [String]
  
  
doc :: [Paragraph]
doc = [
    Heading 1 "Notes from 130"
  , Text "There are two types of languages:"
  , List True ["purely functional", "purely evil"]
  ]

toHtml :: [Paragraph] -> String
toHtml ps = unlines [html p | p <- ps]
  
html :: Paragraph -> String
html (Text str)        = unlines [open "p", str, close "p"]
html (Heading lvl str) = let htag = "h" ++ show lvl
                         -- in unwords [open htag, str, close htag]
-- html (Heading 0 str)     = html (Heading 1 str)                         
html (List ord items)  = let 
                           ltag = if ord then "ol" else "ul"
                           litems = [unwords [open "li", i, close "li"] | i <- items]
                         in unlines ([open ltag] ++ litems ++ [close ltag])
                                               
open t = "<" ++ t ++ ">"
close t = "</" ++ t ++ ">"








html1 p =
  case p of
    Text str -> unlines [open "p", str, close "p"]
    Heading lvl str -> let htag = "h" ++ show lvl
                       in unwords [open htag, str, close htag]
    List ord items -> let 
                       ltag = if ord then "ol" else "ul"
                       litems = [unwords [open "li", i, close "li"] | i <- items]
                      in unlines ([open ltag] ++ litems ++ [close ltag])
                      
                      
                      
                      






                      
data Nat = Zero | Succ Nat
  deriving Show
  
  
one = Succ Zero
two = Succ (Succ Zero)
three = Succ (Succ (Succ Zero))

toInt :: Nat -> Int
toInt Zero     = 0           -- base case
toInt (Succ n) = 1 + toInt n -- inductive case


tmp1 = let foo i = if i <= 0 then Zero else Succ (foo (i - 1))
       in foo 2
       
       
       
       
       
       
fromInt :: Int -> Nat
fromInt n
  | n <= 0    = Zero                   -- base case
  | otherwise = Succ (fromInt (n - 1)) -- inductive case
       






       
add :: Nat -> Nat -> Nat
add Zero m = m
add (Succ n) m = Succ (add n m)



sub :: Nat -> Nat -> Nat
sub n Zero = n
sub Zero _ = Zero
sub (Succ n) (Succ m) = sub n m










data List = Nil
          | Cons Int List
  deriving Show
  
len :: List -> Int
len Nil         = 0
len (Cons _ xs) = 1 + len xs

append :: List -> List -> List
append Nil ys = ys
append (Cons x xs) ys = 
  Cons x (append xs ys)
  



















data Expr = Num Float
          | Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr
          

          
          
          
          
          
-- 4.0 + 2.9          
exp1 = Add (Num 4.0) (Num 2.9)

-- 3.78 – 5.92
exp2 = Sub (Num 3.78) (Num 5.92)

-- (4.0 + 2.9) * (3.78 -5.92)
exp3 = Mul exp1 exp2



          
eval :: Expr -> Float
eval (Num f)     = f
eval (Add e1 e2) = eval e1 + eval e2
eval (Sub e1 e2) = eval e1 - eval e2
eval (Mul e1 e2) = eval e1 * eval e2


                      

  