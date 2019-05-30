const fs = require('fs');
const fetch = require("node-fetch");

// aca lo guarda, cambia la ruta por la que quieras
const fileDir = 'C:\\Users\\Mauro Casciati\\workspace\\interviews-projects\\ws-pruebas-javascripts\\eg-mural-dini\\pelisInsert.txt'
var logger = fs.createWriteStream(fileDir, {
    flags: 'a'
})

// Este for me da una lista de urls, porque hay que pedirle pagina por pagina, no te deja todas juntas
let listaUrls = []
for (i = 1; i < 10; i++) {
    listaUrls.push('https://api.themoviedb.org/3/discover/movie?api_key=9f0a800aa4d47567a4557226e7093c8a&language=es-AR&primary_release_date.gte=2019-01-01&page=' + i)
}

async function guardarArchivo() {
    // logger.write('db = db.getSisterDB("tpJoits");')
    logger.write('db.contenido.insert([')
    await setFile()
    logger.write('])')
}

async function setFile() {
    for (const url of listaUrls) {
        await guardarPelis(url)
    }
}

async function guardarPelis(url) {
    let res = await fetch(url)
    let json = await res.json()

    for (const peli of json.results) {
        logger.write('{'),
            // logger.write('"_id" : ObjectId("5cdca25f72639a11e128d938"')
        logger.write('"className" : "domain.Pelicula",')
        logger.write('"PRECIO_BASE" : 30.0,')
        logger.write('"anioRodaje" : ' + " NumberInt(" + peli.release_date.substring(0, 4) + ")" + ',')
        logger.write('"titulo" : "' + peli.title + '",')
        logger.write('"puntaje" : ' + peli.vote_average + ',')
        logger.write('"genero" : "Película",')
        logger.write('"apiID" : "' + peli.id + '",')
        logger.write('"funciones" : []')
        logger.write('},')
    }
}

guardarArchivo()