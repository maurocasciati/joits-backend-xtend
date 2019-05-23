package repositorios

import domain.Carrito
import org.redisson.Redisson
import org.redisson.api.RBucket
import org.redisson.api.RedissonClient
import java.util.ArrayList

class RepoCarrito {
	var RedissonClient redisson
	static RepoCarrito instance = null

	private new() {
		redisson = Redisson.create();
	}

	static def getInstance() {
		if (instance === null) {
			instance = new RepoCarrito
		}
		instance
	}

	def guardarCarrito(String id_usuario, Carrito _carrito) {
		var carrito = new Carrito
		carrito.items = new ArrayList
		carrito.items.addAll(_carrito.items)
		var RBucket<Carrito> bucket = redisson.getBucket(id_usuario)
		bucket.set(carrito);
	}

	def getCarritoByUserId(String id_usuario) {
		var RBucket<Carrito> bucket = redisson.getBucket(id_usuario)
		var carrito = bucket.get
		if(carrito === null) carrito = new Carrito
		carrito
	}

	def limpiarCarrito(String id_usuario) {
		var RBucket<Carrito> bucket = redisson.getBucket(id_usuario)
		bucket.delete
	}
}
