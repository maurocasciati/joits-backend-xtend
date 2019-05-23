//CONSULTAS

// 1 - Saber qué películas tienen funciones que para una sala determinada.

db.system.js.save({

   _id : "peliculasQueTienenFuncionesEn",

   value : function(nombre_sala) { 

    return db.getCollection('contenido').find({ "funciones.nombreSala": { $regex: ".*" + nombre_sala + ".*" }})

   }
});

	//db.loadServerScripts(); 
	//peliculasQueTienenFuncionesEn("Hoyts Dot")

// 3 - Saber qué películas están disponibles para ver a partir de una determinada fecha.

db.system.js.save({

   _id : "peliculasConFechaFuncionAPartirDe",

   value : function(fecha_funcion) { 

    return db.getCollection('contenido').find({"funciones.fechaHora" : { $gte : new ISODate(fecha_funcion) }});

   }
});

	//db.loadServerScripts(); 
	//peliculasConFechaFuncionAPartirDe("2019-04-27")