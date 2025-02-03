
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn). % Sí, un aula es un lugar!
quedaEn(utn, buenosAires).
quedaEn(buenosAires, argentina).
% quedaEn(unc, cordoba).


nacioEn(dani, buenosAires).
nacioEn(alf, buenosAires).
nacioEn(nico, buenosAires).

hicieron(dani, examen(paradigmaLogico, aula522),fecha(10,8,2019)).
hicieron(dani, gol(primeraDivision, buenosAires),fecha(10,8,2019)).
hicieron(alf, discurso(0, utn),fecha(11,8,2019)).

trabajador(Trabajador):-
    nacioEn(Trabajador, _).

nuncaSalioDeCasa(Trabajador) :- 
    nacioEn(Trabajador, Lugar),
    forall(hicieron(Trabajador, Tarea, _), mismaProvincia(Tarea, Lugar)).

mismaProvincia(examen(_, Aula), Lugar):-
    quedaEn(Aula, Univ),
    quedaEn(Univ, Lugar).
mismaProvincia(gol(_, Lugar), Lugar).
mismaProvincia(discurso(_, Univ), Lugar):-
    quedaEn(Univ, Lugar).

esEstresante(Tarea):-
    hicieron(_, Tarea, _),
    mismaProvincia(Tarea, Provincia),
    quedaEn(Provincia, argentina),
    condicionEstress(Tarea).

condicionEstress(discurso( Personas, _)):-
    Personas>30000.
condicionEstress(examen(Tema, _)):-
    esComplejo(Tema).
condicionEstress(gol(_,_)).

esComplejo(paradigmaLogico).

estaAlterado(Trabajador, Calificacion):-
    trabajador(Trabajador),
    calificarSegun(Trabajador, Calificacion).

calificarSegun(Trabajador, zen):-
    forall(hicieron(Trabajador, Tarea, _), not(esEstresante(Tarea))).
calificarSegun(Trabajador, locos):-
    forall(hicieron(Trabajador, Tarea, fecha(_,_,2019)), esEstresante(Tarea)).
calificarSegun(Trabajador, sabios):-
    hizoTareaEstresante(Trabajador, Tarea),
    not(( hizoTareaEstresante(Trabajador, OtraTarea), Tarea \= OtraTarea )).

hizoTareaEstresante(Trabajador, Tarea):-
    hicieron(Trabajador, Tarea, _),
    esEstresante(Tarea).

elMasChapita(Trabajador):-
    cantidadTareasEstresantes(Trabajador, Cantidad),
    forall(cantidadTareasEstresantes(_, OtraCantidad), Cantidad >= OtraCantidad).

cantidadTareasEstresantes(Trabajador, Cantidad):-
    trabajador(Trabajador),
    findall(TareaEstresante, hizoTareaEstresante(Trabajador, TareaEstresante), TareasEstresantes),
    length(TareasEstresantes, Cantidad).
    

    
    