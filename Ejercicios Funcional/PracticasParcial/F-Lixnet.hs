
data Pelicula = Pelicula {
    nombrePelicula::String,
    genero::String,
    duracion::Int,
    origen::String
}deriving (Show, Eq);

data Usuario = Usuario {
    nombre::String,
    categoria::String,
    edad::Int,
    paisResidencia::String,
    peliculasVistas::[Pelicula],
    salud::Int
}deriving Show;



psicosis = Pelicula "Psicosis" "Terror" 109 "Estados Unidos"
perfumeDeMujer= Pelicula "Perfume de Mujer" "Drama" 150 "Estados Unidos"
elSaborDeLasCervezas = Pelicula "El sabor de las cervezas" "Drama" 95 "Iran"
lasTortugasTambienVuelan = Pelicula "Las tortugas también vuelan" "Drama" 103 "Iran"

--(básica, estándar o premium)
juan = Usuario "juan" "estandar" 23 "Argentina" [perfumeDeMujer] 60


ver :: Pelicula -> Usuario -> Usuario
ver pelicula usuario = usuario {peliculasVistas = peliculasVistas usuario ++ [pelicula]}


premiarUsuario :: [Usuario] -> [Usuario]
premiarUsuario usuarios = map premiarUsuarioFiel usuarios

premiarUsuarioFiel :: Usuario -> Usuario
premiarUsuarioFiel usuario | usuarioFiel usuario = subirCategoria usuario
                           | otherwise = usuario

usuarioFiel:: Usuario -> Bool
usuarioFiel usuario = ((>20).length.noSonAmericanas.peliculasVistas) usuario

noSonAmericanas:: [Pelicula] -> [Pelicula]
noSonAmericanas peliculas = filter ((/= "Estados Unidos").origen ) peliculas

subirCategoria :: Usuario -> Usuario
subirCategoria usuario = usuario {categoria = (nuevaCategoria.categoria) usuario}

nuevaCategoria :: String -> String
nuevaCategoria "basica" = "estandar"
nuevaCategoria _ = "premium"



--Punto 2

type Criterio = Pelicula -> Bool

teQuedasteCorto :: Criterio
teQuedasteCorto peli = (<35).duracion $ peli

cuestionDeGenero :: [String] -> Criterio
cuestionDeGenero generos peli = any (== genero peli) generos

deDondeSaliste :: String -> Criterio
deDondeSaliste unOrigen peli = (==unOrigen).origen $ peli

vaPorEseLado :: (Eq t) => Pelicula -> (Pelicula -> t) -> Criterio
vaPorEseLado unaPelicula caracteristica otraPelicula = caracteristica unaPelicula == caracteristica otraPelicula


buscarPelicula :: Usuario -> [Criterio] -> [Pelicula] -> [Pelicula]
buscarPelicula usuario criterios peliculasEmpresa = take 3 (filter (esPara usuario criterios) peliculasEmpresa)

esPara :: Usuario -> [Criterio] -> Pelicula -> Bool
esPara usuario criterios pelicula = noFueVista usuario pelicula && cumpleCriterios criterios pelicula

noFueVista :: Usuario -> Pelicula -> Bool
noFueVista usuario pelicula = notElem pelicula (peliculasVistas usuario)

cumpleCriterios :: [Criterio] -> Pelicula -> Bool
cumpleCriterios criterios pelicula = all ($ pelicula) criterios

type Modificacion = Usuario -> Usuario

data Cap = Cap {
    nombreCap::String,
    generoCap::String,
    duracionCap::Int,
    origenCap::String,
    modificaSalud::Modificacion
}

quedaAfectado :: Usuario -> Cap -> Usuario
quedaAfectado usuario capitulo = (modificaSalud capitulo) usuario

restarDeSalud :: Int -> Modificacion
restarDeSalud cantidad usuario = usuario {salud = salud usuario - cantidad}

capitulo1 = Cap "Capitulo 1" "Accion" 30 "Argentina" (restarDeSalud 10)
capitulo2 = Cap "Capitulo 2" "Accion" 30 "Argentina" (restarDeSalud 20)

type Serie = [Cap]

maraton :: Serie -> Usuario -> Usuario
maraton capitulos usuario = foldl (\user cap -> quedaAfectado user cap ) usuario capitulos
