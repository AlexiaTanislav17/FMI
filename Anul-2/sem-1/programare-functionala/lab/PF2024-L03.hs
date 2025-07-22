verifL :: [Int] -> Bool
verifL l = (length l) `mod` 2 == 0



takefinal :: [Int] -> Int -> [Int]
takefinal l n 
    | n<length l = drop (length l - n) l  
    | otherwise = l
-- iti da ultimele n elemente din lista
-- drop iti elimina primele n elemente din lista si iti intoarce o lista din elem ramase din lista initiala


remove:: [Int] -> Int -> [Int]
remove l n = (take (n-1) l) ++ (drop n l)
--iti scoate al n-lea element



-- semiPareRec [0,2,1,7,8,56,17,18] == [0,1,4,28,9]
semiPareRec :: [Int] -> [Int]
semiPareRec [] = []
semiPareRec (h:t)
 | even h    = h `div` 2 : t'
 | otherwise = t'
 where t' = semiPareRec t

-- where iti inlocuieste t' cu (semiPareRec t)    =>   cumva inlocuind variabila aia cu apelarea din nou a ufnctiei iti face recursivitatea
-- iti ia fiecare element din lista si ti-l injumatateste

-- semiPareRec [0,2,1,7,8,56,17,18] == [0,1,4,28,9]
-- semiPareRec :: [Int] -> [Int]
-- semiPareRec [] = []
-- semiPareRec (h:t)
--  | even h    = h `div` 2 : (semiPareRec t)
--  | otherwise = semiPareRec t


--  "++" iti concateneaza
myreplicate :: Int -> Int ->[Int]
myreplicate 0 v = []
myreplicate n v = (myreplicate (n-1) v) ++ [v]
-- iti intoarce o lista de n elemente care sunt toate = v

-- suma nr impare
sumImp :: [Int] -> Int
sumImp [] = 0
sumImp (h:t)
    | even h = sumImp t 
    | otherwise = sumImp t + h

-- operatorul !! iti primul element al sirului de caracter
totalLen :: [String] -> Int
totalLen [] = 0
totalLen (h:t) = if (h !! 0 == 'A') then length h + totalLen t
                    else totalLen t


vocale :: [Char] -> Int
vocale [] = 0
vocale (h:t) = if (h =='a' || h =='e' || h =='i' || h=='o' || h=='u')
                     then 1 + vocale t
                else vocale t


nrVocale :: [String] -> Int
nrVocale [] = 0 
nrVocale (h:t) = if (h == reverse(h)) 
                    then vocale h + nrVocale t
                else nrVocale t

-- nrVocale ["sos", "civic", "palton", "desen", "aerisirea"] == 9

-- f 3 [1,2,3,4,5,6] = [1,2,3,3,4,3,5,6,3]

semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]

-- divizori 4 == [1,2,4]

divizori :: Int -> [Int]
divizori n = [divizor | divizor <- [1..n], n `mod` divizor == 0]

listadiv :: [Int] -> [[Int]]
listadiv l = [divizori n | n <- l]
-- listadiv [1,4,6,8] == [[1],[1,2,4],[1,2,3,6],[1,2,4,8]]

-- inInterval 5 10 [1..15] == [5,6,7,8,9,10]
-- inInterval 5 10 [1,3,5,2,8,-1] == [5,8]
inInterval:: Int -> Int -> [Int] -> [Int]
inInterval x y l = [ n | n <- l, x <= n && n <= y]

inIntervalRec:: Int -> Int -> [Int] -> [Int]
inIntervalRec x y [] = []
inIntervalRec x  y (h:t) = if (x<=h && h<=y) then h:(inIntervalRec x y t)
                            else inIntervalRec x y t


-- pozitive [0,1,-3,-2,8,-1,6] == 3
-- list comprehension
pozitive :: [Int] -> Int
pozitive l = length [n | n<- l, n>0]

pozitiveRec :: [Int] -> Int
pozitiverec [] = 0
pozitiveRec (h:t)
    | h > 0 = pozitiveRec t + 1
    | otherwise = pozitiveRec t


-- pozitiiImpare [0,1,-3,-2,8,-1,6,1] == [1,2,5,7]

poz :: [Int] ->Int -> [Int]
poz [] n = []
poz (h:t) n 
    | even n = poz t (n+1)
    | otherwise = n: poz t (n+1)


pozitiiImpare :: [Int] -> [Int]
pozitiiImpare l = poz l 0

-- zip [1..3] [1..9]  adica  [(1,1), (2,2), (2,3)]
-- intoarce o lista de tupluri formate din elem de pe aceleasi poz
-- zip [3,4,99,1] [1..] adica [(3,1), (4,2), (99,3), (1,4)]
-- [1..] lista infinita

--list comprehesniosn
pozImp :: [Int] -> [Int]
pozImp l = [fst x | x <-zip l [0..], odd (snd x)]


--fst intoarce primu element dintr un tuplu si snd urm
-- tuplu (x,y)
-- fst (x,y) este x
-- snd (x,y) este y

-- multDigits "The time is 4:25" == 40
-- multDigits "No digits here!" == 1
