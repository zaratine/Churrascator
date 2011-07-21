
<%@ page import="br.com.informant.churrasco.Churrasco" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'churrasco.label', default: 'Churrasco')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'churrasco.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="nome" title="${message(code: 'churrasco.nome.label', default: 'Nome')}" />
                        
                            <g:sortableColumn property="data" title="${message(code: 'churrasco.data.label', default: 'Data')}" />
                        
                            <th><g:message code="churrasco.criador.label" default="Criador" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${churrascoInstanceList}" status="i" var="churrascoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${churrascoInstance.id}">${fieldValue(bean: churrascoInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: churrascoInstance, field: "nome")}</td>
                        
                            <td><g:formatDate date="${churrascoInstance.data}" /></td>
                        
                            <td>${fieldValue(bean: churrascoInstance, field: "criador")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${churrascoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
