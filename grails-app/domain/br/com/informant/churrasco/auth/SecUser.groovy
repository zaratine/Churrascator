package br.com.informant.churrasco.auth

import br.com.informant.churrasco.Churrasco

class SecUser {

	String username
	String name
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	String facebookId
	

	static constraints = {
		username blank: false, unique: true
		name nullable: true
		password blank: false
		facebookId blank: false, unique: true
	}

	static mapping = {
		password column: '`password`'
	}
	
	static hasMany = [ meusChurrascos : Churrasco , churrascos : Churrasco]
	static belongsTo = Churrasco

	Set<SecRole> getAuthorities() {
		SecUserSecRole.findAllBySecUser(this).collect { it.secRole } as Set
	}
}
