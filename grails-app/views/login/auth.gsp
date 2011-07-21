<head>
<!--meta name='layout' content='main' /-->
<link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
<title>Login</title>
<style type="text/css" media="screen">
	h1 {
		margin-bottom: 10px;
	}
	
	h2 {
		margin: 15px;
	}
</style>
</head>

<body>
		<fbg:resources/>
		
		<script type="text/javascript">
			function facebookLogin() {
				FB.getLoginStatus(function(response) {
			    	if (response.session) {
			        	window.location ="${createLink(controller:'login', action:'facebookLogin')}";
					}
				});
			}
			
			/*FB.getLoginStatus(function(response) {
		    	if (response.session) {
		        	window.location ="${createLink(controller:'login', action:'facebookLogin')}";
				}
			});*/
			
		</script>
		
		<div id="landing">
			<h1><img src="${resource(dir:'images',file:'l.png')}" alt="Churrascator"></img></h1>
			<img src="${resource(dir:'images',file:'d.png')}"/>
			<h2>Seu churrasco organizado <em>the easy way</em></h2>
			<span>Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
			In sed ipsum sem. Mauris tincidunt lorem eget erat porta tempus. 
			Fusce orci nibh, ullamcorper in bibendum fringilla, placerat a tortor. 
			Phasellus aliquam sem at enim facilisis fringilla.
			</span>
			<div class="fb">
				<fb:login-button perms="email,publish_stream" onlogin="facebookLogin();" size="large">
					<g:message code="Login com Facebook"/>
					</fb:login-button>
			</div>
			<!--img class="fb" src="${resource(dir:'images',file:'f.png')}" onclick="FB.login()"/-->
		</div>
</body>
