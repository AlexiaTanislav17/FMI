data RGB v = RGB v v v
    deriving Show

newtype Image p = Img [[p]]
    deriving Show

class Composite c where 
    applyAlpha :: c (RGB v) -> [[a]] -> (RGBA v a)

instance Composite Image where 
    

