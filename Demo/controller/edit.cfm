<!--Registration controller  -->
<cfif structKeyExists(form,"updateEmployee") and structKeyExists(session,'stLoggedInUser') and session.stLoggedInUser.role EQ "Admin">
	<cftry>
		<cfset rsDetails = application.employeeDao.editEmployee(#form#)/>
		<cfif rsDetails>
			<cflocation url="/Demo/view/adminDashboard.cfm?edit=success" addtoken="false">
		<cfelse>
			<cflocation url="/Demo/view/adminDashboard.cfm" addtoken="false">
		</cfif>
		<cfcatch type="database">
			<p>
				<strong>
				Apologies, a database error has occurred. Please try again later.
				</strong>
			</p>
			<cfdump var="#cfcatch#">
		</cfcatch>
	</cftry>
<cfelse>
	<cflocation url="/Demo/view/invalidtemplate.cfm"  addtoken="false">
</cfif>
