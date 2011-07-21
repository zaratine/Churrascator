

<%@ page import="br.com.informant.churrasco.Churrasco" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'churrasco.label', default: 'Churrasco')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${churrascoInstance}">
            <div class="errors">
                <g:renderErrors bean="${churrascoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${churrascoInstance?.id}" />
                <g:hiddenField name="version" value="${churrascoInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nome"><g:message code="churrasco.nome.label" default="Nome" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churrascoInstance, field: 'nome', 'errors')}">
                                    <g:textField name="nome" value="${churrascoInstance?.nome}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="data"><g:message code="churrasco.data.label" default="Data" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churrascoInstance, field: 'data', 'errors')}">
                                    <g:datePicker name="data" precision="day" value="${churrascoInstance?.data}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="criador"><g:message code="churrasco.criador.label" default="Criador" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churrascoInstance, field: 'criador', 'errors')}">
                                    <g:select name="criador.id" from="${br.com.informant.churrasco.auth.SecUser.list()}" optionKey="id" value="${churrascoInstance?.criador?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="participantes"><g:message code="churrasco.participantes.label" default="Participantes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churrascoInstance, field: 'participantes', 'errors')}">
                                    <g:select name="participantes" from="${br.com.informant.churrasco.auth.SecUser.list()}" multiple="yes" optionKey="id" size="5" value="${churrascoInstance?.participantes*.id}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
