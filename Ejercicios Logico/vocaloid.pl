canta(megurineLuka, nightFever, 4).
canta(megurineLuka, foreverYoung, 5).
canta(hatsuneMiku, tellYourWorld, 4).
canta(gumi, tellYourWorld, 5).
canta(gumi, foreverYoung, 4).
canta(seeU , novemberRain, 6).
canta(seeU , nightFever, 5).

esNovedoso(Vocaloid):-
    sabeAlMenosDos(Vocaloid),
    duracionCanciones(Vocaloid, Duracion),
    Duracion <15.
    
sabeAlMenosDos(Vocaloid):-
    canta(Vocaloid,_,_),
    findall(Cancion, canta(Vocaloid, Cancion, _), Canciones),
    length(Canciones, CantCanciones),
    CantCanciones >= 2.

duracionCanciones(Vocaloid, DuracionTotal):-
    canta(Vocaloid,_,_),
    findall(Duracion, canta(Vocaloid, _, Duracion), Duraciones),
    sumlist(Duraciones, DuracionTotal).

esAcelerado(Vocaloid):-
    canta(Vocaloid, _, _),
    not((canta(Vocaloid, _, Duracion), Duracion >4)).

concierto(mikuExpo, 2000, eeuu, gigante(2,6)).
concierto(magical, 3000, japon, gigante(3,10)).
concierto(vocalekt, 1000, eeuu, mediano(9)).
concierto(mikuFest, 100, argentina, pequenio(4)).

puedeParticipar(Concierto, Vocaloid):-
    concierto(Concierto, _, _, Condiciones),
    cumpleCondiciones(Vocaloid, Condiciones).

cumpleCondiciones(Vocaloid, gigante(MinCanciones, DuracionTotal)):-
    duracionCanciones(Vocaloid, Duracion),
    Duracion>DuracionTotal,
    cantidadCanciones(Vocaloid, Cantidad),
    Cantidad > MinCanciones.
cumpleCondiciones(Vocaloid, mediano(MaxDuracion)):-
    duracionCanciones(Vocaloid, Duracion),
    Duracion < MaxDuracion.
cumpleCondiciones(Vocaloid, pequenio(MinDuracionUnaCancion)):-
    canta(Vocaloid, _, Duracion),
    Duracion > MinDuracionUnaCancion.
cumpleCondiciones(hatsuneMiku, _).

cantidadCanciones(Vocaloid, Cantidad):-
    canta(Vocaloid,_,_),
    findall(Cancion, canta(Vocaloid, Cancion, _), Canciones),
    length(Canciones, Cantidad).


elMasFamoso(Vocaloid):-
    nivelDeFama(Vocaloid, Fama),
    forall(nivelDeFama(_, OtraFama), Fama>OtraFama).

nivelDeFama(Vocaloid, FamaFinal):-
    concierto(Concierto, _, _, _),
    findall(Fama, obtenerFama(Vocaloid, Concierto, Fama), ListaFama),
    sumlist(ListaFama, FamaTotal),
    cantidadCanciones(Vocaloid, Cantidad),
    FamaFinal is Cantidad * FamaTotal.
    
obtenerFama(Vocaloid, Concierto, Fama):-
    puedeParticipar(Concierto, Vocaloid),
    concierto(Concierto, Fama, _, _).