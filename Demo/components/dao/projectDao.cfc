<!---Component for database operation with project table  --->
<cfcomponent>

	<!---Insert record into Project table  --->

	<cffunction name="addProject" access = "remote" returnType="boolean" returnformat="JSON">
		<cfset var  check = false>
		<cftry>
			<cfquery>
				INSERT INTO [dbOrganisation].[Employee].[Project]
				(
				 [Title],
				 [Descreption],
				 [TeamLeader]
				)
				VALUES
				(
				<cfqueryparam value="#form.project_title#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#form.project_descreption#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#form.team_leader_hidden#" cfsqltype="CF_SQL_INTEGER">
				)
			</cfquery>
			<cfset  check = true>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
			</cfcatch>
		</cftry>
		<cfreturn check/>
	</cffunction>

	<!---method for getting all project details  --->

	<cffunction name="getAllProject" returnType="query">
		<cfset rsDetails = "">
		<cftry>
			<cfquery name="rsDetails">
				SELECT p.ProjectID,p.Title,p.Descreption,(ISNULL(e.FirstName,'') +' '+ ISNULL(e.MiddleName,'') +' '+ ISNULL(e.LastName,'')) AS TeamLeader,p.ActiveStatus
				FROM [dbOrganisation].[Employee].[Project] AS p
				INNER JOIN [dbOrganisation].[Employee].[Employee] AS e
				ON p.TeamLeader=e.EmployeeID
				ORDER BY ProjectID DESC
			</cfquery>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
			</cfcatch>
			<cffinally>
				<cfreturn rsDetails/>
			</cffinally>
		</cftry>
	</cffunction>

	<!---deactivate project function --->

	<cffunction name="deactiveProject"  access = "remote" returnType="boolean" returnFormat="json">
		<cfargument name="projectId" type="string" required="true">
		<cfset var check = false>
		<cftry>
			<cfquery>
				UPDATE [dbOrganisation].[Employee].[Project]
				SET [ActiveStatus] = 0
				WHERE ProjectID= <cfqueryparam value="#arguments.projectId#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			<cfset  check = true>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
			</cfcatch>
			<cffinally>
				<cfreturn check/>
			</cffinally>
		</cftry>
	</cffunction>

	<!---method for getting details of a project   --->

	<cffunction name="getProjectById" access = "remote" returnType="query" returnFormat="json">
		<cfargument name="projectId" type="string" required="true">
		<cfset var rsDetails=""/>
		<cftry>
			<cfquery name="rsDetails">
				SELECT p.Title,p.Descreption,p.TeamLeader,(ISNULL(e.FirstName,'') +' '+ ISNULL(e.MiddleName,'') +' '+ ISNULL(e.LastName,'')) AS TeamLeaderName
				FROM [dbOrganisation].[Employee].[Project] AS p
				INNER JOIN [dbOrganisation].[Employee].[Employee] AS e
				ON p.TeamLeader=e.EmployeeID
				WHERE ProjectId= <cfqueryparam value="#arguments.projectId#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>

			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
			<cffinally>
				<cfreturn rsDetails/>
			</cffinally>
		</cftry>
	</cffunction>

	<!---update project details   --->

	<cffunction name="editProject"  access = "remote" returnType="boolean" returnformat="JSON">
		<cfset  check = false>
		<cftry>
			<cfquery>
				UPDATE [dbOrganisation].[Employee].[Project]
				SET
				[Title] = <cfqueryparam value="#form.edit_project_title#" cfsqltype="CF_SQL_VARCHAR">,
				[Descreption] = <cfqueryparam value="#form.edit_project_descreption#" cfsqltype="CF_SQL_VARCHAR">,
				[TeamLeader] = <cfqueryparam value="#form.edit_team_leader_hidden#" cfsqltype="CF_SQL_INTEGER">
				WHERE ProjectID= <cfqueryparam value="#form.edit_projectId#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			<cfset  check = true>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
			</cfcatch>
		</cftry>
		<cfreturn check/>
	</cffunction>



</cfcomponent>
