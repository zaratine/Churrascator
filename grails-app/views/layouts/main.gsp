<!DOCTYPE html>
<html>
    <head>

        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:javascript library="jquery"/>
		<g:layoutHead />
        <g:javascript library="application" />
    </head>
    <body>

	<div id="header">
		<div id="headerContent">
			<div id="headerRight">
				<sec:ifLoggedIn>
					<sec:loggedInUserInfo field="username"/>
					<g:link controller='logout'>Sair</g:link>
				</sec:ifLoggedIn>
			</div>
		</div>
	</div>
	
	<div id="pageLayout">
		<!--h1>Meus Churrascos</h1>
		<div id="pageContainer"-->
			<g:layoutBody />
		<!--/div-->
	</div>
		
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
       
    </body>
</html>