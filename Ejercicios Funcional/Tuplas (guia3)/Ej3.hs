
{-

Definir la función cuentaBizarra, que recibe un par y: si el primer elemento es mayor al segundo devuelve la suma, si el segundo le lleva más de 10 al primero devuelve la resta 2do – 1ro, y si el segundo es más grande que el 1ro pero no llega a llevarle 10, devuelve el producto. Ej: 
Main> cuentaBizarra (5,8)
40
Main> cuentaBizarra (8,5)
13
Main> cuentaBizarra (5,29)
24

-}

cuentaBizarra :: (Integer, Integer) -> Integer
cuentaBizarra (x,y) | x>y = x+y
                    | y-x >= 10 = y-x
                    | y>x = x*y