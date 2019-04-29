
import Prelude hiding (sum, length, lookup, take)
import Data.Char
import Debug.Trace
import Text.Printf 

{- 

# Notes from 130 

There are two types of languages:

1. Those that people complain about
2. Those that no one uses

-}

data Para 
  = PHead Int String
  | PText String
  | PList Bool [String]


doc :: [Para]
doc = [ PHead 1 "Notes from 130"                        
      , PText "There are two types of languages:"       
      , PList True [ "Those that people complain about" 
                   , "Those that no one uses"
                   ]
      ]

-- >>> toHtml (PHead 1 "Notes from 130")
-- "<h1>Notes from 130</h1>"
--

-- >>> toHtml (PText "There are two types of langs")
-- "<p>There are two tyeps of langs</p>"
--

-- >>> toHtml (PList True ["This", "That"])
-- *** Exception: /Users/rjhala/teaching/130-sp19/static/raw/lec_4_26_2019.hs:(53,1)-(54,58): Non-exhaustive patterns in function toHtml
-- <BLANKLINE>
-- "
--


toHtml :: Para -> String
{- 
toHtml p = case p of 
            PHead lvl txt    -> printf "<h%d>%s<h%d>" lvl txt lvl 
            PText txt        -> printf "<p>%s</p>"        txt 
            PList True items -> printf "<ol>%s</ol>"  undefined
            PList False items -> printf "<ul>%s</ul>" undefined
-}
toHtml (PHead lvl txt    ) = printf "<h%d>%s</h%d>" lvl txt lvl 
toHtml (PText txt        ) = printf "<p>%s</p>"        txt 
toHtml (PList True items ) = printf "<ol>%s</ol>"  "tbd"
toHtml (PList False items) = printf "<ul>%s</ul>"  "tbd"

quiz1 = 2 + 2
quiz2 = "hello!"

quiz3 = case "asdasd" of 
            PText str        -> str  
            PHead lvl str    -> True
            PList ord things -> "list"


{-            
quiz4 b = case True of
            True -> 0
            False -> "one"

{-             case exp of 
              C1 _ -> e1 :: T 
              C2 _ -> e2 :: T
-}

-------------------------------------------------------------------------------
