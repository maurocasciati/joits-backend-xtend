package domain

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import application.JoitsBootstrap
import repositorios.RepoLocator

class TestUsuario {
	
	JoitsBootstrap bootstrap = new JoitsBootstrap()
	
	
	@Before
	def void initialize() {
	}
	
	@Test
	def seCreoElUsuarioCacho() {
		Assert.assertEquals(RepoLocator.repoUsuario.searchById(new Long(17)),bootstrap.cacho)
	}
}