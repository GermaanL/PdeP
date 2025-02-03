
{-

Definir las funciones fst3, snd3, trd3, que dada una tupla de 3 elementos devuelva el elemento correspondiente, p.ej. 
Main> snd3 (4,5,6) 
5
Main> trd3(4,5,6)
6

-}


fst3 :: (a, b, c) -> a
fst3 (x,_,_) = x

snd3 :: (a, b, c) -> b
snd3 (_,y,_) = y

trd3 :: (a, b, c) -> c
trd3 (_,_,z) = z