primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
%donde Producto puede ser arroz(Marca), lacteo(Marca,TipoDeLacteo), salchicas(Marca,Cantidad)
precioUnitario(arroz(gallo),25.10).
precioUnitario(lacteo(laSerenisima,leche), 6.00).
precioUnitario(lacteo(laSerenisima,crema), 4.00).
precioUnitario(lacteo(gandara,queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima,12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).

%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).
descuento(arroz(Marca),1.5):-producto(arroz(Marca)).
descuento(salchichas(Marca, _),0.5) :- producto(salchichas(Marca,_)), Marca \= vienisima.
descuento(lacteo(Marca,leche), 2):- producto(lacteo(Marca,leche)).
descuento(lacteo(Marca,queso(Tipo)),2):- producto(lacteo(Marca, queso(Tipo))), primeraMarca(Marca).
descuento(Producto, Descuento):- mayorPrecioUnitario(Producto, Valor), Descuento is Valor * 0.05.

mayorPrecioUnitario(Producto, Valor):-
    precioUnitario(Producto, Valor),
    forall(precioUnitario(_, OtroValor), Valor >= OtroValor).

compradorCompulsivo(Persona):-
    persona(Persona),
    forall(compro(Persona,Producto,_), esPrimeraMarcaConDesc(Producto)).

esPrimeraMarcaConDesc(lacteo(Marca,_)):-
    primeraMarca(Marca).
esPrimeraMarcaConDesc(arroz(Marca)):-
    primeraMarca(Marca).
esPrimeraMarcaConDesc(salchicha(Marca,_)):-
    primeraMarca(Marca).

producto(Producto):- precioUnitario(Producto, _).
%compro(Cliente,Producto,Cantidad)
compro(juan,lacteo(laSerenisima,crema),2).
compro(juan,arroz(gallo),1).

persona(Persona):-compro(Persona,_,_).


% 3) Definir el predicado totalAPagar/2 que relaciona a un cliente con el total de su compra teniendo en cuenta que para cada producto comprado se debe considerar el precio con los descuentos que tenga.

totalAPagar(Cliente, Total):-
    persona(Cliente),
    producto(Producto),
    findall(PrecioFinalProd, comproDescontado(Cliente, Producto, PrecioFinalProd), PreciosFinalesProd),
    sumlist(PreciosFinalesProd, Total).
    
comproDescontado(Cliente, Producto, PrecioFinal):-
    compro(Cliente, Producto, _),
    aplicarDescuento(Producto, PrecioFinal).
    
aplicarDescuento(Producto, PrecioFinal):-
    descuentosProducto(Producto, SumaDescuentos),
    precioUnitario(Producto, Precio),
    PrecioFinal is Precio - SumaDescuentos.

descuentosProducto(Producto, SumaDescuentos):-
    producto(Producto),
    findall(Descuento, descuento(Producto, Descuento), Descuentos),
    sumlist(Descuentos, SumaDescuentos).
