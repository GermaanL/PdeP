import Data.List (tails)
type Bebida = String
type Bebidas = [Bebida]

data Persona = Persona {
    nombre::String,
    edad::Int,
    bebidasTomadas::[Bebida]
}deriving(Show)

german = Persona "German" 24 ["vodka"]


tomar :: Bebida -> Persona -> Persona
tomar bebida (Persona n e bebidas) = Persona n e (bebida:bebidas) 

mezclar :: Bebida -> Bebida -> Bebida
mezclar bebida1 bebida2 = bebida1 ++ bebida2

seTomanUnCoctelConEstasBebidas :: Bebidas -> [Persona] -> [Persona]
seTomanUnCoctelConEstasBebidas bebidas personas = 
    map ((tomar.foldl1 mezclar) bebidas) personas


{--------------------------------------- FINAL 17/2/2024 -------------------------------------------}


{-
sirve :: Problema -> Habilidad -> Bool

podrianAyudar :: Problema -> [Persona] -> [Persona]
podrianAyudar problema personas = filter (any(\habilidad -> sirve problema habilidad) habilidades) personas
-}

-- ----------------------------------------------------------------------------------------------------------------------------------
--  Paradigmas de Programación                             Examen Final     	                                   16/02/2019
-- ----------------------------------------------------------------------------------------------------------------------------------


{-

Se desea modelar en el paradigma funcional un sistema de reglas de un firewall. Existen paquetes que llegan al firewall, que tiene una serie de reglas, y el firewall no deja pasar los paquetes que incumplan alguna regla. Un paquete tiene una dirección de origen, una dirección de destino, y un contenido. Y puede haber varias reglas, como por ejemplo una que sólo deja pasar paquetes de direcciones internas (si los primeros 7 caracteres del origen son “192.168”), una que no deja pasar paquetes con cierto destino exacto indicado por el administrador al configurar la regla, o una que no deja pasar paquetes que contengan en su contenido alguna palabra de una lista negra indicada en dicha regla (se puede asumir que existe una función incluyePalabra :: String -> String -> Bool que verifica si el primer String contiene al segundo, para simplificar este problema).

Se pide:
 1)   Definir tipos de datos y funciones (explicitando el tipo de todas ellas) para cubrir las necesidades explicadas.
 2)   Mostrar cómo se representa un firewall de ejemplo que tenga las tres reglas mencionadas anteriormente.
 3)   Desarrollar una función que permita saber qué paquetes de una lista de paquetes pasan por el firewall.
 4)   Indicar dónde y para qué se utilizaron los siguientes conceptos: composición, aplicación parcial y orden superior.

-}

--incluyePalabra :: String -> String -> Bool que verifica si el primer String contiene al segundo

data Paquete = NuevoPaquete {
    dirOrigen::String,
    dirDestino::String,
    contenido::String
}

esDireccionInterna :: Paquete -> Bool
esDireccionInterna paquete = (((=="192.168").take 7).dirOrigen) paquete -- composicion

esDireccionProhibida :: String-> Paquete -> Bool
esDireccionProhibida dirProhibida paquete= ((==dirProhibida).dirDestino) paquete -- composicion para simplificar el uso de las funciones

tieneDatosProhibidos :: [String] -> Paquete ->  Bool
tieneDatosProhibidos listaNegra paquete = all (\palabraProhibida -> not(incluyePalabra (contenido paquete) palabraProhibida)) listaNegra

incluyePalabra :: String -> String -> Bool
incluyePalabra [] _ = False
incluyePalabra _ [] = True
incluyePalabra fuente buscada =
    let n = length buscada
    in any (== buscada) (map (take n) (tails fuente))

data Firewall = Fwll {
    reglas::[Paquete -> Bool]
}

firewallAntiHacker = Fwll [esDireccionInterna, esDireccionProhibida "192.123.94.1", tieneDatosProhibidos ["script", "destruirCodigo"]]
-- aplicacion parcial, para luego poder aplicarlo a un paquete entrante en otra funcion

pasanReglas :: Firewall -> Paquete -> Bool
pasanReglas firewall paquete = all (\regla -> regla paquete) (reglas firewall)
-- orden superior, para aplicar las funciones dentro de la funcion all y para tambien resolver el ejercicio
