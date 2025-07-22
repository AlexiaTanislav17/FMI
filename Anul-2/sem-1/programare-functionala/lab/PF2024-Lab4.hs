{-
[x^2 |x <- [1..10], x `rem` 3 == 2]
[(x,y) | x <- [1..5], y <- [x..(x+2)]]
[(x,y) | x <- [1..3], let k = x^2, y <- [1..k]]
[x | x <- "Facultatea de Matematica si Informatica", elem x ['A'..'Z']]
[[x..y] | x <- [1..5], y <- [1..5], x < y]
-}

factori :: Int -> [Int]
factori val= [i| i<- [1..val], val `mod` i == 0]
--echivalent cu asta cu lambda de mai jos
--factori = \val -> [i| i<- [1..val], val `mod` i == 0]


prim :: Int -> Bool
prim n = length( factori n) == 2


numerePrime :: Int -> [Int]
numerePrime n = [i| i <- [2..n], prim i]

--[(x,y)| x <- [1..5], y <- [1..3]]
--intoarce produs cartezian,
--zip [1..5] [1..3]
--intoarce doar tuplurile cu rn de pe aceleasi pozitii


myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 _ _ [] = []
myzip3 _ [] _ = []
myzip3 [] _ _ = []
myzip3 (h1:t1) (h2:t2) (h3:t3) = (h1,h2,h3) : myzip3 t1 t2 t3


myZip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myZip3 l1 l2 l3 = [(a,b,c)| (a,(b,c)) <- zip l1 (zip l2 l3)]


--aplica2 :: (a -> a) -> a -> a
--aplica2 f x = f (f x)
--aplica2 f = f . f
-- "." este operatorul de compunere a functiilor
--acolo f ia parametrul (a->a si intoarce compunerea lui a->a de dupa prima sageata)
--aplica2 = \f x -> f (f x)
--aplica2 f = \x -> f (f x)


--operatorul $ e o functie care primeste o functie si un parametru si intoarce un alt nr
--($ 3) [ ( 4 +) , (10 * ) , ( ^ 2) , sqrt ]
--si atunci 4+ e functia aplicata cu ajutorul $ si al doilea parametru e 3
--[(4+)$ 3, (10 * )$ 3, ( ^ 2)$ 3, sqrt $ 3 ]
--[7.0, 30.0, 9.0, 1.7320508075688772]
--practic ai o lista de functii si iti intoarce o lista din rezultatele
-- pe care le dau functiile aplicate pe parametrul cu 4 in fata

-- x `elem` este o functie [Int]->Bool
-- iti arata daca x e un elemnt din lista data

firstEl :: [(Int, Int)] -> [Int]
firstEl = map fst
-- firstEl xs = map fst xs


sumList :: [[Int]] -> [Int]
sumList = \lists -> map sum lists
--sumList = map sum


prel2 :: [Int] -> [Int]
prel2 xs = map transformare xs where
            transformare x = if even x then x `div` 2 else x*2

contineCarac :: Char -> [String] -> [String]
--contineCarac c l = [s|s <- l, c `elem` s]
contineCarac c l = filter (c `elem`) l

patrat :: [Int] -> [Int]
patrat l = map (^2) (filter odd l)


patratPoz :: [Int] -> [Int]
patratPoz l = map ((^2) . fst) (filter (odd . snd) (zip l [1..]))


ordonataNat :: [Int] -> Bool
ordonataNat [] = True
ordonataNat [x] = True
ordonataNat (x:xs) = undefined


ordonata :: [a] -> (a -> a -> Bool) -> Bool
ordonata = undefined
