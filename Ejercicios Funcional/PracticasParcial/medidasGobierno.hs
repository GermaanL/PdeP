type Bien = (String,Float)

data Ciudadano = UnCiudadano {
    profesion :: String, 
    sueldo :: Float, 
    cantidadDeHijos :: Float, 
    bienes :: [Bien] 
} deriving Show

homero = UnCiudadano "SeguridadNuclear" 9000 3 [("casa",50000), ("deuda",-70000)]
frink = UnCiudadano "Profesor" 12000 1 []
krabappel = UnCiudadano "Profesor" 12000 0 [("casa",35000)]
burns = UnCiudadano "Empresario" 300000 1 [("empresa",1000000),("empresa",500000),("auto",200000)]

type Ciudad = [Ciudadano]
springfield = [homero, burns, frink, krabappel]

diferenciaPatrimonio :: Ciudad -> Float
diferenciaPatrimonio ciudad = maximoPatrimonio ciudad - minimoPatrimonio ciudad

maximoPatrimonio :: Ciudad -> Float
maximoPatrimonio ciudad = maximum.patrimonioCiudadanos $ ciudad

minimoPatrimonio :: Ciudad -> Float
minimoPatrimonio ciudad = minimum.patrimonioCiudadanos $ ciudad

patrimonioCiudadanos :: Ciudad -> [Float]
patrimonioCiudadanos ciudad = map obtenerPatrimonio ciudad

obtenerPatrimonio :: Ciudadano -> Float
obtenerPatrimonio (UnCiudadano _ sueldo _ bienes) = sueldo + sumarBienes bienes

sumarBienes :: [Bien] -> Float
sumarBienes bienes = foldl (\suma (_,valorBien) -> suma + valorBien) 0 bienes 

--2
tieneAutoAltaGama :: Ciudadano -> Bool
tieneAutoAltaGama ciudadano = any esAutoAltaGama (bienes ciudadano)

esAutoAltaGama :: Bien -> Bool
esAutoAltaGama ("auto", valor) = valor > 100000
esAutoAltaGama _ = False

--3
type Medida = Ciudadano -> Ciudadano

auh :: Medida
auh ciudadano = aplicarMedida (((<0).obtenerPatrimonio) ciudadano ) ((modificarSueldo (1000*cantidadDeHijos ciudadano))) ciudadano

modificarSueldo :: Float -> Medida
modificarSueldo valor ciudadano = ciudadano {sueldo = sueldo ciudadano + valor} 

aplicarMedida :: Bool -> Medida -> Ciudadano -> Ciudadano
aplicarMedida cond f ciudadano  | cond = f ciudadano
                                | otherwise = ciudadano

impuestoGanancias :: Float -> Medida
impuestoGanancias minimo ciudadano = aplicarMedida (sueldo ciudadano >minimo) (modificarSueldo ((calcularFactor (sueldo ciudadano) minimo))) ciudadano

calcularFactor :: Float -> Float -> Float
calcularFactor sueldo minimo = 0.3 * (minimo - sueldo)

impuestoAltaGama :: Medida
impuestoAltaGama ciudadano = aplicarMedida (tieneAutoAltaGama ciudadano) (modificarSueldo (-0.1*valorVehiculo (bienes ciudadano))) ciudadano

valorVehiculo :: [Bien] -> Float
valorVehiculo bienes = (snd.head.filter (esAutoAltaGama)) bienes

negociarSueldoProfesion :: String -> Float -> Medida
negociarSueldoProfesion  unaProfesion porcentaje ciudadano = aplicarMedida (esProfesion unaProfesion ciudadano) (modificarSueldo (aumento porcentaje (sueldo ciudadano))) ciudadano

esProfesion :: String -> Ciudadano -> Bool
esProfesion unaProfesion ciudadano = unaProfesion == profesion ciudadano

aumento:: Float -> Float -> Float
aumento valor sueldo = (valor/100 * sueldo)

--4
data Gobierno = UnGobierno {
    años :: [Float],
    medidas :: [Medida]
}

gobiernoA = UnGobierno [1999..2003] [impuestoGanancias 30000, negociarSueldoProfesion "Profesor" 10, negociarSueldoProfesion "Empresario" 40, auh, impuestoAltaGama]

gobiernoB = UnGobierno [2004..2008] [impuestoGanancias 40000, negociarSueldoProfesion "Profesor" 30, negociarSueldoProfesion "Camionero" 40]

gobernarUnAño :: Gobierno -> Ciudad -> Ciudad
gobernarUnAño gobierno ciudad = map (aplicarMedidasDe gobierno) ciudad

aplicarMedidasDe :: Gobierno -> Ciudadano -> Ciudadano
aplicarMedidasDe gob ciudadano = foldl (\ciudadano medida -> medida ciudadano) ciudadano (medidas gob)

gobernarPeriodoCompleto ::  Gobierno -> Ciudad -> Ciudad
gobernarPeriodoCompleto gob ciudad = foldl (\ciudadanos _ -> gobernarUnAño gob ciudadanos) ciudad (años gob)

distribuyoRiqueza :: Gobierno -> Ciudad -> Bool
distribuyoRiqueza gob ciudad = diferenciaPatrimonio ciudad > (diferenciaPatrimonio.gobernarPeriodoCompleto gob ) ciudad

patrimonioCiudad :: Ciudad -> Float
patrimonioCiudad c = foldl (\x pat -> x+ pat) 0 (patrimonioCiudadanos c)


f1 :: (Num x, Num z) => x -> (z->x->Bool) -> z -> [x] -> [x]
f1 x y z = map (*x) . filter (y z) 