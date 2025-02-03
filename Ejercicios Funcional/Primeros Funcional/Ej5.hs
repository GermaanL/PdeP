{-
5) Definir la función esMayorA, que verifique si el doble del siguiente de la
suma entre 2 y un número es mayor a 10.
-}

siguiente :: Integer -> Integer
siguiente num = num + 1

doble :: Integer -> Integer
doble num = num * 2 

esMayorA :: Integer -> Bool
esMayorA num = doble(siguiente(num + 2)) > 10 

