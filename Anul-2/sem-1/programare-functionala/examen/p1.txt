
--fara monade
interval :: Int -> Int -> [Int] -> Bool
interval n m = all (\x -> x >= n && x <= m)

-- interval3 :: Int -> Int -> Int -> Bool
-- interval3 x n m = if (x<=m && x>=n)
--                     then True
--                  else False

concatLists :: [[Int]] -> Int -> Int -> [Int]
concatLists lists n m = concat $ filter (\lst -> even (length lst) && interval n m lst) lists

-- concatLists3 :: [[Int]] -> Int -> Int -> [Int]
-- concatLists3 (x:xs) n m = if ((length xs) % 2 == 1)
--                            then 
--                                if (interval3 x n m) 
--                                   then [x] ++ concatLists xs n m
--                                else
--                                    concatLists xs n m
--                            else
--                                concatLists xs n m


-- cu monade
interval2 :: Int -> Int -> [Int] -> Bool
interval2 n m = all (\x -> x >= n && x <= m)

concatLists2 :: [[Int]] -> Int -> Int -> [Int]
concatLists2 lists n m = concat $ filter (\lst -> return $ even (length lst) && interval2 n m lst) lists





