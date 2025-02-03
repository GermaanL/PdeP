

transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat,2015)).
transporte(ana, auto(fiesta, ford, 2014)).
transporte(roberto, auto(qubo, fiat, 2015)).

manejaLento(manuel).
manejaLento(ana).

/*
1) Realizar las consultas que permita conocer quiénes son los que vienen en auto de marca fiat.
2) Definir tardaMucho/1, se verifica si la persona viene caminando o viene en auto y maneja lento. ( debe ser totalmente inversible).
3) ¿ Quiénes son las personas que viajan en colectivo?.
*/

marca(Marca):-transporte(_, auto(_, Marca, _)).

utilizanMarca(Persona, Marca) :-
    marca(Marca),
    transporte(Persona, auto(_, MarcaAuto, _)),
    Marca == MarcaAuto.

tardaMucho(Persona):-
    transporte(Persona, camina).
tardaMucho(Persona):-
    manejaLento(Persona).

usaColectivo(Persona):-
    transporte(Persona, colectivo(_)).


%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(lasToninas, carpa(60)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(laFalda, carpa(70)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).


/*
puedeIr/3, relaciona una persona, con el lugar y el alojamiento.
Para que una persona pueda alojarse en un lugar, debe alcanzar el dinero disponible y cumplirse las siguientes condiciones.
• Si es un hotel la cantidad de estrellas debe ser mayor a 3.
• Si es una casa debe tener garaje.
• Si es una quinta debe tener pileta.
• Y en caso de una carpa solo le debe alcanzar el dinero.

2) Conocer las personas que pueden ir a cualquier lugar ya que en todos los lugares tienen al menos un alojamiento en donde le alcanza el dinero para ir.
*/

puedeIr(Persona, Lugar, Alojamiento):-
    lugar(Lugar, Alojamiento),
    alcanzaDinero(Persona, Alojamiento),
    cumpleCondiciones(Alojamiento).

cumpleCondiciones(hotel(_,Estrellas,_)) :- Estrellas >3.
cumpleCondiciones(casa(garage, _)).
cumpleCondiciones(quinta(_, pileta, _)).
cumpleCondiciones(carpa(_)).

alcanzaDinero(Persona, Alojamiento) :-
    puedeGastar(Persona, Dias, Disponible),
    precio(Alojamiento, Monto),
    Monto * Dias =< Disponible.

precio(carpa(Monto), Monto). 
precio(hotel(_,_,Monto), Monto). 
precio(quinta(_,_,Monto), Monto). 
precio(casa(_,Monto), Monto).

