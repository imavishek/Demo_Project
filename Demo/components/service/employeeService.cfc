<!--component for email service -->
<cfcomponent accessors="true" output="false" persistent="false">

	<!--- Generate EmployeeID --->
	<!---

		<cffunction name="generateEmployeeID" returntype="string">
		<cfargument name="lastEmployeeId" type="string" required="true">
		<cfset var employeeID=  ''/>
		<cftry>
		<cfset getArray = listToArray(arguments.lastEmployeeId,"-")/>
		<cfset number = LSParseNumber(getArray[2]) +1>
		<cfset id = numberFormat(number,"0000")>
		<cfset employeeID = "mfsi-" & id  />
		<cfcatch type="any">
		<p><strong>Apologies, EmployeeId generation error has occurred.
		Please try again later.<strong><p>
		</cfcatch>
		<cffinally>
		<cfreturn employeeID/>
		</cffinally>
		</cftry>
		</cffunction>

		--->
	<!---send mail to registered employee  --->

	<cffunction name="sendRegistrationMail">
		<cfargument name="formData" type="struct" required="true">
		<cftry>
			<cfmail from="avishek060796@gmail.com" to="#arguments.formData.email#" subject="Welcome To Mindfire" type="html">
			   <p>Hello <b>#form.first_name#</b>,</p>
			   <p>Welcome to <b>MindfireSolutions</b>
			   <p>Your UserName: <b>#form.username#</b></p>
			   <p>Password:</h6> <b>1@Mindfire</b></p>
				<br>

			   <p>Thanks</p>
			   <p>HR Team,</p>
			   <p><a href="http://www.mindfiresolutions.com/">MindfireSolutions</a></p>
			</cfmail>
			<cfcatch type="any">
				<p>
					<strong>
						Apologies, an error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
		</cftry>
	</cffunction>

	<!---generate random password  --->
	<cffunction name="generateRandomPassword" returntype="string">

		<cftry>
			<cfset strLowerCaseAlpha = "abcdefghijklmnopqrstuvwxyz" />
			<cfset strUpperCaseAlpha = UCase( strLowerCaseAlpha ) />
			<cfset strNumbers = "0123456789" />
			<cfset strOtherChars = "~!@##$%^&*" />
			<cfset strAllValidChars = (strLowerCaseAlpha & strUpperCaseAlpha & strNumbers & strOtherChars) />
			<cfset arrPassword = ArrayNew( 1 ) />
			<cfset arrPassword[ 1 ] = Mid(strNumbers,RandRange( 1, Len( strNumbers ) ),1) />
			<cfset arrPassword[ 2 ] = Mid(strLowerCaseAlpha,RandRange( 1, Len( strLowerCaseAlpha ) ),1) />
			<cfset arrPassword[ 3 ] = Mid(strUpperCaseAlpha,RandRange( 1, Len( strUpperCaseAlpha ) ),1) />
			<cfset arrPassword[ 4 ] = Mid(strOtherChars,RandRange( 1, Len( strOtherChars ) ),1) />
			<cfloop index="intChar" from="#(ArrayLen( arrPassword ) + 1)#" to="8" step="1">
				<cfset arrPassword[ intChar ] = Mid(strAllValidChars,RandRange( 1, Len( strAllValidChars ) ),1) />
			</cfloop>
			<cfset CreateObject( "java", "java.util.Collections" ).Shuffle(arrPassword) />
			<cfset strPassword = ArrayToList(arrPassword,"") />
			<cfcatch type="any">
				<p>
					<strong>
						Apologies, an error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
		</cftry>
		<cfreturn strPassword/>
	</cffunction>

	<!---forgotPassword Mail  --->

	<cffunction name="sendForgotPasswordMail">
		<cfargument name="email" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cftry>
			<cfmail from="avishek060796@gmail.com" to="#arguments.email#" subject="Forgot Password" type="html">
			   <p>Hello,</p>

			   <p>Your Password is: <b>#arguments.password#</b></p>
				<br>

			   <p>Thanks</p>
			   <p>HR Team,</p>
			   <p><a href="http://www.mindfiresolutions.com/">MindfireSolutions</a></p>
			</cfmail>
			<cfcatch type="any">
				<p>
					<strong>
						Apologies, an error has occurred. Please try again later.
					</strong>
				</p>
				<cfdump var="#cfcatch.message#">
			</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>
