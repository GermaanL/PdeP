--De cada postulante se conoce su nombre, su edad, su remuneración pretendida y una lista de conocimientos.


data Postulante = UnPostulante {
    nombre :: String,
    edad :: Double, 
    remuneracion :: Double, 
    conocimientos :: [String]
} deriving Show 

pepe = UnPostulante "Jose Perez" 35 15000.0 ["Haskell", "Prolog", "Wollok", "C"]
tito = UnPostulante "Roberto Gonzalez" 20 12000.0 ["Haskell", "Php"]

--También hay algunos puestos a cubrir, con sus correspondientes conocimientos necesarios:
type Nombre = String
data Puesto = UnPuesto {
    puesto:: String, 
    conocimientoRequeridos :: [String]
} deriving Show

jefe = UnPuesto "gerente de sistemas" ["Haskell", "Prolog", "Wollok"]
chePibe = UnPuesto "cadete" ["ir al banco"]
 
apellidoDueno:: Nombre
apellidoDueno = "Gonzalez"

{-
La empresa tiene una política de recursos humanos que se basa en los siguientes requisitos:

    a.    tieneConocimientos recibe un puesto y un postulante y devuelve si el postulante posee todos los conocimientos requeridos para el puesto.

    b.    edadAceptable recibe una edad mínima y una edad máxima y un postulante y devuelve si el postulante tiene la edad requerida para el puesto.

    c.     sinArreglo recibe a un postulante y verifica que no tenga el apellido del dueño de la empresa. (se asume que el apellido es el último nombre del postulante)
-}

tieneConocimientos:: Puesto -> Postulante -> Bool
tieneConocimientos puesto postulante = all(\req -> elem req (conocimientos postulante)) (conocimientoRequeridos puesto)

edadAceptable :: Double -> Double -> Postulante -> Bool
edadAceptable min max postulante = edad postulante < max && ((> min).edad) postulante 

sinArreglo :: Postulante -> Bool
sinArreglo postulante = (not.(==apellidoDueno).apellido.nombre) postulante

apellido :: String -> String
apellido nombreCompleto = (reverse.takeWhile (/=' ').reverse) nombreCompleto

{-
2)    Preselección
En base a lo anterior, y previendo la existencia de nuevos criterios, definir una función que recibe una lista de postulantes y una lista con los requisitos de selección que devuelva a los postulantes que cumplen con todo lo indicado.
    a.    Mostrar un ejemplo de consultas para el puesto de gerente de sistemas, con edad entre 30 y 40 años, con los conocimientos correspondientes y que no esté arreglado.
    b.    Sin definir una nueva función, añadir a la consulta anterior, un nuevo requisito, que consiste en que entre los conocimientos del postulante no esté "repetir lógica".
-}

type Criterio = Postulante -> Bool

preseleccion :: [Postulante] -> [Criterio] -> [Postulante]
preseleccion postulantes criterios= filter (cumpleCriterios criterios) postulantes

cumpleCriterios :: [Criterio] -> Postulante -> Bool
cumpleCriterios criterios postulante = all (\criterio -> criterio postulante) criterios

noRepetirLogica :: Criterio
noRepetirLogica postulante = ((notElem "no repetir logica"). conocimientos ) postulante