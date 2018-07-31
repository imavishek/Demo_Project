<!--changePhoto controller  -->
<cfif structKeyExists(form,"changePhoto") and structKeyExists(session,'stLoggedInUser')>
	<cftry>
		<cfset fileName = session.stLoggedInUser.userName &"-" & session.stLoggedInUser.employeeId>
		<cfset photosDirectory = (getDirectoryFromPath( getCurrentTemplatePath() ) &"../profilePhoto/#fileName#.jpg") />
		<cffile action="upload" filefield="photo" destination="#photosDirectory#" nameConflict="overwrite" />
		<cfset result = application.employeeDao.addPhoto(#fileName#)/>
		<cfif result>
			<cfif session.stLoggedInUser.role EQ "Admin">
				<cflocation url="/Demo/view/adminDashboard.cfm?addPhoto=success" addtoken="false">
			<cfelse>
				<cflocation url="/Demo/view/employee.cfm?addPhoto=success" addtoken="false">
			</cfif>

		<cfelse>
			<cfif session.stLoggedInUser.role EQ "Admin">
				<cflocation url="/Demo/view/adminDashboard.cfm?addPhoto=unsuccess"  addtoken="false">
			<cfelse>
				<cflocation url="/Demo/view/employee.cfm?addPhoto=unsuccess"  addtoken="false">
			</cfif>

		</cfif>
		<cfcatch type="any">
			<p>
				<strong>
					Apologies, an error has occurred. Please try again later.
				</strong>
			</p>
			<cfdump var="#cfcatch#">
		</cfcatch>
	</cftry>
<cfelse>
	<cflocation url="/Demo/view/invalidtemplate.cfm"  addtoken="false">
</cfif>
