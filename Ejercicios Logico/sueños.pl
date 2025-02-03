cree(gabriel,campanita).
cree(gabriel,magoDeOz).
cree(gabriel,cavenagui).
cree(juan,conejoDePascua).
cree(macarena,reyesMagos).
cree(macarena,magoCapria).
cree(macarena,campanita).

quiere(gabriel,loteria([5,9])).
quiere(gabriel,futbolista(arsenal)).
quiere(juan,cantante(100000)).
quiere(macarena,cantante(10000)).

persona(Persona):-
    quiere(Persona,_).

esAmbiciosa(Persona):-
    sumaDificultades(Persona,Total), Total>20.

sumaDificultades(Persona, Total):- 
    persona(Persona),
    findall(Dificultad, dificultad(Persona,Dificultad), ListaDificultades),
    sumlist(ListaDificultades, Total).

dificultad(Persona,Dificultad):-
    quiere(Persona,Suenio),
    nivelDificultad(Suenio,Dificultad).

nivelDificultad(loteria(Lista),Dificultad):-
    length(Lista, Cantidad),
    Dificultad is 10*Cantidad.
nivelDificultad(cantante(Discos),6):-
    Discos>500000.
nivelDificultad(cantante(Discos),4):-
    Discos =<500000.
nivelDificultad(futbolista(Equipo),3):-
    esEquipoChico(Equipo).
nivelDificultad(futbolista(Equipo),16):-
    not(esEquipoChico(Equipo)).

esEquipoChico(arsenal).
esEquipoChico(aldosivi).

tieneQuimica(Persona,Personaje):-
    cree(Persona,Personaje),
    cumpleCondicionesPj(Personaje,Persona).

cumpleCondicionesPj(campanita,Persona):-
    dificultad(Persona,Dificultad),
    Dificultad<5.
cumpleCondicionesPj(Personaje,Persona):-
    Personaje\=campanita,
    todosPuros(Persona),
    not(esAmbiciosa(Persona)).

todosPuros(Persona):-
    forall(quiere(Persona,Suenio), esPuro(Suenio)).

esPuro(futbolista(_)).
esPuro(cantante(Discos)):-
    Discos<200000.
    
esAmigo(campanita,reyesMagos).
esAmigo(campanita,conejoDePascua).
esAmigo(conejoDePascua,cavenagui).

puedeAlegrar(Personaje, Persona):-
    quiere(Persona,_),
    tieneQuimica(Persona, Personaje),
    cumpleCondicionesParaAlegrar(Personaje).

cumpleCondicionesParaAlegrar(Personaje):-
    not(estaEnfermo(Personaje)).
cumpleCondicionesParaAlegrar(Personaje):- backup(Personaje, Backup), 
cumpleCondicionesParaAlegrar(Backup).

backup(Personaje, OtroPersonaje):- 
    esAmigo(Personaje, OtroPersonaje).
backup(Personaje, OtroPersonaje):- 
    esAmigo(Personaje, Backup),
    backup(Backup,OtroPersonaje).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).