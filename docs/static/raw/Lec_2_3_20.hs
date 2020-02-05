module Lec_2_3_20 where

hello :: String 
hello = "Hello!"

foo [3, x, y] = "hahah"

pair :: (Double, (Int, String), [String])
pair = (2.3, (45 + 5, "cat"), ["horse", "mouse"])

-- addUp :: (Int, Int) -> Int
-- addUp p = (fst p) + (snd p)

addUp :: (Int, Int) -> Int
addUp (x, y) = x + y

-- addUp p = let (x, y) = p in
--            x + y



data Date = DateC 
  { month :: Int
  , day   :: Int 
  , year  :: Int
  }

data Time = TimeC 
  { hour :: Int
  , min  :: Int
  , sec  :: Int
  }

deadlineDate :: Date
deadlineDate = DateC 2 7 2020

deadlineTime :: Time 
deadlineTime = TimeC 23 59 59

extend :: Date -> Date
extend (DateC m d y) = DateC m (d+1) y

-- err = extend deadlineTime


doc = [ (HeaderC 1 "Notes from 130")                  -- Header
      , (PTextC "There are two types of languages")   -- RawText
      , (ListC True [ "those people complain about" 
                    , "those people use!"  
                    ])
      ]

data Para 
  = HeaderC Int     String  
  | PTextC  String 
  | ListC   Bool    [String] 
  deriving (Eq, Show)