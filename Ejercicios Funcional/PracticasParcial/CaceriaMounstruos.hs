import Text.Show.Functions

{-
Los personajes
    De un personaje nos interesa saber:
    Cuál es su nivel, lo que indica cuán bueno es. Se calcula en función de cuánta es su experiencia, como la experiencia al cuadrado sobre la experiencia más uno, redondeado hacia arriba.
    Su experiencia, que es un valor inicial arbitrario, se puede ir modificando a medida que transcurre el juego.
    Su capacidad para la caza, que se calcula como la fuerza básica que tiene el personaje modificado por el elemento que el personaje tiene.
-}
type Arma = Float->Float

data Personaje = Personaje {
    nombre::String,
    experiencia::Float,
    fuerzaBase::Float,
    armaPj::Arma
}deriving Show;

espadaOxidada = (1.2*)
katanaFilosa = (10+).(0.9*)
sableLambdico cm = ((1+cm/100)*)
redParadigmatica = sqrt
baculoDuplicador x= x* 2
espadaMaldita = espadaOxidada.sableLambdico 89


calcularNivel :: Personaje -> Int
calcularNivel (Personaje _ exp _ _) = ceiling ((exp^2) / (exp+1))

calcularCapacidadCaza :: Personaje -> Float
calcularCapacidadCaza (Personaje _ _ fuerza arma ) = arma fuerza

personaje1 = Personaje "Germansito" 100 10 espadaMaldita

personaje2 = Personaje "Nicolas" 200 30 baculoDuplicador


{-
Alquimistas
En este tipo de juegos suele haber alquimistas que (generalmente) mejoran la capacidad de caza de los personajes, alterando los elementos que se utilizan. Hay muchos tipos, pero algunos de los más usuales son:

    Los aprendices, que fusionan el elemento del cazador con un químico secreto que duplica su efecto.

    Los maestros alquimistas, que hacen lo mismo que los aprendices, pero además aplican al elemento un 10% extra de capacidad, tantas veces como años de oficio tenga en su profesión

    Los estafadores, que reemplazan el elemento del personaje por un elemento que no hace nada.

    Inventar un nuevo tipo de alquimista que, similar a los anteriores, haga algo con el elemento del personaje. Debe utilizarse alguna expresión lambda, de una forma que no sea trivial.

Lo que se necesita saber es, de una lista de alquimistas:

    Todos aquellos que hacen que la capacidad del cazador sea superior a un valor dado.
    Si todos le convienen al personaje
-}

type Alquimista = Personaje -> Personaje

aprendiz :: Alquimista
aprendiz pj = alterarElemento (2*) pj

alterarElemento :: Arma -> Alquimista
alterarElemento f pj = pj { armaPj = f.armaPj pj}

maestro :: Float -> Alquimista
maestro años pj = (alterarElemento (coeficienteAntiguedad años).aprendiz) pj

coeficienteAntiguedad :: (Eq t, Num t, Fractional a) => t -> a -> a
coeficienteAntiguedad 0 = id
coeficienteAntiguedad años = (*1.1).coeficienteAntiguedad (años-1)

estafador :: Alquimista
estafador pj = pj { armaPj = (1*)}

--combina el arma del pj con otra arma
experto = (\arma pj -> pj {armaPj =  arma.armaPj pj})

listaAlquimistas = [aprendiz , maestro 3, estafador, experto espadaMaldita]

capacidadesSuperioresA :: Float -> Personaje -> [Alquimista] -> [Alquimista]
capacidadesSuperioresA capacidad personaje alquimistas = filter (capacidadSuperiorA capacidad personaje) alquimistas

capacidadSuperiorA :: Float -> Personaje  -> Alquimista -> Bool
capacidadSuperiorA valor personaje alquimista = ((>valor).calcularCapacidadCaza.alquimista ) personaje

todosConvienen :: Personaje -> [Alquimista] -> Bool
todosConvienen pj alquimistas = all (capacidadSuperiorA (calcularCapacidadCaza pj) pj) alquimistas

type Habilidad = (String, String)

data Monstruo = Monstruo {
    especie::String,
    resistencia::Float,
    habilidades::[Habilidad]
}

monst1 = Monstruo "demonio" 120 [("bla bla bla","magia"),("bla bla", "fisica")]
monst2 = Monstruo "chocobo" 10 [("bla bla bla","naturaleza"),("bla bla", "fisica")]
monst3 = Monstruo "animal" 400 [("bla bla bla","naturaleza"),("bla bla bla","magia"),("bla bla", "fisica")]
monst4 = Monstruo "troll" 10 [("bla bla bla","magia"),("bla bla", "fisica")]

esAgresivo :: Monstruo -> Bool
esAgresivo monstruo = esChocoboOAnimal monstruo && tieneMasOfensivas monstruo && resistencia monstruo >0

esChocoboOAnimal :: Monstruo -> Bool
esChocoboOAnimal monstruo = not $ esEspecie "chocobo" (especie monstruo) || esEspecie "animal" (especie monstruo)

esEspecie :: String -> String -> Bool
esEspecie especieAComp especieMonstruo = especieAComp == especieMonstruo

tieneMasOfensivas :: Monstruo -> Bool
tieneMasOfensivas (Monstruo _ res habilidades) = (length.filter (esMagiaOFisica)) habilidades > (div (length habilidades) 2) 

esMagiaOFisica :: Habilidad -> Bool
esMagiaOFisica (_, tipo) = tipo == "magia" || tipo == "fisica"



ganaLaBatalla :: Personaje -> Monstruo -> Bool
ganaLaBatalla pj monstruo = calcularCapacidadCaza pj > resistencia monstruo



mapa = [monst1, monst2, monst3, monst4]

recorrerMapa :: [Monstruo] -> Personaje -> Personaje
recorrerMapa [] pj = pj
recorrerMapa (unMonstruo:otrosMonstruos) pj | esAgresivo unMonstruo = recorrerMapa otrosMonstruos (pelear unMonstruo pj)
                                            | otherwise = recorrerMapa otrosMonstruos pj

pelear :: Monstruo -> Personaje -> Personaje
pelear monstruo pj | ganaLaBatalla pj monstruo = modificarExp pj 100 
                   | otherwise = alterarElemento (*0.9) (modificarExp pj (-50)) 


modificarExp :: Personaje -> Float -> Personaje
modificarExp pj exp = pj {experiencia = experiencia pj + exp}


