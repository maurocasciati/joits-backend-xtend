// Integrante 1: Saber qué amigos tienen mis amigos. 

MATCH (usuario:Usuario)-[:ES_AMIGO*2]-(amigoDeAmigo:Usuario) 
WHERE NOT (usuario)-[:ES_AMIGO]-(amigoDeAmigo:Usuario)
AND usuario <> amigoDeAmigo    
AND ID(usuario)=22
RETURN amigoDeAmigo

// Integrante 2: Saber que películas de un género determinado no vi y mis amigos vieron. 

MATCH (entradaUsuario:Entrada)-[:TIENE_ENTRADA]-(usuario: Usuario)
-[:ES_AMIGO]-(amigo:Usuario)-[:TIENE_ENTRADA]-(entradaAmigo:Entrada)
where ID(usuario)=22
// and entrada.genero = "Determinado" Agregar atributo género a entrada
with collect(entradaUsuario.tituloContenido) as titulosUsuario, entradaAmigo as entradaAmigo2
where not  entradaAmigo2.tituloContenido in titulosUsuario
RETURN distinct entradaAmigo2.tituloContenido


MATCH (entradaUsuario:Entrada)-[:TIENE_ENTRADA]-(usuario: Usuario)-[:ES_AMIGO]-
(amigo:Usuario)-[:TIENE_ENTRADA]-(entradaAmigo:Entrada)
	WHERE ID(usuario) = 22
    with collect(entradaAmigo.tituloContenido) as entradas,
	entradaUsuario as entradas_usuario
	where not entradas_usuario.tituloContenido in entradas
	RETURN entradas


// Integrante 3: Saber qué película es la más vista.

//mauro

MATCH (entradas:Entrada)
with count(entradas.tituloContenido) as poroto
WHERE entradas = max(entradas.tituloContenido) 
RETURN entradas.tituloContenido


//dini:

MATCH (peli:Entrada)
WITH peli.tituloContenido as titulo, count(*) as times
WITH collect({titulo:titulo, times:times}) as rows, max(times) as max
UNWIND [row in rows WHERE row.times = max] as row
RETURN row.titulo as titulo, row.times as times

//viotti:

MATCH (peli:Entrada)
WITH peli.tituloContenido as titulo, count(*) as times
WITH collect({titulo:titulo, times:times}) as rows, max(times) as max
UNWIND [row in rows WHERE row.times = max] as row
MATCH (peli:Entrada)
where peli.tituloContenido = row.titulo
RETURN peli
limit 1