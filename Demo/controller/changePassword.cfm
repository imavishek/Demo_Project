<!--Change password  controller  -->
<cfif structKeyExists(form,"changePassword") and structKeyExists(session,'stLoggedInUser')>
	<cftry>
		<!--calling the changePassword() -->
		<cfset rsDetails = application.employeeDao.changePassword(#form#)/>
		<cfif rsDetails>
			<cfif session.stLoggedInUser.role EQ "Admin">
				<cflocation url="/Demo/view/adminDashboard.cfm?changePassword=success" addtoken="false">
			<cfelse>
				<cflocation url="/Demo/view/employee.cfm?changePassword=success" addtoken="false">
			</cfif>
		<cfelse>
			<cflocation url="/Demo/view/login.cfm"  addtoken="false">
		</cfif>
		<cfcatch type="database">
			<p>
				<strong>
					Apologies, a database error has occurred. Please try again later.
				</strong>
			</p>
			<cfdump var="#cfcatch.message#">
		</cfcatch>
	</cftry>
<cfelse>
	<cflocation url="/Demo/view/invalidtemplate.cfm"  addtoken="false">
</cfif>
