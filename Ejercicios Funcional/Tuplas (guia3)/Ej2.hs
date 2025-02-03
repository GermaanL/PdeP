{-

Definir la función aplicar, que recibe como argumento una tupla de 2 elementos con funciones y un entero, me devuelve como resultado una tupla con el resultado de aplicar el elemento a cada una de la funciones, ej: 
Main> aplicar (doble,triple) 8 
(16,24) 
Main> aplicar ((3+),(2*)) 8 
(11,16)

-}


aplicar :: (Integer -> Integer, Integer -> Integer) -> Integer -> (Integer, Integer)
aplicar (f1,f2) x= (f1(x), f2(x))