//CONSULTAS

// Saber qué películas tienen funciones que para una sala determinada.

db.system.js.save({

   _id : "peliculasQueTienenFuncionesEn",

   value : function(nombre_sala) { 

    return db.getCollection('contenido').find({ "funciones.nombreSala": { $regex: ".*" + nombre_sala + ".*" }})

   }
});

//db.loadServerScripts(); 
//peliculasQueTienenFuncionesEn("Hoyts Dot")