import Text.Printf

main :: IO ()
main = loop 1000 

loop :: Int -> IO ()
loop i = do 
    putStrLn (printf "Welcome [%d]: " i)
    name <- getLine 
    putStrLn ("Hello, " ++ name)
    loop (i+1)