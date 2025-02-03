rasgos(harry, mestiza, [coraje, amistoso, orgullo, inteligente], slitherin).
rasgos(draco, pura, [inteligente, orgullo], hufflepuff).
rasgos(hermione, impura, [inteligente, responsable, orgullo], _).

debeTener(gryffindor, [coraje]).
debeTener(slitherin, [orgullo, inteligente]).
debeTener(ravenclaw, [inteligente, responsable]).
debeTener(hufflepuff, [amistoso]).

esParteDe([],[]).
esParteDe([C|QueCadena], DeCualCadena):-
    member(C, DeCualCadena),
    esParteDe(QueCadena, DeCualCadena).
esParteDe([],_).

mago(Mago):-
    rasgos(Mago,_,_,_).
    
permiteEntrar(Casa, Mago):-debeTener(Casa,_), mago(Mago), condicionesCasa(Casa, Mago).
condicionesCasa(slitherin, Mago):-
    rasgos(Mago, Sangre, _, _),
    Sangre \= impura.
condicionesCasa(Casa, _):-Casa \=slitherin.

% Saber si un mago tiene el carácter apropiado para una casa, 
% lo cual se cumple para cualquier mago si sus características 
% incluyen todo lo que se busca para los integrantes de esa casa, 
% independientemente de si la casa le permite la entrada.

esApropiado(Casa, Mago):-
    debeTener(Casa, CaractCasa),
    rasgos(Mago, _, CaractMago, _),
    esParteDe(CaractCasa, CaractMago).

puedeQuedarSeleccionado(Casa, Mago):-
    rasgos(Mago, _, _, NoQuiere),
    esApropiado(Casa, Mago),
    Casa \= NoQuiere.
puedeQuedarSeleccionado(gryffindor, hermione).

% Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si todos ellos se caracterizan por ser amistosos y cada uno podría estar en la misma casa que el siguiente. No hace falta que sea inversible, se consultará de forma individual.

cadenaDeAmistades([Mago, OtroMago|Magos]):-
    puedeQuedarSeleccionado(Casa, Mago),
    puedeQuedarSeleccionado(Casa, OtroMago),
    esAmistoso(Mago),
    esAmistoso(OtroMago),
    cadenaDeAmistades([OtroMago|Magos]).
cadenaDeAmistades([]).
cadenaDeAmistades([_]).

esAmistoso(Mago):-
    rasgos(Mago, _, CaractMago,_),
    member(amistoso,CaractMago).


hizo(harry, mala(fueraDeLaCama,50)).
hizo(harry, mala(irBosque,50)).
hizo(harry, mala(irTercerPiso,75)).
hizo(harry, buena(ganarVoldemort,60)).
hizo(hermione, mala(irTercerPiso,75)).
hizo(hermione, mala(irSeccionProhibidaBiblio,10)).
hizo(hermione, buena(usarIntelecto,50)).
hizo(ron, buena(ganarAjedrez,50)).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

esBuenAlumno(Mago):-
    hizo(Mago, _),
    forall(hizo(Mago, Accion), Accion \= mala(_,_)).
    
esRecurrente(Accion):-
    hizo(Mago,Accion),
    hizo(OtroMago, Accion), 
    Mago \= OtroMago.

