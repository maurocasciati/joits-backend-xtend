 154  mkdir sharding/
  155  cd sharding/
  156  mkdir cfg1 cfg2 shard1 shard2 repl1 repl2
  157  mongod --replSet rsConf --configsvr --port 28100 --logpath ~/sharding/log.cfg1 --logappend --dbpath ~/sharding/cfg1 --fork
  158  mongod --replSet rsConf --configsvr --port 28101 --logpath ~/sharding/log.cfg2 --logappend --dbpath ~/sharding/cfg2 --fork
  159  mongod --shardsvr --replSet shard1 --dbpath ~/sharding/shard1 --logpath ~/sharding/log.shard1 --port 29000 --fork --logappend --smallfiles --oplogSize 50
  160  mongod --shardsvr --replSet shard2 --dbpath ~/sharding/shard2 --logpath ~/sharding/log.shard2 --port 29100 --fork --logappend --smallfiles --oplogSize 50
  161  mongod --shardsvr --replSet shard1 --dbpath ~/sharding/repl1 --logpath ~/sharding/log.repl1 --port 29001 --fork --logappend --smallfiles --oplogSize 50
  162  mongod --shardsvr --replSet shard2 --dbpath ~/sharding/repl2 --logpath ~/sharding/log.repl2 --port 29101 --fork --logappend --smallfiles --oplogSize 50
  163  ps -fe | grep mongo
  164  mongo --port 28100
  165  mongo --port 29000
  166  mongo --port 29100
  167  mongos --configdb rsConf/127.0.0.1:28100,127.0.0.1:28101 --fork --logappend --logpath ~/sharding/shardlog --port 30000 --bind_ip 127.0.0.1
  168  mongo --port 30000
  169  mongo --port 29000
  170  mongo --port 29100


db.contenido.ensureIndex({"_id": "hashed"})

sh.enableSharding("tpJoits")

sh.shardCollection("tpJoits.contenido", {"_id": "hashed"}, false)

use config
db.chunks.find({},{min:1,max:1,shard:1,_id:0,ns:1}).pretty()

