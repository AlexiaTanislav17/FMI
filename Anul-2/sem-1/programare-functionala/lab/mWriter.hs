
--- Monada Writer

newtype WriterS a = Writer { runWriter :: (a, String) } 
--         Writer :: (a, String) -> WriterS
--         runWriter :: WriterS a -> (a, String)

-- k :: a -> WriterS b

instance  Monad WriterS where
  return va = Writer (va, "")
  ma >>= k = let (va, log1) = runWriter ma
                 (vb, log2) = runWriter (k va)
             in  Writer (vb, log1 ++ log2)

-- in orice monada pure o sa fie mereu return 
instance  Applicative WriterS where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance  Functor WriterS where              
  fmap f ma = pure f <*> ma     

tell :: String -> WriterS () 
tell log = Writer ((), log)
  
-- in ghci apelam cu runWriter
logIncrement :: Int  -> WriterS Int
logIncrement x = do
  tell $ "voi incrementat pe " ++ (show x) ++ "la" ++ show (x+1) ++ "\n"
  return (x+1)

{-
logIncrementN :: Int -> Int -> WriterS Int
logIncrementN x n =  do
  new_x <- logIncrement x
  if (n > 0) then
    logIncrement
   -}
                  
-- runWriter (logIncrement x n) == (x+n, "am  incermentat x la x +1" am incrementat x+1 la x+2 etc)
