vive(remy,gusteaus).
vive(emile,chezMilleBar).
vive(django,pizzeriaJeSuis).

cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(collete, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).
cocina(amelie, bifeDeChorizo, 8).
cocina(amelie, ratatouille, 8).
% cocina(franquito, bifeDeChorizo, 8).
% cocina(franquito, ratatouille, 8).

trabajaEn(linguini,gusteaus).
trabajaEn(collete,gusteaus).
trabajaEn(horst,gusteaus).
trabajaEn(skinner,gusteaus).
trabajaEn(amelie,cafeDes2Moulines).
% trabajaEn(franquito,cafeDes2Moulines).

restaurante(Resto):-trabajaEn(_,Resto).
plato(Plato):-cocina(_, Plato, _).

%esTutor(Quien, DeQuien).
esTutor(Tutor,linguini):-trabajaEn(linguini,Restaurante),vive(Tutor,Restaurante).
esTutor(amelie,skinner).

estaEnElMenu(Plato, Restaurante):-trabajaEn(Cocinero, Restaurante),cocina(Cocinero ,Plato, _).

cocinaBien(Plato, Cocinero):-
    cocina(Cocinero, Plato, Exp), 
    Exp>7.
cocinaBien(Plato, Cocinero):-
    cocina(Cocinero, Plato, _), 
    esTutor(Tutor, Cocinero), 
    cocinaBien(Plato, Tutor).
cocinaBien(Plato, remy):-
    cocina(_,Plato,_).

esChefDe(Cocinero, Restaurante):- 
    trabajaEn(Cocinero,Restaurante), 
    cumpleCondiciones(Cocinero, Restaurante).

cumpleCondiciones(Cocinero, Restaurante):- 
    forall(estaEnElMenu(Plato, Restaurante), 
    cocinaBien(Plato, Cocinero)).
cumpleCondiciones(Cocinero, _):-
    totalExperiencia(Cocinero, Total), 
    Total > 20.

totalExperiencia(Cocinero, Total):- 
    findall(Experiencia, cocina(Cocinero,_, Experiencia), ListaExperiencias), 
    sumlist(ListaExperiencias, Total).

encargada(Persona, Plato, Restaurante):- 
    experienciaEnRestaurante(Persona, Plato, Restaurante, Experiencia), 
    forall(experienciaEnRestaurante(_, Plato, Restaurante, OtraExperiencia), 
    OtraExperiencia =< Experiencia).

experienciaEnRestaurante(Persona, Plato, Restaurante, Experiencia):-
    trabajaEn(Persona, Restaurante), cocina(Persona, Plato, Experiencia). 

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 2)).
plato(frutillasConCrema, postre(265)).
plato(ratatouille, principal(ensalada, 10)).

%5

esSaludable(Plato):-
    plato(Plato, TipoPlato), 
    cumpleCondicionesSalud(TipoPlato, Calorias),
    Calorias < 75.

cumpleCondicionesSalud(entrada(ListaIngredientes), Calorias):-
    length(ListaIngredientes, Suma),
    Calorias is Suma * 15.
cumpleCondicionesSalud(principal(Guarnicion, Min), Calorias):-
    caloriasGuarnicion(Guarnicion, CaloriasGuarnicion),
    Calorias is CaloriasGuarnicion + Min*5.
cumpleCondicionesSalud(postre(Calorias),Calorias).

caloriasGuarnicion(papasFritas, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0).

reseniaPositiva(Critico, Restaurante):-
    noHayRatas(Restaurante),
    cumpleCondicionesCritico(Critico, Restaurante).

cumpleCondicionesCritico(antonEgo, Restaurante):-
    estaEnElMenu(ratatouille, Restaurante),
    forall(trabajaEn(Cocinero, Restaurante), cocinaBien(ratatouille, Cocinero)).
cumpleCondicionesCritico(cormillot, Restaurante):-
    forall(estaEnElMenu(Plato, Restaurante), esSaludable(Plato)).
cumpleCondicionesCritico(martiniano, Restaurante):-
    soloHayUnChef(Restaurante).

soloHayUnChef(Restaurante):-
    restaurante(Restaurante),
    findall(Chef, esChefDe(Chef, Restaurante), Chefs),
    length(Chefs, CantChefs),
    CantChefs =:= 1.
    
noHayRatas(Restaurante):-
    restaurante(Restaurante),
    not(vive(_, Restaurante)).

