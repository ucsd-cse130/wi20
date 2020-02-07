module Lec_2_5_20 where

import Text.Printf

doc = [ (PHeader 1 "Notes from 130")                  -- Header
      , (PText "There are two types of languages")   -- RawText
      , (PList True [ "those people complain about" 
                    , "those people use!"  
                    ])
      ]


doc2Html :: [Para] -> String 
doc2Html []     = ""
doc2Html (p:ps) = (para2Html p) ++ "\n" ++ (doc2Html ps) 

para2Html :: Para -> String
para2Html p = case p of 
                (PHeader lvl str)      -> printf "<h%d>%s</h%d>" lvl str lvl 
                (PText   str)          -> printf "<p>%s</p>" str 
                (PList   ord things)   -> printf "<%s>%s</%s>" tag (unlines (things2Html things)) tag
                                          where 
                                              tag = if ord then "ol" else "ul"

things2Html :: [String] -> [String] 
things2Html []       = [] 
things2Html (t:rest) = (printf "<li>%s</li>" t) : (things2Html rest) 


blub = unlines ["<li>foo</li>",
                "<li>bar</li>",
                "<li>baz</li>"]

{- 
 PHeader 1 "Notes from 130"  --->    <h1>Notes from 130</h1>
 <p>There are two types of languages</p>
 <ol>
    <li> those people complain about </li> 
    <li> "those people use! </li>
 </ol>
 -}

{-
quiz = case (PText "hey!") of
          PHeader lev _ -> lev
          PText str     -> str
          PList ord _   -> ord
-}

rev :: [a] -> [a]
-- rev []    = []
-- rev (h:t) = (rev t) ++ [h]
rev xs           = helper [] xs

helper acc []    = acc 
helper acc (h:t) = helper (h:acc) t

{-
rev [1,2,3]

==> helper [] [1,2,3] 
==> helper [1]  [2,3] 
==> helper [2,1]  [3] 
==> helper [3,2,1] [] 

-}
data Para 
  = PHeader Int     String  
  | PText   String 
  | PList   Bool    [String] 
  deriving (Eq, Show)
