import Data.List (genericLength)
{-
1) Obtener la energía que produce un grito, que se calcula como el nivel de terror por la intensidad al cuadrado, en caso de que moje la cama, si no, sólo es el triple del nivel de terror más la intensidad. El nivel de terror es equivalente al largo de la onomatopeya. 
De los gritos
sabemos  gritos están representados por una tupla (Onomatopeya, Intensidad, mojóLaCama).
Ejemplo:
        energiaDeGrito ("AAAAAHG", 10, True)
        700
        energiaDeGrito ("uf", 2, False)
        8

-}

type Grito = (String, Float, Bool)

onomatopeya (o ,_ ,_ ) = o
intensidad (_, i,_ ) = i
mojoLaCama (_ ,_ ,m ) = m

energiaDeGrito :: Grito -> Float
energiaDeGrito grito | mojoLaCama grito = ((*nivelTerror grito).(^2).intensidad) grito
                     | otherwise  = ((+intensidad grito).(3*).nivelTerror) grito


nivelTerror :: Grito -> Float
nivelTerror grito = (genericLength.onomatopeya) grito


{-
2) Obtener el grito que cada monstruo (un empleado de la empresa) le arranca a un niño (su víctima). Hay muchos monstruos y cada uno tiene su forma de trabajar, que consiste precisamente en recibir a un niño y devolver su grito. De los niños se sabe el nombre, la edad y la altura y se los representa con una tupla con dichas componentes.

Monstruos en la empresa hay muchos. En particular, se desea implementar los siguientes, pero podría haber más:
Sullivan (el protagonista) produce un grito "AAAGH" con tantas A como letras tenga el nombre del niño y una intensidad como como 20 / edad; hace mojar la cama si el niño tiene menos de 3 años.

Randall Boggs (la lagartija) produce un grito de “¡Mamadera!”, con tanta intensidad como vocales en el nombre de la persona; hace mojar la cama en los niños que miden entre 0,8 y 1,2 de altura.

Chuck Norris produce siempre un grito que dice todo el abecedario, con 1000 de nivel de intensidad y siempre hace que mojen la cama.

Un Osito Cariñoso produce un grito “uf”, con un nivel de intensidad igual a la edad del niño y nunca moja la cama.

-}

type Niño = (String, Float, Float)

nombre (n, _, _ ) = n
edad (_, e, _ ) = e
altura (_, _, a ) = a

nico :: Niño
nico = ("Nicolas", 3, 1.1)

agustin :: Niño
agustin = ("Agustin", 2, 0.5)

sullivan :: Niño -> Grito
sullivan niño = (calcularGrito gritoSullivan niño, calcularIntensidad edadSobreVeinte niño, mojaLaCama menorQueTres niño )

calcularGrito :: (Niño -> String) -> Niño -> String
calcularGrito f niño = f niño

gritoSullivan :: Niño -> String
gritoSullivan (nombre, _ , _) = calcularCantidadDeAs nombre ++ "GH" 

calcularCantidadDeAs :: String -> String
calcularCantidadDeAs nombre = replicate (length nombre) 'A'

calcularIntensidad :: (Niño -> Float) -> Niño -> Float
calcularIntensidad f niño = f niño

mojaLaCama :: (Niño -> Bool) -> Niño -> Bool
mojaLaCama f niño = f niño

edadSobreVeinte :: Niño -> Float
edadSobreVeinte niño = ((20/).edad) niño 

menorQueTres :: Niño -> Bool
menorQueTres niño = ((<3).edad) niño 

randall :: Niño -> Grito
randall niño = ("¡Mamadera!", calcularIntensidad vocalesEnNombre niño,  mojaLaCama (alturaEntre 0.8 1.2) niño)

alturaEntre ::  Float -> Float -> Niño -> Bool
alturaEntre alt1 alt2 (_, _, altura) = altura > alt1 && altura < alt2

vocalesEnNombre :: Niño -> Float
vocalesEnNombre (nombre ,_ ,_) = (genericLength.filter (esVocal)) nombre

esVocal :: Char -> Bool
esVocal char = elem char "AEIOUaeiou"

chukNorris :: Niño -> Grito
chukNorris _ = ("abcdefghijklmnñopqrstuvwxyz", 1000, True)

ositoCariñoso :: Niño -> Grito
ositoCariñoso (_,edad,_) = ("uf", edad, False)


pam :: [(a->b)] -> a -> [b]
pam [] _ = []
pam (f:fs) var = f var: pam fs var

{-
4) Los monstruos a veces trabajan en equipo, por lo que van varios a la casa de un niño y todos lo asustan. Obtener el conjunto de gritos que logra el equipo.
Por ejemplo:
gritos [sullivan, osito, chuck] (“kevin”, 2, 1.1) 
[("AAAAAHG", 10, True), (“uf”,2,False), (“abcdefghijklmnopqrstuvwxyz”,1000,True)]
-}

kevin :: Niño
kevin = ("kevin", 2, 1.1) 

gritos :: [(Niño -> Grito)] -> Niño -> [Grito]
gritos monstruos niño = pam monstruos niño

{-
5) Saber la producción energética de un equipo de monstruos que va a un campamento y asusta a todos los niños que están durmiendo en las carpas. Asumir que los campamentos son listas de niños y ya están definidos como  constantes.
Por ejemplo:  
        produccionEnergeticaGritos [sullivan, osito, chuck] campamentoDeExploradores
        999999
-}

produccionDeGritos :: [(Niño -> Grito)] ->  [Niño] -> Float
produccionDeGritos _ [] = 0
produccionDeGritos monstruos (niño:niños) = (((obtenerSuma).obtenerEnergiaGritos monstruos) niño) + produccionDeGritos monstruos niños

obtenerEnergiaGritos :: [(Niño -> Grito)] -> Niño -> [Float]
obtenerEnergiaGritos monstruos niño = ((map energiaDeGrito).gritos monstruos) niño

obtenerSuma :: [Float] -> Float
obtenerSuma cadena = foldl1 (+) cadena


campamento :: [Niño]
campamento = [nico, agustin, kevin]

type Risa = (Float, Float)
intensidadRisa (i, _) = i
duracionRisa (_, d) = d

type Comediante = Niño -> Risa

produccionDeRisas :: [Comediante] -> [Niño] -> Float
produccionDeRisas _ [] = 0
produccionDeRisas comediantes (niño:niños) = (((obtenerSuma).obtenerEnergiaRisas comediantes) niño) + produccionDeRisas comediantes niños

obtenerEnergiaRisas :: [Comediante] -> Niño -> [Float]
obtenerEnergiaRisas monstruos niño = ((map energiaDeRisas).risas monstruos) niño

risas :: [Comediante] -> Niño -> [Risa]
risas comediantes niño = pam comediantes niño

energiaDeRisas :: Risa -> Float
energiaDeRisas (int, dur) = (^(round int)) dur


------------------------------------------------------
capusotto :: Comediante
capusotto niño = (dobleDeEdad niño, dobleDeEdad niño)

dobleDeEdad:: Niño -> Float
dobleDeEdad niño = ((2*).edad) niño
------------------------------------------------------

monstruos = [sullivan, randall, ositoCariñoso]


produccionEnergetica :: [a1 -> a2] -> (a2 -> Float) -> [a1] -> Float
produccionEnergetica _ _ [] = 0
produccionEnergetica productores f (niño:niños) = (obtenerSuma (obtenerEnergias productores f niño)) + produccionEnergetica productores f niños

obtenerEnergias :: [a1 -> a2] -> (a2 -> b) -> a1 -> [b]
obtenerEnergias productores f niño = ((map f ).productos productores) niño


productos :: [a->b] -> a -> [b]
productos productores niño = pam productores niño

--ghci> produccionDeGritos [ sullivan , randall ] [kevin, nico, agustin]
-- 1791.4286
-- ghci> produccionDeRisas [capusotto] campamento
-- 47168.0

