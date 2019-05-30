//CONSULTAS

// 1 - Saber qué películas tienen funciones que para una sala determinada.

db.system.js.save({

   _id: "peliculasQueTienenFuncionesEn",

   value: function (nombre_sala) {

      return db.getCollection('contenido').find({ "funciones.nombreSala": { $regex: ".*" + nombre_sala + ".*" } })

   }
});

//db.loadServerScripts(); 
//peliculasQueTienenFuncionesEn("Hoyts Dot")

// 2- Saber cuántas películas de un año determinado se reproducen en más de una sala. 

db.system.js.save({

   _id: "peliculasDeUnAñoEnMasDeUnaSala",

   value: function (anio) {

      const cantidad_peliculas = db.contenido.find({ $where: "this.funciones.length > 1", anioRodaje: anio }).count();

      return "Cantidad de películas de " + anio + " repoduciendose en más de una sala: " + cantidad_peliculas
   }

});

db.loadServerScripts(); 
peliculasDeUnAñoEnMasDeUnaSala(1999)


// 3 - Saber qué películas están disponibles para ver a partir de una determinada fecha.

db.system.js.save({

   _id: "peliculasConFechaFuncionAPartirDe",

   value: function (fecha_funcion) {

      return db.getCollection('contenido').find({ "funciones.fechaHora": { $gte: new ISODate(fecha_funcion) } });

   }
});

//db.loadServerScripts(); 
//peliculasConFechaFuncionAPartirDe("2019-04-27")