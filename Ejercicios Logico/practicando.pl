% natacion: estilos (lista), metros nadados, medallas
practica(ana, natacion([pecho, crawl], 1200, 10)).
practica(luis, natacion([perrito], 200, 0)).
practica(vicky, 
   natacion([crawl, mariposa, pecho, espalda], 800, 0)).
% fútbol: medallas, goles marcados, veces que fue expulsado
practica(deby, futbol(2, 15, 5)).
practica(mati, futbol(1, 11, 7)).
% rugby: posición que ocupa, medallas
practica(zaffa, rugby(pilar, 0)).


esNadador(Persona):-
    practica(Persona, natacion(_, _, _)).

tieneMedallas(Persona, Medallas):-
    practica(Persona, Deporte),
    medallas(Deporte, Medallas).

medallas(natacion(_, _, Medallas), Medallas).
medallas(futbol(Medallas, _, _), Medallas).
medallas(rugby( _, Medallas), Medallas).

esBuenDeportista(Persona):-
    practica(Persona, Deporte),
    esBueno(Deporte).

esBueno(natacion(_, Metros, _)):- Metros>1000.
esBueno(natacion(Estilos, _, _)):- length(Estilos, CantEstilos), CantEstilos>3.
esBueno(futbol(_, Goles, Expulsiones)):- Diferencia is Goles - Expulsiones, Diferencia>5.
esBueno(rugby(wing, _)).
esBueno(rugby(pilar, _)).