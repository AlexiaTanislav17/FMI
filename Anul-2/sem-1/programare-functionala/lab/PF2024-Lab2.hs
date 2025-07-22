myInt = 31415926535897932384626433832795028841971693993751058209749445923

double :: Integer -> Integer
double x = x+x

maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
          else y

maximv2 x y
    | x<= y  = y
    | otherwise = x

maxim3 :: Integer -> Integer -> Integer -> Integer
maxim3 x y z = if (x >= y)
                    then 
                        if (x >= z)
                            then x
                        else z
                    else 
                        if (y >= z)
                            then y
                        else z

max3 x y z = let
             u = maxim x y
             in (maxim  u z)

maxim4 w x y z = let  
                    u = maxim3 w x y
                    in (maxim u z)

-- val intoarsa de functie este cea expersiei din in()
--maximv4v2 :: Integer -> Integer -> Integer -> Integer -> Bool
maxim4v2 w x y z = let
                    u = maxim4 w x y z
                    in (u>=w && u>=x && u>=z)

--definim un tip de date nou
data Bool232 = True232 | False232
    deriving Show

and232 :: Bool232 -> Bool232 -> Bool232
and232 _ False232 = False232
and232 False232 _ = False232
and232 _ _        = True232

--fiecare and232 este cate un caz care compara si dupa = este rezultatul
--pattern matching

suma :: Integer -> Integer -> Integer
suma x y = let 
                u = x*x
                v = y*y
                in (u+v)

paritate :: Integer -> String
paritate x = if (x `mod` 2 == 0)
                then "par"
            else "impar"
--backtick `` ca nu il puna in fata 
--alta varianta in if era mod x 2   fara backtick

fact x = if (x == 0)
            then 1
        else x*fact(x-1)

fact2 :: Integer -> Integer
fact2 0 = 1
fact2 x = x*fact2 (x-1)

fact3 :: Integer -> Integer
fact3 x
    | x==0  = 1
    | otherwise =x*fact3 (x-1)

--maximul unei liste 
getMax :: [Integer] -> Integer
getMax [elem] = elem
getMax (head:tail) = maxim head (getMax tail)
-- getMax (head:tail) = maxim head $ getMax tail

eeny :: Integer -> String
eeny x = if even x 
            then "eeny"
        else "meeny"

fizzbuzz :: Integer -> String
fizzbuzz x = if (x `mod` 15 == 0)
                then "FizzBuzz"
            else
                if (x `mod` 5 == 0)
                    then "Buzz"
                else 
                    if (x `mod` 3 == 0)
                        then "Fizz"
                    else "niciuna"

fizzbuzz2 :: Integer -> String
fizzbuzz2 x
    | x `mod` 3 == 0 && x `mod` 5 == 0   = "FizzBuzz"
    | x `mod` 5 == 0   = "Fizz"
    | x `mod` 3 == 0   = "Buzz"
    | otherwise = "niciuna"

--fizzbuzz3 :: Integer -> String
--fizzbuzz3 x = if (x `mod` 15 == 0) then "FizzBuzz"
--fizzbuzz3 x = if (x `mod` 5 == 0)  then "Fizz"
--fizzbuzz3 x = if (x `mod` 3 == 0)  then "Buzz"
--fizzbuzz3 x = "niciuna"
--nu merge asta de sus

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
    | n < 2     = n
    | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)
    
fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)
    
tribonacci :: Integer -> Integer
tribonacci 1 = 1
tribonacci 2 = 1
tribonacci 3 = 2
tribonacci n = tribonacci (n-1) + tribonacci (n-2) + tribonacci (n-3)


binomial :: Integer -> Integer -> Integer
binomial = undefined
