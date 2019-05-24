#/bin/bash

#OJO QUE BORRA ~/sharding!
echo "borrando ~/sharding si existe"
rm -rf ~/sharding

echo "yendo al home ~"
cd

echo "creando carpeta sharding/"
mkdir sharding/

echo "ingresando a sharding/"
cd sharding/

echo "creando carpetas para shards, replicas y cfg"
mkdir cfg1 cfg2 shard1 shard2 repl1 repl2

echo "creando servers de cfg en puertos 28000 y 28001"
mongod --replSet rsConf --configsvr --port 28000 --logpath ~/sharding/log.cfg1 --logappend --dbpath ~/sharding/cfg1 --fork
mongod --replSet rsConf --configsvr --port 28001 --logpath ~/sharding/log.cfg2 --logappend --dbpath ~/sharding/cfg2 --fork

echo "creando shards PRIMARY en 29001 y 29002 y replicas en 29101 y 29102"
mongod --shardsvr --replSet shard1 --dbpath ~/sharding/shard1 --logpath ~/sharding/log.shard1 --port 29001 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet shard2 --dbpath ~/sharding/shard2 --logpath ~/sharding/log.shard2 --port 29002 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet shard1 --dbpath ~/sharding/repl1 --logpath ~/sharding/log.repl1 --port 29101 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet shard2 --dbpath ~/sharding/repl2 --logpath ~/sharding/log.repl2 --port 29102 --fork --logappend --smallfiles --oplogSize 50

echo "mostrando los procesos corriendo"
ps -fe | grep mongod

echo "configurando los config server"
mongo --port 28000 --eval "cfg={_id:'rsConf',members:[{_id:0 ,host: '127.0.0.1:28000'}, {_id: 1, host: '127.0.0.1:28001' }]};rs.initiate(cfg)"

echo "durmiendo 5 segundos"
sleep 5

echo "configurando shard en 29001 y su replica 29101"
mongo --port 29001 --eval "cfg={_id:'shard1', members:[{_id:0 ,host: '127.0.0.1:29001'}, {_id:1 ,host: '127.0.0.1:29101' }]};rs.initiate(cfg)"
echo "durmiendo 15s antes de ver el status"
sleep 15
mongo --port 29001 --eval "rs.status()"

mongo --port 29002 --eval "cfg={_id:'shard2', members:[{_id:0 ,host: '127.0.0.1:29002'}, {_id:1 ,host: '127.0.0.1:29102' }]};rs.initiate(cfg)"
echo "durmiendo 15s antes de ver el status"
sleep 15
mongo --port 29002 --eval "rs.status()"


echo "levantando servicios de ruteo en puerto 30000"
mongos --configdb rsConf/127.0.0.1:28000,127.0.0.1:28001 --fork --logappend --logpath ~/sharding/shardlog --port 30000 --bind_ip 127.0.0.1

echo "levantando los shards desde el router"
mongo --port 30000 --eval "sh.addShard('shard1/127.0.0.1:29001');sh.addShard('shard2/127.0.0.1:29002')"

echo "mostrando como quedó todo con db.adminCommand({listShards:1})"
mongo --port 30000 --eval "db.adminCommand( { listShards: 1 } )"


# definiendo shard key hashed
# db.contenido.ensureIndex({"_id": "hashed"})

# sh.enableSharding("tpJoits")

# sh.shardCollection("tpJoits.contenido", {"_id": "hashed"}, false)

# use config
# db.chunks.find({},{min:1,max:1,shard:1,_id:0,ns:1}).pretty()

