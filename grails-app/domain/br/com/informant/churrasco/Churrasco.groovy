package br.com.informant.churrasco

import br.com.informant.churrasco.auth.SecUser

class Churrasco {

    static constraints = {
		nome()
		data(min:new Date())
		criador()
    }

	static hasMany = [ participantes : SecUser ]

	String nome;
	Date data;
	SecUser criador;
	
	
}
