atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).
atiende(valen, Dia, Entrada, Salida):-
    atiende(dodain, Dia, Entrada, Salida).
atiende(valen, Dia, Entrada, Salida):-
    atiende(juanC, Dia, Entrada, Salida).

persona(Persona):-
    atiende(Persona, _, _, _).

quienAtiende(Dia, Hora, Persona):-
    atiende(Persona, Dia, I, O),
    between(I, O, Hora).
    

foreverAlone(Dia, Hora, Persona):-
    atiende(Persona, Dia, I, O),
    between(I, O, Hora),
    not((atiende(OtraPersona, Dia, I, O), between(I, O, Hora), Persona \= OtraPersona)).

posibilidadDeAtencion(Dia, CombPersonas):-
    findall(Persona, distinct(Persona, quienAtiende(Dia, _ , Persona)), Personas),
    combinatoria(Personas, CombPersonas).

combinatoria([], []).
combinatoria([Persona|RestoPersonas], [Persona|Lista]):-
    combinatoria(RestoPersonas, Lista).
combinatoria([_|RestoPersonas], Lista):-
    combinatoria(RestoPersonas, Lista).

vendio(dodain, lunes, fecha(10,8), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
vendio(dodain, miercoles, fecha(12,8), [bebidas(alcoholicas, 8), bebidas(noAlcoholicas, 1), golosinas(10)]).
vendio(martu, miercoles, fecha(12,8), [golosinas(1000),cigarrillos([chesterfield,colorado,parisiennes])]).
vendio(lucas, martes, fecha(11,8), [golosinas(600)]).
vendio(lucas, martes, fecha(18,8), [bebidas(noAlcoholicas,2),cigarrillos(derby)]).

suertudo(Persona):-
    vendedor(Persona),
    forall(vendio(Persona, _, _, [Producto|_]), esVentaImportante(Producto)).
    
vendedor(Persona):-
    vendio(Persona, _, _, _).

esVentaImportante(golosinas(Precio)):-
    Precio>100.
esVentaImportante(cigarrillos(Marcas)):-
    length(Marcas, CantMarcas),
    CantMarcas>2.
esVentaImportante(bebidas(alcoholicas,_)).
esVentaImportante(bebidas(noAlcoholicas,Cantidad)):-
    Cantidad>5.
