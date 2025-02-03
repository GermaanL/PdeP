

{-
1) Dada una lista de tuplas, sacar la cantidad de elementos utilizando foldl y foldr.
Main>cantidadDeElementos [(8,6),(5,5),(5,6),(7,8)]
4
-}

--lista = [(8,6),(5,5),(5,6),(7,8)]





cantidadElementos :: [(Integer,Integer)] -> Integer
cantidadElementos list = foldl contar 0 list

contar :: Integer -> (Integer, Integer) -> Integer
contar x _ = x+1

{-
2) Dada una lista de pares (empleado, gasto), conocer el empleado más gastador usando foldl y foldr.
Main>masGastador [(“ana”,80),(“pepe”,40),(“juan”,300),(“maria”,120)]
(“juan”,300)
-}

--lista = [("ana",80),("pepe",40),("juan",300),("maria",120)]

masGastador :: [(String, Integer)] -> (String, Integer)
masGastador (x:xs) = foldl masGasto x xs

masGasto :: (String, Integer) -> (String, Integer) -> (String, Integer)
masGasto g1 g2  | snd g1 > snd g2 = g1
                | otherwise = g2

{-
3) Dada una lista de (empleado, gasto), conocer el gasto total usando foldl y foldr.
Main>monto [(“ana”,80),(“pepe”,40),(“juan”,300),(“maria”,120)]
540
-}

--lista = [("ana",80),("pepe",40),("juan",300),("maria",120)]

monto :: [(String, Integer)] -> Integer
monto list = foldl gastoTotal 0 list

gastoTotal :: Integer -> (String, Integer) -> Integer
gastoTotal x (_, gastado) = x + gastado


--5) Dada una lista de proyectos

type Nombre = String
type InversionInicial = Int
type Profesionales = [String]

data  Proyecto = Proy {nombre::Nombre, inversionInicial::InversionInicial, profesionales::Profesionales} deriving Show

proyectos = [Proy "red social de arte" 20000 ["ing. en sistemas", "contador"], Proy "restaurante" 5000 ["cocinero", "adm. de empresas", "contador"], Proy "ventaChurros" 1000 ["cocinero"] ]


{-
5.1) Determine una función que permita conocer el máximo proyecto según. Revolverlo usando foldl y foldr.
a) La inversión inicial
b) El nro de profesionales.
c) La cantidad de palabras del proyecto.
Muestre por cada caso ejemplos de invocación y respuesta.
-}

maxProyectoSegun :: [Proyecto] -> (Proyecto -> Int) -> Proyecto
maxProyectoSegun (proyecto:proyectos) funcion = foldl (maximoSegun funcion) proyecto proyectos


maximoSegun :: (Proyecto -> Int) -> Proyecto -> Proyecto -> Proyecto
maximoSegun funcion unProy otroProy | funcion unProy > funcion otroProy = unProy
                                    | otherwise = otroProy

