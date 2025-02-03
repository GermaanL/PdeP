data Animal= Raton {
    nombre :: String, 
    edad :: Double, 
    peso :: Double,
    enfermedades :: [String]
} deriving Show

ratoncito = Raton "Ratoncito" 9.0 0.2 ["brucelosis", "sarampion", "tuberculosis"]

enfermedadesInfecciosas = [ "brucelosis", "tuberculosis"]


modificarNombre :: (String -> String) -> Animal -> Animal
modificarNombre modNombre raton = raton { nombre = (modNombre.nombre) raton }

modificarEdad :: (Double -> Double) -> Animal -> Animal
modificarEdad modEdad raton = raton {edad = (modEdad.edad) raton}

modificarPeso :: (Double -> Double) -> Animal -> Animal
modificarPeso modPeso raton = raton {peso = (modPeso.peso) raton}

modificarEnfermedades :: ([String] -> [String]) -> Animal -> Animal
modificarEnfermedades modEnf raton = raton {enfermedades = (modEnf.enfermedades) raton}


--2
hierbaBuena :: Animal -> Animal
hierbaBuena raton = modificarEdad sqrt raton

hierbaVerde :: String -> Animal -> Animal
hierbaVerde enfermedad raton = modificarEnfermedades (eliminarDeLista enfermedad) raton

eliminarDeLista :: (Eq a) => a -> [a] -> [a]
eliminarDeLista aEliminar lista = filter (/=aEliminar) lista

alcachofa :: Animal -> Animal
alcachofa raton = modificarPeso perderPeso raton

perderPeso :: Double -> Double
perderPeso peso | peso > 2 = peso * 0.9 
                | otherwise = peso *0.95 

pesaMasDeDos :: Animal -> Bool
pesaMasDeDos raton = (>2).peso $ raton

hierbaMagica :: Animal -> Animal
hierbaMagica raton = (modificarEnfermedades vaciarLista).modificarEdad (*0) $ raton

vaciarLista :: [String] -> [String]
vaciarLista lista = [] 

type Hierba = Animal -> Animal

medicamento :: [Hierba] -> Animal -> Animal
medicamento hierbas raton = foldl (\raton hierba -> hierba raton) raton hierbas 

antiAge :: [Hierba]
antiAge = replicate 3 hierbaBuena ++ [alcachofa] 

antiAge' :: Animal -> Animal
antiAge' raton = medicamento (replicate 3 hierbaBuena ++ [alcachofa]) raton

reduceFatFast :: Int -> Animal -> Animal
reduceFatFast potencia raton = medicamento ([hierbaVerde "obesidad"] ++ replicate potencia alcachofa) raton

hierbaMilagrosa :: Animal -> Animal
hierbaMilagrosa raton = medicamento (map hierbaVerde enfermedadesInfecciosas) raton

--4

cantidadIdeal :: (Int -> Bool) -> Int
cantidadIdeal cond = head.filter cond $ [1..]

estanMejoresQueNunca  :: [Animal] -> (Animal -> Animal) -> Bool
estanMejoresQueNunca ratones medicamento = all ((<1).peso.medicamento)  ratones

experimento :: [Animal] -> Int
experimento ratones = cantidadIdeal (estanMejoresQueNunca ratones.reduceFatFast)

