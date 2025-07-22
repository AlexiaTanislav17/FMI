
{- Monada Maybe este definita in GHC.Base 

instance Monad Maybe where
  return = Just
  Just va  >>= k   = k va
  Nothing >>= _   = Nothing


instance Applicative Maybe where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)       

instance Functor Maybe where              
  fmap f ma = pure f <*> ma   
-}

pos :: Int -> Bool
pos  x = if (x>=0) then True else False

fct :: Maybe Int ->  Maybe Bool
fct  mx =  mx  >>= (\x -> Just (pos x))

fctDo :: Maybe Int ->  Maybe Bool
fctDo mx =  do
    x <- mx
    return (pos x)


addM :: Maybe Int -> Maybe Int -> Maybe Int
-- addM Nothing my = Nothing
-- addM mx Nothing = Nothing
-- addM (Just x) (Just y) = Just (x + y)
addM mx my = mx >>= (\x -> (my >>= (\y -> Just(x + y))))

addMDo mx my = do
    x <- mx
    y <- my
    Just (x + y)


cartesian_product :: Monad m => m a -> m b -> m (a, b)
cartesian_product xs ys = xs >>= ( \x -> (ys >>= \y-> return (x,y)))

cartesian_productDo xs ys = do
    x <- xs
    y <- ys
    return (x,y)

prod :: (a -> b -> c) -> [a] -> [b] -> [c]
prod f xs ys = [f x y | x <- xs, y<-ys]

prod2 f xs ys = xs >>= (\x -> (ys >>= (\y -> return (f x y))))

prodDo f xs ys = do
    x <- xs
    y <- ys
    return (f x y)

myGetLine :: IO String
myGetLine = getChar >>= \x ->
      if x == '\n' then
          return []
      else
          myGetLine >>= \xs -> return (x:xs)

myGetLineDo = do 
    x <- getChar
    if x == '\n' then
      return []
    else do
        xs <- myGetLineDo
        return (x:xs)

prelNo noin =  sqrt noin


-- la let nu mai punem aici in pt ca nu are sens in monada (?)
ioNumber :: IO ()
ioNumber = do
     noin  <- readLn :: IO Float
     putStrLn $ "Intrare\n" ++ (show noin)
     let  noout = prelNo noin
     putStrLn $ "Iesire"
     print noout

-- () :: unit 
-- facut special ca sa dai return la nimic doar ca sa interactioneze cu 
-- mediu exterior

-- >> :: m a -> m b -> m b
-- >> ignora prima chestie 
-- >>= :: m a ->(a -> m b )-> m b

-- (ma >>= (\_ -> mb))  este la fel cu:
-- (ma>> mb)

-- aici la let e obligatoriu sa pui in
ioNumberBind = 
    ((readLn :: IO Float) >>= \noin -> 
      putStrLn ("Intrare\n" ++ (show noin)) >>  
      let noout = prelNo noin in
        putStrLn "Iesire"
        print noout)

data Person = Person { name :: String, age :: Int }

showPersonN :: Person -> String
showPersonN p = "NAME: " ++ name p
showPersonA :: Person -> String
showPersonA p = "AGE: " ++ show (age p)

{-
showPersonN $ Person "ada" 20
"NAME: ada"
showPersonA $ Person "ada" 20
"AGE: 20"
-}

showPerson :: Person -> String
showPerson = undefined 

{-
showPerson $ Person "ada" 20
"(NAME: ada, AGE: 20)"
-}


newtype Reader env a = Reader { runReader :: env -> a }


instance Monad (Reader env) where
  return x = Reader (\_ -> x)
  ma >>= k = Reader f
    where f env = let a = runReader ma env
                  in  runReader (k a) env

ask :: Reader env env
-- ask = Reader (\e -> e)
ask = Reader id


instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance Functor (Reader env) where              
  fmap f ma = pure f <*> ma    

mshowPersonN ::  Reader Person String
mshowPersonN = do
  p <- ask
  return $ "NUME: " ++ showPersonN p


mshowPersonA ::  Reader Person String
mshowPersonA = do
  p <- ask
  return $ "AGE: " ++ showPersonA p

mshowPerson ::  Reader Person String
mshowPerson = do
  name <- mshowPersonN
  age <- mshowPersonA
  return $ "(" ++ name ++ "," ++ age ++ ")"


{-
runReader mshowPersonN  $ Person "ada" 20
"NAME:ada"
runReader mshowPersonA  $ Person "ada" 20
"AGE:20"
runReader mshowPerson  $ Person "ada" 20
"(NAME:ada,AGE:20)"
-}

