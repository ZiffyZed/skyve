<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.security.Principal"%>
<%@ page import="java.util.Locale"%>
<%@ page import="org.apache.commons.codec.binary.Base64"%>

<%@ page import="org.skyve.impl.web.UserAgent"%>
<%@ page import="org.skyve.impl.web.WebUtil"%>
<%@ page import="org.skyve.metadata.user.User"%>
<%@ page import="org.skyve.util.Util"%>
<%@ page import="org.skyve.web.WebContext"%>
<%
	final String oldPasswordFieldName = "oldPassword";
	final String newPasswordFieldName = "newPassword";
	final String confirmPasswordFieldName = "confirmPassword";
	
	User user = null;
	
	Principal p = request.getUserPrincipal();
	if (p == null) { // not logged in
		response.sendRedirect(response.encodeRedirectURL(Util.getHomeUrl() + "home.jsp"));
		return;
	}
	else {
		// Get the user
		user = (User) request.getSession().getAttribute(WebContext.USER_SESSION_ATTRIBUTE_NAME);
		if (user == null) { // if the user is not established yet (but we've logged in...)
			response.sendRedirect(response.encodeRedirectURL(Util.getHomeUrl() + "home.jsp"));
			return;
		}
	}

	// This is a postback, process it and move on
	String passwordChangeErrorMessage = null;
	String oldPasswordValue = request.getParameter(oldPasswordFieldName);
	String newPasswordValue = request.getParameter(newPasswordFieldName);
	String confirmPasswordValue = request.getParameter(confirmPasswordFieldName);
	if ((oldPasswordValue != null) && (newPasswordValue != null) && (confirmPasswordValue != null)) {
		passwordChangeErrorMessage = WebUtil.makePasswordChange(user, oldPasswordValue, newPasswordValue, confirmPasswordValue);
		if (passwordChangeErrorMessage == null) {
			request.getSession().setAttribute(WebContext.USER_SESSION_ATTRIBUTE_NAME, user);
			response.sendRedirect(response.encodeRedirectURL(Util.getHomeUrl() + "home.jsp"));
			return;
		}
	}
	
	String basePath = Util.getSkyveContextUrl() + "/";
	boolean mobile = UserAgent.getType(request).isMobile();
	Locale locale = user.getLocale();
%>
<!DOCTYPE html>
<html dir="<%=Util.isRTL(locale) ? "rtl" : "ltr"%>">
	<head>
		<!-- Standard Meta -->
	    <meta charset="utf-8" />
	    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta http-equiv="refresh" content="300; url=<%=basePath%>loggedOut" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="private,no-cache,no-store" />
		<meta http-equiv="expires" content="0" />
	    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
	    
	    <!-- Site Properties -->
		<title><%=Util.i18n("page.resetPassword.title", locale)%></title>
		<base href="<%=basePath%>" />
		
		<% if (mobile) { %>
			<meta name="format-detection" content="telephone=no" />
			<meta name="format-detection" content="email=no">
		<% } %>
		
		<link rel="icon" type="image/png" href="images/window/skyve_fav.png" />
		<link rel="apple-touch-icon" href="images/window/skyve_fav.png">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.3/semantic.min.css">
		
		<style type="text/css">
			body {
				background-color: #eee;
			}
			body > .grid {
				height: 100%;
				/* background: url('/img/bg-image-login.jpg') no-repeat; */
			    background-size: cover;
			    background-position: center;
			    margin-top: 0px !important;
			}
			.image {
				margin-top: -100px;
			}
			.column {
				max-width: 450px;
			}
			.ui.white.header {
				color: white !important;
			}
			.footer {
			    color: white;
			    font-size: 80%;
			    margin-top: -20px;
			    margin-right: 10px;
			    text-align: right;
		    }
		    .footer a {
		    	color: #cdcdcd;
		    }
		</style>

		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.slim.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.3/components/form.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.3/components/transition.min.js"></script>

		<script type="text/javascript">
			<!--
			function testMandatoryFields(form) {
				if($('.ui.form').form('is valid')) {
					return true;
				}
				
				return false;
			}
			
			$(document)
			.ready(function() {
			    $('.ui.form')
			    .form({
			        fields: {
			        	<%=oldPasswordFieldName%>: {
			        		identifier: '<%=oldPasswordFieldName%>',
			        		rules: [
			        			{
			        				type: 'empty',
			        				prompt: '<%=Util.i18n("page.changePassword.oldPassword.error.required", locale)%>'
			        			}
			        		]
			        	},
			        	<%=newPasswordFieldName%>: {
			        		identifier: '<%=newPasswordFieldName%>',
			        		rules: [
			        			{
			        				type: 'empty',
			        				prompt: '<%=Util.i18n("page.changePassword.newPassword.error.required", locale)%>'
			        			}
			        		]
			        	},
			        	<%=confirmPasswordFieldName%>: {
			        		identifier: '<%=confirmPasswordFieldName%>',
			        		rules: [
			        			{
			        				type: 'empty',
			        				prompt: '<%=Util.i18n("page.changePassword.confirmPassword.error.required", locale)%>'
			        			},
			        			{
			        				type: 'match[<%=newPasswordFieldName%>]',
			        				prompt: '<%=Util.i18n("page.changePassword.noPasswordMatch.error.required", locale)%>'
			        			}
			        		]
			        	}
			        }
			    });
			});
			-->
		</script>
	</head>
	<% if (passwordChangeErrorMessage != null) { %>
	<body onload="document.forms['changeForm'].elements['<%=oldPasswordFieldName%>'].focus();alert('<%=passwordChangeErrorMessage%>');">
	<% } else { %>
	<body onload="document.forms['changeForm'].elements['<%=oldPasswordFieldName%>'].focus()">
	<% } %>
		
		<div class="ui middle aligned center aligned grid">
		    <div class="column">
		    	<%@include file="fragments/logo.html" %>
		    	<%@include file="fragments/noscript.html" %>
		    	
		    	<form name="changeForm" method="post" onsubmit="return testMandatoryFields(this)" class="ui large form">
		    		<div class="ui segment">
			    		<div class="ui header">
			    			<%=Util.i18n("page.changePassword.message", locale)%>
			    		</div>
			    		<div class="field">
		                    <div class="ui left icon input">
		                        <i class="unlock icon"></i>
		                        <input type="password" name="<%=oldPasswordFieldName%>" spellcheck="false" autocapitalize="none" autocomplete="off" autocorrect="none" placeholder="<%=Util.i18n("page.changePassword.oldPassword.label", locale)%>">
		                    </div>
		                </div>
		    			<div class="field">
		                    <div class="ui left icon input">
		                        <i class="lock icon"></i>
		                        <input type="password" name="<%=newPasswordFieldName%>" spellcheck="false" autocapitalize="none" autocomplete="off" autocorrect="none" placeholder="<%=Util.i18n("page.changePassword.newPassword.label", locale)%>">
		                    </div>
		                </div>
		                <div class="field">
		                    <div class="ui left icon input">
		                        <i class="lock icon"></i>
		                        <input type="password" name="<%=confirmPasswordFieldName%>" spellcheck="false" autocapitalize="none" autocomplete="off" autocorrect="none" placeholder="<%=Util.i18n("page.changePassword.confirmPassword.label", locale)%>">
		                    </div>
		                </div>
	                	<input type="submit" value="<%=Util.i18n("page.changePassword.submit.label", locale)%>" class="ui fluid large blue submit button" />
	                </div>
	                
	                <div class="ui error message">
		            	<%-- javascript form validation is inserted here --%> 
		            </div>
				</form>
		    </div>
		</div>
	</body>
</html>
