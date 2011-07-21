import grails.plugins.springsecurity.Secured
 
class ControlPanelController {
 
    @Secured(['ROLE_FACEBOOK']) 
    def index = { 
    }   
}