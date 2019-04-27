
import Prelude hiding (sum, length, lookup, take)
import Data.Char
import Debug.Trace

-- >>> shout "like this" 
-- "LIKE THIS" 

shout :: [Char] -> [Char] 
shout chars = [ toUpper c | c <- chars ] 


-- >>> addEm [] 
-- 0

-- >>> addEm [3] 
-- 3

-- >>> addEm [2, 3] 
-- 5

-- >>> addEm [10, 20, 30] 
-- 60


addEm :: [Int] -> Int
addEm []    = 0
addEm (h:t) = h + addEm t 

{- 
addEm xs = case xs of  
             []    -> 0
             (h:t) -> h + addEm t

addEm xs = if null xs 
             then 0 
             else head xs + addEm (tail xs)

-}

type Month = String

-- DEFINE the datatype 

-- constructor
-- MkDate :: Int -> Month -> Int -> Date

-- destructor "fields" 
-- day    :: Date -> Int
-- month  :: Date -> Month
-- year   :: Date -> Int 

data Date = MkDate 
  { day   :: Int
  , month :: Month 
  , year  :: Int
  }
  deriving (Show)

data Time = MkTime 
  { hour   :: Int
  , minute :: Int
  , second :: Int
  }
  deriving (Show)

-- CONSTRUCT VALUES

deadlineDate :: Date
deadlineDate = MkDate 3 "May" 2019

deadlineTime :: Time
deadlineTime = MkTime 23 59 59

-- extendDate :: Date -> Int -> Date

-- >>> extendDate (12, 31, 2019) 2
-- (1, 2, 2020)

-- >>> extendDate deadTime

-- ACCESSING RECORDS

getMonth :: Date -> Month
getMonth (MkDate d m y) = m 


data Para 
  = PHead Int String
  | PText String
  | PList Bool [String]


doc :: [Para]
doc = [ PHead 1 "Notes from 130"                      -- (Int, String)
      , PText "There are two types of languages:"         -- String
      , PList True [ "Those that people complain about" -- (Bool, [String])
                   , "Those that no one uses"
                   ]
      ]

{- 

# Notes from 130 

There are two types of languages:

1. Those that people complain about
2. Those that no one uses

-}