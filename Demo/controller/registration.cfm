<!--Registration controller  -->
<cfif structKeyExists(form,"addEmployee") and structKeyExists(session,'stLoggedInUser') and session.stLoggedInUser.role EQ "Admin">
	<cftry>
		<!--calling the addEmployee() to add employee   -->
		<cfset rsDetails = application.employeeDao.addEmployee(#form#)/>
		<cfset sentMail = application.employeeService.sendRegistrationMail(#form#)/>
		<cfif rsDetails>
			<cflocation url="/Demo/view/adminDashboard.cfm?registration=success" addtoken="false">
		<cfelse>
			<cflocation url="/Demo/view/adminDashboard.cfm"  addtoken="false">
		</cfif>
		<cfcatch type="any">
			<p>
				<strong>
					Apologies, an error has occurred. Please try again later.
				</strong>
			</p>
			<cfdump var="#cfcatch.message#">
		</cfcatch>
	</cftry>
<cfelse>
	<cflocation url="/Demo/view/invalidtemplate.cfm"  addtoken="false">
</cfif>
