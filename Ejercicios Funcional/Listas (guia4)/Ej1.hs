--  Definir una función que sume una lista de números. 
-- Nota: Investigar sum 

-- practica final

funcion :: Ord x => x -> x -> [x -> x] -> [x]
funcion x y lista = (filter (> x) . map (\ f -> f y)) lista


--La función recibe un valor x, un valor x, y por ultimo una lista de funciones x->x. la lista de funciones se aplican con el map a y mediante la expresion lambda y luego se filtra de la lista resultante de [x] aquellos valores menores a x.



--ghci> funcion 3 5 [(2*), (3+)]
--[10,8]
--ghci> funcion 13 5 [(2*), (3+)]
--[]

funcion' :: t1 -> [t1 -> t2] -> [t2]
funcion' y list= map (probando y) list

probando a = (\ f -> f a)

data Persona = Persona {
    nombre :: String,
    edad :: Int,
    mascotas :: [String] 
}deriving Show;

german = Persona "German" 24 ["Ambar", "Canela", "Jazmin"] 
pilar = Persona "Maria del Pilar" 22 ["Pistacha"]




