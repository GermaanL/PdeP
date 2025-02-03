-- Representamos las notas que se sacó un alumno en dos parciales mediante un par (nota1,nota2), p.ej. un patito en el 1ro y un 7 en el 2do se representan mediante el par (2,7). 
-- A partir de esto: 
-- Definir la función esNotaBochazo, recibe un número y devuelve True si no llega a 6, False en caso contrario. No vale usar guardas. 
-- Definir la función aprobo, recibe un par e indica si una persona que se sacó esas notas aprueba. Usar esNotaBochazo. 
-- Definir la función promociono, que indica si promocionó, para eso tiene las dos notas tienen que sumar al menos 15 y además haberse sacado al menos 7 en cada parcial. 
-- Escribir una consulta que dado un par indica si aprobó el primer parcial, usando esNotaBochazo y composición. La consulta tiene que tener esta forma (p.ej. para el par de notas (5,8)) 
-- Main> (... algo ...) (5,8) 




esNotaBochazo   :: Integer -> Bool
esNotaBochazo x = x < 6

aprobo          :: (Integer, Integer) -> Bool
aprobo (x,y) = (not.esNotaBochazo) x && (not.esNotaBochazo) y

promociono      :: (Integer, Integer) -> Bool
promociono (x,y) = x+y >= 15 && x>=7 && y>=7

consulta = (\(x,_)->(not.esNotaBochazo) x)