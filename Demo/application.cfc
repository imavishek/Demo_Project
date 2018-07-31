<!---Application Component  --->
<cfcomponent
	displayname="Application"
	output="true"
	hint="Handle the application.">

	<!--- Set up the applicatiosn. --->
	<cfset THIS.Name = "xxssxdaaxssddd" />
	<!---CreateTimeSpan days, hours, minutes, seconds --->

	<cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 2, 0, 0 ) />
	<cfset THIS.datasource = "dsOrganisation" />
	<cfset THIS.sessionmanagement = "yes" />
	<cfset THIS.clientmanagement = "yes" />
	<cfset THIS.sessiontimeout = CreateTimeSpan( 0, 6, 0, 0 ) />

	<!--- OnApplicationStart Method  --->

	<cffunction
		name="OnApplicationStart"
		returntype="boolean">
		<!---Creating Objects of components --->
		<cfset application.employeeService = createObject(
			"component",'Demo.components.service.employeeService')/>
		<cfset application.employeeDao = createObject(
			"component",'Demo.components.dao.employeeDao')/>
		<cfset application.loginDao = createObject(
			"component",'Demo.components.dao.loginDao')/>
		<cfset application.projectDao = createObject(
			"component",'Demo.components.dao.projectDao')/>
		<cfreturn true />
	</cffunction>

	<!---onError Method  --->

	<cffunction name="onError" returnType="void">
		<cfargument name="Exception" required=true/>
		<cfargument name="EventName" type="String" required=true/>
		<cflog  file="#This.Name#" type="error"
			text="Event Name: #Arguments.Eventname#" >
		<cflog file="#This.Name#" type="error"
			text="Message: #Arguments.Exception.message#">
		<!--- Display an error message if there is a page context.
		The onError method cannot display output to the user if the error occurs during an onApplicationEnd
		or onSessionEnd event method, because there is no available page context
		--->
		<cfif NOT (Arguments.EventName IS "onSessionEnd") OR
			(Arguments.EventName IS "onApplicationEnd")>
			<cfoutput>
				<h2>
					An unexpected error occurred.
				</h2>
				<p>
					Please provide the following information to technical support:
				</p>
				<p>
					Error Event: #Arguments.EventName#
				</p>
				<p>
					Error details:
					<br>
					<cfdump var=#Arguments.Exception#>
				</p>
			</cfoutput>
		</cfif>
	</cffunction>

	<!---onSessionEnd Method  --->

	<cffunction name="onSessionEnd" access="public" returntype="void">
		<!--- Define arguments. --->
		<cfargument name = "SessionScope" required=true/>
		<cfargument name = "ApplicationScope" required=true/>
		<cfset var sessionLength = TimeFormat(Now() - SessionScope.started, "H:mm:ss")>
		<!--- Log the session length. --->
		<cflog file="#This.Name#" type="Information"
			text="Session #Arguments.SessionScope.sessionid#  ended. Length: #sessionLength# Active sessions: #Arguments.ApplicationScope.sessions#">

		<cfreturn />
	</cffunction>

	<!---onApplicationEnd Method  --->

	<cffunction name="onApplicationEnd" access="public"returntype="void">
		<!--- Define arguments. --->
		<cfargument name = "ApplicationScope" required=true/>
		<!--- Log the application length. --->
		<cflog file="#This.Name#" type="Information"
			text="Application #Arguments.ApplicationScope.applicationname# Ended" >
		<cfreturn />
	</cffunction>

	<!---onRequest Method  --->
	<!---
 <cffunction name="onRequest" returnType="boolean">
		<cfargument name="targetPage" type="String" required=true/>
		<cfset Local.targetPage = arguments.targetPage>
		<cfset Local.ajaxCall = 0>
		<cfif structKeyExists(GetHttpRequestData().headers , "X-Requested-With") and
		getHttpRequestData().headers["X-Requested-With"] EQ "XMLHttpRequest">

<cfelse>
	<cfif findNoCase( "index.cfm", Local.targetPage )>
		<cfif structKeyExists(session,'stLoggedInUser')>
			<cfif session.stLoggedInUser.role EQ "Admin">
				<cflocation url="adminDashboard.cfm" addtoken="false">
			<cfelse>
				<cflocation url="employee.cfm" >
			</cfif>
			<cfreturn true>
		</cfif>
	<cfelse>
		<cfif  NOT structKeyExists(session,'stLoggedInUser')>
			<cflocation url="index.cfm" addtoken="false" >
			<cfreturn false>
		<cfelse>
			<cfif session.stLoggedInUser.role EQ "Admin">
				<cfif NOT findNoCase( "admin", Local.targetPage )>
					<cfinclude  template="/Demo/view/invalidtemplate.cfm">
					<cfreturn false>
				</cfif>
			<cfelse>
				<cfif NOT findNoCase( "employee", Local.targetPage )>
					<cfinclude  template="/Demo/view/invalidtemplate.cfm">
					<cfreturn false>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
	</cfif>
	<cfreturn true>
	</cffunction>
 --->

</cfcomponent>
