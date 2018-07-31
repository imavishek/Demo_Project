<!---Component for database operation with employee table  --->
<cfcomponent>

	<!---Insert record into Employee table  --->

	<cffunction name="addEmployee" returntype="boolean">
		<cfargument name="formData" type="struct" required="true">
		<cfset var check = false>
		<cftry>
			<cfquery>
				INSERT INTO [dbOrganisation].[Employee].[Employee]
				(
				 [FirstName],
				 [MiddleName],
				 [LastName],
				 [Gender],
				 [DateOfBirth],
				 [JobTitle],
				 [Department],
				 [Email],
				 [Username],
				 [UserType]
				)
				VALUES
				(
				<cfqueryparam value="#formData.first_name#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#formData.middle_name#" cfsqltype="CF_SQL_VARCHAR" null="#not len(formData.middle_name)#">,
				<cfqueryparam value="#formData.last_name#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#formData.gender#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#formData.date_of_birth#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#formData.job_title#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#formData.department#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#formData.email#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#formData.username#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#formData.userType#" cfsqltype="CF_SQL_VARCHAR">
				)
			</cfquery>
			<cfset  check = true>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
			<cffinally>
				<cfreturn check/>
			</cffinally>
		</cftry>
	</cffunction>

	<!---Checking of username existance  --->

	<cffunction name="checkAvailability" access = "remote" returnType="boolean" returnFormat="json">
		<cfargument name="username" type="string" required="true"/>
		<cfset var recordFound=false/>
		<cfset var record=""/>
		<cftry>
			<cfquery name="record">
				SELECT EmployeeID
				FROM [dbOrganisation].[Employee].[Employee]
				WHERE UserName = <cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR">
				AND ActiveStatus = 1
			</cfquery>
			<cfif #record.recordCount#>
				<cfset recordFound=false/>
			<cfelse>
				<cfset recordFound=true/>
			</cfif>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
			<cffinally>
				<cfreturn recordFound/>
			</cffinally>
		</cftry>
	</cffunction>

	<!---method for getting all employee details  --->

	<cffunction name="getAllEmployee" returnType="query">
		<cfset var rsDetails=""/>
		<cftry>
			<cfquery name="rsDetails">
				SELECT
				Emp.[EmployeeID],
				(ISNULL(Emp.FirstName,'') +' '+ ISNULL(Emp.MiddleName,'') +' '+ ISNULL(Emp.LastName,''))
				AS FullName,
				Emp.[Gender],
				Emp.[DateOfBirth],
				Emp.[JobTitle],
				Emp.[Department],
				Emp.[Email],
				Emp.[Username],
				Emp.[UserType],
				Emp.[ActiveStatus]
				FROM [dbOrganisation].[Employee].[Employee] AS Emp
				ORDER BY Emp.[EmployeeID] DESC
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

	<!---method for getting details of an employee   --->

	<cffunction name="getEmployeeById" access = "remote" returnType="array" returnFormat="json">
		<cfargument name="employeeId" type="string" required="true">
		<cfset var rsDetails=""/>
		<cfset var empArray = ArrayNew(1)>
		<cftry>
			<cfquery name="rsDetails">
				SELECT
				Emp.[FirstName],
				Emp.[MiddleName],
				Emp.[LastName],
				Emp.[Gender],
				Emp.[DateOfBirth],
				Emp.[JobTitle],
				Emp.[Department],
				Emp.[Email],
				Emp.[UserType]
				FROM [dbOrganisation].[Employee].[Employee] AS Emp
				WHERE EmployeeID= <cfqueryparam value="#arguments.employeeId#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			 <cfloop QUERY="rsDetails">
				<cfset ArrayAppend(empArray, FirstName )>
				<cfset ArrayAppend(empArray, MiddleName)>
				<cfset ArrayAppend(empArray, LastName)>
				<cfset ArrayAppend(empArray, Gender)>
				<cfset ArrayAppend(empArray, DateOfBirth)>
				<cfset ArrayAppend(empArray, JobTitle)>
				<cfset ArrayAppend(empArray, Department)>
				<cfset ArrayAppend(empArray, Email)>
				<cfset ArrayAppend(empArray, UserType)>
			</cfloop>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
			<cffinally>
				<cfreturn empArray/>
			</cffinally>
		</cftry>
	</cffunction>

	<!---method for getting details of an employee by username   --->

	<cffunction name="getEmployeeByUsername" access = "remote" returnType="query" returnFormat="json">
		<cfargument name="username" type="string" required="true">
		<cfset var rsDetails=""/>
		<cftry>
			<cfquery name="rsDetails">
				SELECT
				Emp.[EmployeeId],
				Emp.[UserName]
				FROM [dbOrganisation].[Employee].[Employee] AS Emp
				WHERE UserName LIKE '%#arguments.username#%' AND ActiveStatus = 1
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

	<!---update employee details   --->

	<cffunction name="editEmployee"  returnType="boolean">
		<cfargument name="formData" type="struct" required="true">
		<cfset var check = false>
		<cftry>
			<cfquery>
				UPDATE [dbOrganisation].[Employee].[Employee]
				SET
				[FirstName] = <cfqueryparam value="#formData.first_name#" cfsqltype="CF_SQL_VARCHAR">,
				[MiddleName] = <cfqueryparam value="#formData.middle_name#" cfsqltype="CF_SQL_VARCHAR" null="#not len(formData.middle_name)#">,
				[LastName] = <cfqueryparam value="#formData.last_name#" cfsqltype="CF_SQL_VARCHAR">,
				[Gender] = <cfqueryparam value="#formData.edit_gender#" cfsqltype="CF_SQL_VARCHAR">,
				[DateOfBirth] = <cfqueryparam value="#formData.date_of_birth#" cfsqltype="CF_SQL_DATE">,
				[JobTitle] = <cfqueryparam value="#formData.job_title#" cfsqltype="CF_SQL_VARCHAR">,
				[Department] = <cfqueryparam value="#formData.department#" cfsqltype="CF_SQL_VARCHAR">,
				[Email] = <cfqueryparam value="#formData.email#" cfsqltype="CF_SQL_VARCHAR">,
				[UserType] = <cfqueryparam value="#formData.userType#" cfsqltype="CF_SQL_VARCHAR">,
				[ModifiedDate] = DEFAULT
				WHERE EmployeeID= <cfqueryparam value="#formData.edit_employeeId#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			<cfset  check = true>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
			<cffinally>
				<cfreturn check/>
			</cffinally>
		</cftry>
	</cffunction>

	<!---deactivate employee function --->

	<cffunction name="deactiveEmployee"  access = "remote" returnType="boolean" returnFormat="json">
		<cfargument name="employeeId" type="string" required="true">
		<cfset var check = false>
		<cftry>
			<cfquery>
				UPDATE [dbOrganisation].[Employee].[Employee]
				SET [ActiveStatus] = 0,
				[ModifiedDate] = DEFAULT
				WHERE EmployeeID= <cfqueryparam value="#arguments.employeeId#" cfsqltype="CF_SQL_INTEGER">
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

	<!---change password function --->

	<cffunction name="changePassword" returntype="boolean">
		<cfargument name="formData" type="struct" required="true">
		<cfset var check = false>
		<cftry>
			<cfquery>
				UPDATE [dbOrganisation].[Employee].[Employee]
				SET
				Password = HASHBYTES('SHA1','#formData.newpassword#'),
				[ModifiedDate] = DEFAULT
				WHERE EmployeeID= <cfqueryparam value="#formData.change_password_employeeId#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			<cfset  check = true>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
			<cffinally>
				<cfreturn check/>
			</cffinally>
		</cftry>
	</cffunction>

	<!---forgot password function  --->

	<cffunction name="forgotPassword" access = "remote" returnType="boolean" returnFormat="json">
		<cfargument name="username_forgot_password" type="string" required="true"/>
		<cfset var record=""/>
		<cfset var check=false/>
		<cftry>
			<cfset new_password=application.employeeService.generateRandomPassword()>
			<cfquery name="record">
			 	SELECT Email
			 	FROM [dbOrganisation].[Employee].[Employee]
				WHERE UserName = <cfqueryparam value="#arguments.username_forgot_password#" cfsqltype="CF_SQL_VARCHAR">
			 </cfquery>
			<cfif #record.recordCount# >
				<cfquery name="">
			  			UPDATE  [dbOrganisation].[Employee].[Employee]
			  			SET Password =  HASHBYTES('SHA1','#new_password#'),
			  			[ModifiedDate] = DEFAULT
						WHERE UserName = <cfqueryparam value="#arguments.username_forgot_password#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
				<cfset employeeDetails=application.employeeService.sendForgotPasswordMail(record.Email,new_password)>
				<cfset  check=true/>
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
		<cfreturn check/>
	</cffunction>

	<!---add photo  function --->

	<cffunction name="addPhoto" returntype="boolean">
		<cfargument name="fileName" type="string" required="true">
		<cfset var check = false>
		<cftry>
			<cfquery>
				UPDATE [dbOrganisation].[Employee].[Employee]
				SET
				Photo = <cfqueryparam value="#arguments.fileName#" cfsqltype="CF_SQL_VARCHAR">,
				[ModifiedDate] = DEFAULT
				WHERE EmployeeID= <cfqueryparam value="#session.stLoggedInUser.employeeId#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			<cfset  check = true>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
			<cffinally>
				<cfreturn check/>
			</cffinally>
		</cftry>
	</cffunction>

	<!---method for getting employee photo  --->

	<cffunction name="getPhoto" returnType="string">
		<cfset var rsDetails=""/>
		<cfset var photo = "">
		<cftry>
			<cfset  id = session.stLoggedInUser.employeeId>
			<cfquery name="rsDetails">
				SELECT
				[Photo]
				FROM [dbOrganisation].[Employee].[Employee]
				WHERE EmployeeID= <cfqueryparam value="#id#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			<cfset photo = rsDetails.Photo>
			<cfcatch type="database">
				<p>
					<strong>
						Apologies, a database error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
			<cffinally>
				<cfreturn photo/>
			</cffinally>
		</cftry>
	</cffunction>


</cfcomponent>
