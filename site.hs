--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll
import Text.Pandoc
import Text.Pandoc.Walk (walk)

crunchWithCtx ctx = do
  route   $ setExtension "html"
  compile $ pandocCompilerWithTransform 
              defaultHakyllReaderOptions 
              defaultHakyllWriterOptions
              (walk toggleFinal)
            >>= loadAndApplyTemplate "templates/page.html"    ctx
            >>= loadAndApplyTemplate "templates/default.html" ctx
            >>= relativizeUrls


toggleFinal :: Block -> Block
-- toggleFinal (Div attr bs) | n >= 2 = Para [Emph xs]
toggleFinal b = b

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
  match "static/*/*"    $ do route idRoute
                             compile copyFileCompiler
  match (fromList tops) $ crunchWithCtx siteCtx
  match "lectures/*"    $ crunchWithCtx postCtx
  match "assignments/*" $ crunchWithCtx postCtx
  match "templates/*"   $ compile templateCompiler

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField  "date"       "%B %e, %Y"  `mappend`
    -- constField "headerImg"  "Eiffel.jpg" `mappend`
    siteCtx

siteCtx :: Context String
siteCtx =
    --   constField "baseUrl" "file:///Users/rjhala/teaching/130-web/_site/" `mappend`
    constField "baseUrl"            "https://nadia-polikarpova.github.io/cse130-sp18"     `mappend`
    constField "site_name"          "cse130"                    `mappend`
    constField "site_description"   "UCSD CSE 130"              `mappend`
    -- constField "instagram_username" "ranjitjhala"               `mappend`
    constField "site_username"      "Nadia Polikarpova"              `mappend`
    constField "twitter_username"   "polikarn"               `mappend`
    constField "github_username"    "nadia-polikarpova"      `mappend`
    constField "google_username"    "npolikarpova@eng.ucsd.edu"       `mappend`
    constField "google_userid"      "u/0/104385825850161331469" `mappend`
    constField "piazza_classid"     "ucsd/spring2018/cse130/home" `mappend`
    defaultContext


tops =
  [ "index.md"
  , "grades.md"
  , "lectures.md"
  , "links.md"
  , "assignments.md"
  , "calendar.md"
  , "contact.md"
  ]
