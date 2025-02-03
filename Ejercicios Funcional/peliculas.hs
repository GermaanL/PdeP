-- El sistema maneja básicamente información de usuarios y películas. De las películas se conoce su nombre, género, duración y origen. De los usuarios se conoce su nombre, edad, categoría (básica, estándar o premium), país de residencia,  las películas vistas por él y el estado de salud.


-- 1) Modelar los tipos de datos necesarios 

data Pelicula = Pelicula {
    nombre::String,
    genero::String,
    duracion::Int,
    origen::String
}deriving(Show)

data Usuario = Usuario {
    nombreUsuario::String,
    categoria::String,
    edad::Int,
    pais::String,
    peliculasVistas::[Pelicula],
    estadoSalud::Int
}deriving(Show)

psicosis = Pelicula "Psicosis" "Terror" 109 "Estados Unidos"
perfumeDeMujer= Pelicula "Perfume de Mujer" "Drama" 150  "Estados Unidos"
elSaborDeLasCervezas = Pelicula "El sabor de las cervezas"  "Drama" 95 "Iran"
lasTortugasTambienVuelan = Pelicula "Las tortugas también vuelan" "Drama" 103 "Iran"
juan = Usuario "juan" "estandar" 23  "Argentina" [perfumeDeMujer] 60

--Hacer la función que permita que un usuario pueda ver una película, lo que implica que se agregue a su lista de películas vistas.

-- Por ejemplo
-- > ver psicosis juan
-- Usuario "juan" "estandar" 23 [ Pelicula "Perfume de Mujer" "Drama" 150  "Estados Unidos", Pelicula "Psicosis" 109 "Terror" "Estados Unidos" ] 60

verPeli :: Pelicula -> Usuario -> Usuario
verPeli pelicula usuario = usuario {peliculasVistas = peliculasVistas usuario ++ [pelicula]}

--Se necesita premiar a los usuarios internacionales fieles. De esta manera, a todos aquellos que hayan visto más de 20 películas que no sean de Estados Unidos, se les sube de categoría (el premium la mantiene). La función debe recibir una lista de usuarios y devolver una nueva lista. 

premiarFieles :: [Usuario] -> [Usuario]
premiarFieles usuarios = map () usuarios

premiarUsuario :: Usuario -> Usuario
premiarUsuario usuario  | usuarioFiel usuario = subirCategoria usuario
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


type Criterio = Pelicula -> Bool

buscar :: [Criterio] -> Usuario -> [Pelicula] -> [Pelicula]
buscar criterios usuario peliculasEmpresa = take 3 (filter (busquedaUsuario usuario criterios) peliculasEmpresa)

busquedaUsuario :: 

cumplenCriterios :: [Criterio] -> Pelicula -> Bool
cumplenCriterios criterios pelicula = 