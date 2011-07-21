package br.com.informant.churrasco

import br.com.informant.churrasco.auth.SecUser
import br.com.informant.churrasco.auth.SecUserSecRole
import br.com.informant.churrasco.auth.SecRole
import grails.plugins.springsecurity.Secured
import grails.converters.JSON

@Secured(['ROLE_FACEBOOK']) 
class ChurrascoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def facebookGraphService
	
	def springSecurityService
    
	def index = {
        redirect(action: "list", params: params)
    }


    def list = {
		println SecUser.list().size()
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [churrascoInstanceList: Churrasco.list(params), churrascoInstanceTotal: Churrasco.count()]
    }

	def findFriends = {
		println params.q
		
		def friends = facebookGraphService.getFriends()
		
		def myInfo = JSON.parse (friends.toString() )
		def teste = []
		for(f in myInfo.data){
			if(f.name.indexOf(params.q) != -1){
				teste.add(f);
			}
		}
		println teste.toString()
		render teste as JSON
	}

    def create = {
        def churrascoInstance = new Churrasco()
        churrascoInstance.properties = params
        return [churrascoInstance: churrascoInstance, friends: facebookGraphService.getFriends()]
    }

    def save = {
		
		def participantes_string = ""
		def es=params.entrySet()
		es.each{
			println it.key
			if(it.key.contains("as_values")){
				participantes_string = it.value
			}
		}
		
	/*	def pp = [id:"652722792", message:"oi teste"];
		facebookGraphService.publishWall(pp);		*/

		for(facebookId in participantes_string.tokenize(",")){
			def par = [id:facebookId]
			def name = facebookGraphService.getDetails(par).name
			def user = SecUser.findByFacebookId(facebookId)?: new SecUser(
					username: facebookId,
					password: springSecurityService.encodePassword(facebookId),
     				enabled: true,
					name: name,
					facebookId: facebookId).save(failOnError: true)

			def role = SecRole.findByAuthority('ROLE_FACEBOOK')?: new SecRole(
					authority:'ROLE_FACEBOOK').save(failOnError: true)

			if (! user.authorities.contains(role)) {
				SecUserSecRole.create user, role
			}
		}
		
		
		params.criador = springSecurityService.currentUser
		
        def churrascoInstance = new Churrasco(params)
        if (churrascoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'churrasco.label', default: 'Churrasco'), churrascoInstance.id])}"
            redirect(action: "show", id: churrascoInstance.id)
        }
        else {
            render(view: "create", model: [churrascoInstance: churrascoInstance])
        }
    }

    def show = {
        def churrascoInstance = Churrasco.get(params.id)
        if (!churrascoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'churrasco.label', default: 'Churrasco'), params.id])}"
            redirect(action: "list")
        }
        else {
            [churrascoInstance: churrascoInstance]
        }
    }

    def edit = {
        def churrascoInstance = Churrasco.get(params.id)
        if (!churrascoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'churrasco.label', default: 'Churrasco'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [churrascoInstance: churrascoInstance]
        }
    }

    def update = {
        def churrascoInstance = Churrasco.get(params.id)
        if (churrascoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (churrascoInstance.version > version) {
                    
                    churrascoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'churrasco.label', default: 'Churrasco')] as Object[], "Another user has updated this Churrasco while you were editing")
                    render(view: "edit", model: [churrascoInstance: churrascoInstance])
                    return
                }
            }
            churrascoInstance.properties = params
            if (!churrascoInstance.hasErrors() && churrascoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'churrasco.label', default: 'Churrasco'), churrascoInstance.id])}"
                redirect(action: "show", id: churrascoInstance.id)
            }
            else {
                render(view: "edit", model: [churrascoInstance: churrascoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'churrasco.label', default: 'Churrasco'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def churrascoInstance = Churrasco.get(params.id)
        if (churrascoInstance) {
            try {
                churrascoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'churrasco.label', default: 'Churrasco'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'churrasco.label', default: 'Churrasco'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'churrasco.label', default: 'Churrasco'), params.id])}"
            redirect(action: "list")
        }
    }
}
