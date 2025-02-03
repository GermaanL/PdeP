/*
Parte A
La fábrica de muebles Armando requiere de su manejo de stock de los productos que realiza en sus distintos locales. Manejan los siguientes productos:
    Sillones: que tiene un tipo (común, cama, reclinable) y cantidad de módulos
    Mesas: forma (rectangular, cuadrada, circular) y material (madera, vidrio)
    Sillas: material (metal, madera)
Se tiene la siguiente base de conocimiento:
%stock(sucursal, producto, cantidad)
*/
stock(boedo, sillon(comun, 3), 4).
stock(boedo, silla(madera), 12).
stock(flores, sillon(cama, 2), 1).
stock(flores, mesa(circular, vidrio), 1).
stock(flores, silla(metal), 4).
stock(belgrano, sillon(reclinable, 2), 3).
stock(belgrano, silla(madera), 8).

/*
Realizar la codificación y las justificaciones para cada punto:
Sabiendo que tenemos los siguientes clientes: 
    Mati, que busca una mesa circular de vidrio y 4 sillas de metal. 
    Leo, que busca un sillón cama de 2 módulos y otro reclinable de 1. 
Agregar la información a la base de conocimientos, sabiendo que se debe poder responder la consulta “¿Qué busca Leo?” (por ejemplo). ¿Hace falta usar listas para representar la información? Si es posible, hacerlo sin usar listas y explicar los conceptos que lo permiten, y en caso contrario hacerlo con listas y explicar por qué son necesarias.
*/

busca(mati, mesa(circular, vidrio), 1).
busca(mati, silla(metal), 4).
busca(leo, sillon(cama,2), 1).
busca(leo, sillon(reclinable, 1), 1).



/*
Saber si hay una sucursal ideal para un cliente, del cual se conoce su nombre y la información que se agregó en los puntos anteriores. Una sucursal es ideal si tiene en stock todo lo que el cliente busca. ¿Qué concepto aparece que no estaba siendo usado antes?
*/

esIdeal(Sucursal, Cliente) :-
    stock(Sucursal, _, _),
    busca(Cliente, _, _),
    forall(busca(Cliente, Producto, CantBuscada), hayStockSuficiente(Sucursal, Producto, CantBuscada)).


hayStockSuficiente(Sucursal, Producto, CantBuscada) :- 
    stock(Sucursal, Producto, CantLocal), 
    CantBuscada =< CantLocal.
    
/* -------------------------------------------------------------------------------------------------------------------------*/



/* --------------------------------------------------- FINAL DIC 2023 ------------------------------------------------------*/



/* -------------------------------------------------------------------------------------------------------------------------*/


/* --------------------------------------------------- FINAL DIC 2022 ------------------------------------------------------*/

toma(juan, coca).
toma(juan, vino(malbec,3)).
toma(diana, cerveza(golden, 18, 0)).
toma(gisela, cerveza(ipa, 52, 7)).
toma(edu, cerveza(stout, 28, 6)).

tieneProblemas(Persona) :-
    toma(Persona, _),
    findall(C, (toma(Persona, cerveza(C, _, A)), A>0), Cs),
    findall(V, toma(Persona, vino(V, _)), Vs),
    findall(T, toma(Persona, T), Ts),
    length(Cs, CCs),
    length(Vs, CVs),
    length(Ts, CTs),
    CTs is CCs + CVs.
    
persona(Persona):- toma(Persona, _).
    
tieneProblemasMejorado(Persona) :-
    persona(Persona),
    forall(toma(Persona, Bebida), tieneAlcohol(Bebida)).

tieneAlcohol(vino(_, _)).
tieneAlcohol(cerveza(_,_,A)):- A>0.
tieneAlcohol(_):- false.

/* -------------------------------------------------------------------------------------------------------------------------*/

/* Paradigmas de Programación                             Examen Final     	                                   23/02/2019   */


% Relaciona un alumno con un final al que se anotó.
anotado(ana,paradigmas,25).
anotado(ana,fisicaII,9).
anotado(beto,paradigmas,25).
anotado(camilo,paradigmas,25).

fecha(paradigmas,11).
fecha(paradigmas,18).
fecha(paradigmas,25).
fecha(fisicaII, 9).
fecha(fisicaII,16).
fecha(fisicaII,23).

ultimaFecha(Materia,Fecha):- 
        fecha(Materia, _),
        findall(Dia, fecha(Materia, Dia), Fechas), 
        max_list(Fechas, Fecha).
% El predicado max_list/2 relaciona a una lista con su elemento máximo.

/*

1. Con la solución dada, ¿qué se obtendrá como respuesta a la consulta ultimaFecha(Materia,Fecha)? Explicar cómo se llega a esa conclusión.
2. reescribir el predicado ultimaFecha sin usar listas y comparar ambas soluciones en términos de declaratividad. Asegurar que la nueva solución sea inversible.
3. Asumiendo que el predicado ultimaFecha fue corregido como se solicitó, responder para las siguientes consultas qué significado tiene y qué soluciones genera Prolog.
    ?- forall(anotado(_,paradigmas,Fecha), ultimaFecha(paradigmas,Fecha)).
    ?- anotado(Alumno1, Materia, Fecha), anotado(Alumno2, Materia, Fecha), Alumno1 \= Alumno2

*/

% 1) Se obtendria como respuesta Fecha = 25, ya que no es inversible el predicado. 

% 2) 

ultimaFechaFinal(Materia, Fecha):-
    fecha(Materia, Fecha),
    forall(fecha(Materia, Fecha2), Fecha >= Fecha2).

% 3)  forall(anotado(_,paradigmas,Fecha), ultimaFecha(paradigmas,Fecha)). TRUE

%     anotado(Alumno1, Materia, Fecha), anotado(Alumno2, Materia, Fecha), Alumno1 \= Alumno2. Las combinaciones de distintos alumnos que se anotaron en la misma fecha,
%                                                                                             ana-beto, ana-camilo, beto-ana, beto-camilo, camilo-ana, camilo-beto




/* --------------------------------------------------------------- FINAL 17/2/2024 -------------------------------------------------------------------*/


% tiene(Persona, Cosa).
% vale(Cosa, Valor).

tiene(tito, algo1).
tiene(tito, algo2).
tiene(pepe, algo3).
tiene(ana, algo4).

vale(algo1, 200).
vale(algo2, 300).
vale(algo3, 100).
vale(algo4, 400).


todoLoQueTieneEsMasValioso(P1, P2) :-
    forall((tiene(P1, Cosa1), vale(Cosa1, ValorCosaValiosa), tiene(P2, Cosa2), vale(Cosa2, ValorOtraCosa)), ValorCosaValiosa > ValorOtraCosa).


% ----------------------------------------------------------------------------------------------------------------------------------
%  Paradigmas de Programación                             Examen Final     	                                   16/02/2019
% ----------------------------------------------------------------------------------------------------------------------------------

% plato(restaurante, plato, precio)
plato(laAngioplastia,mila,180).
plato(laAngioplastia,bife,230).
plato(laAngioplastia,molleja,220).
plato(lasVioletas,bife,450).
plato(elCuartito,muzza,290).

bodegon(Restaurante):-
   not((plato(Restaurante,_,Precio),Precio >= 300)).
bodegon(Restaurante):-
   tieneMila(Restaurante).
tieneMila(Restaurante):-
   findall(Plato, plato(Restaurante,Plato,_), Platos),
   member(mila,Platos).

/*
Se conocen los platos que ofrece cada restaurante, y se sabe que se considera bodegón a un restaurante si todos sus platos tienen precio menor a $300 y además ofrece mila.

Responda verdadero o falso y justifique en todos los casos:
*/

%1 ) Hay que usar forall para solucionar el error de lógica del predicado bodegon/1.    ( F , aunque puede ser una solucion, no necesariamente es necesario usarlo: ) 

bodegonTuned(Resto) :-
    plato(Resto, mila, _),
    forall(plato(Resto, _, Precio), Precio < 300).

bodegonReTuned(Resto) :-
    plato(Resto, mila, _),
    not((plato(Resto, _, Precio), Precio >= 300)).

%  2 ) El predicado bodegon/1 es inversible. ( F ) el findall no es invirsible y se necesita un generador de Restaurante.


/*
Critique la solución en términos de declaratividad y expresividad.

    La solucion es poco declarativa ya que no delega del todo la solucion al motor d einferencia ya que se le dan demasiadas instrucciones.
    En cuanto a la expresividad esta bien ya que los nombres tienen sentido. Quizas poner EsBodegon. Ademas el uso del findall no es muy claro.

Proponga una solución que resuelva los problemas encontrados en los puntos anteriores sol en (1)

*/