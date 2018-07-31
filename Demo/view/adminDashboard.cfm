<!--- Admindashboard page --->

<cfif structKeyExists(session,'stLoggedInUser') and session.stLoggedInUser.role EQ "Admin">
	<html>
		<head>
			<title>
				Dashboard
			</title>
			<link rel="icon" href="../images/tittleicon.jpg">
			<meta charset="UTF-8">
			<meta name="description" content="">
			<meta name="keywords"
				content="">
			<meta name="author" content="Avishek Das">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">


			<link rel="stylesheet" href="../css/adminDashboard.css">
			<link rel="stylesheet"
				href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
			<link rel="stylesheet"
				href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
			<link rel="stylesheet"
				href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css">
			<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
				rel="stylesheet">
			<link
				href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
				rel="stylesheet">
			<link href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"
				rel="stylesheet">

			
		</head>
		<body>
			<nav class="navbar navbar-inverse">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#myNavbar">
						<span class="icon-bar">
						</span>
						<span class="icon-bar">
						</span>
						<span
							class="icon-bar">
						</span>
					</button>
					<a class="navbar-brand" href="login.cfm">
						Mindfire Solutions
					</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" style="cursor: pointer;">Activity</a>
							<ul class="dropdown-menu">
								<li><a id="regdBtn" style="cursor: pointer;">Add Employee</a></li>
								<li><a id="projBtn" style="cursor: pointer;">Add Project</a></li>
							</ul>
						</li>
						
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" style="cursor: pointer;">Details</a>
							<ul class="dropdown-menu">
								<li><a id="employee" style="cursor: pointer;" class="change-item" data-item="1">Employee</a></li>
								<li><a id="project" style="cursor: pointer;" class="change-item" data-item="2">Project </a></li>
							</ul>
						</li>

						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" style="cursor: pointer;">
							
							<cfset fileName = application.employeeDao.getPhoto()>
							<cfif fileName EQ "">
								<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" style="max-width:40px; margin-top: -7px;" class=" avatar img-circle img-thumbnail" alt="noPic">
							<cfelse>
								<img src="../profilePhoto/<cfoutput>#fileName#</cfoutput>.jpg"
							style="max-width:40px; margin-top: -7px;" class=" avatar img-circle img-thumbnail" alt="<cfoutput>#session.stLoggedInUser.userName#</cfoutput>">
							</cfif>
							
							
							<cfoutput>#session.stLoggedInUser.userName#</cfoutput><span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a id="photoChange" style="cursor: pointer;">Change Photo</a></li>
								<li><a id="passwordChange" style="cursor: pointer;">Change password</a></li>
								<li><a id="logout" style="cursor: pointer;">Logout</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</nav>


			<div class="" style="margin: 10px">

				<!---Showing All Employee in a table  --->
				<cfset employeeDetails=application.employeeDao.getAllEmployee()>
				<div class="table-responsive item-1 content-item" id="employeeTableDiv">
			  	 	<table class=" table stripe hover nowrap tableWidth compact cell-border" cellspacing="0" id="employeeTable">
						 <caption>Employee Datails</caption>
			  	 		<thead class="thead-dark">
							<tr class="table-info info">
								
								
								<th>Emp Id</th>
								<th>Name</th>
								<th>Gender</th>
								<th>DOB</th>
								<th>JobTitle</th>
								<th>Dept.</th>
								<th>Email</th>
								<th>Username</th>
								<th>UserType</th>
								<th>Active</th>
								<th>
									<a class="btn btn-sm btn-info" ><span class="glyphicon glyphicon-trash">Deactive</span></a>
									<a class="btn btn-sm btn-info "><span class="glyphicon glyphicon-pencil">Edit</span></a>
								</th>
							</tr>
						</thead>

						<tbody>
							<cfoutput query="employeeDetails">

								<cfif ActiveStatus EQ 1>
									<tr class="success">
								<cfelse>
									<tr class="danger">
								</cfif>
									<td>#EmployeeID#</td>
									<td>#FullName#</td>
									<td>#Gender#</td>
									<td>#dateFormat(DateOfBirth,"dd-mm-yyyy")#</td>
									<td>#JobTitle#</td>
									<td>#Department#</td>
									<td>#Email#</td>
									<td>#Username#</td>
									<td>#UserType#</td>
									<cfif ActiveStatus EQ 1>
										<td><p class="">Yes</p></td>
										<td><a class="btn btn-sm btn-danger" onClick="deactivateEmployee(#EmployeeID#);"><span class="glyphicon glyphicon-trash">Deactive</span></a>
											<a class="btn btn-sm btn-warning" onClick="editEmployee(#EmployeeID#);" ><span class="glyphicon glyphicon-pencil">Edit</span></a>
										</td>
									<cfelse>
										<td><p class="">No</p></td>
										<td>
											<a class="btn btn-sm btn-success" ><span class="glyphicon glyphicon-trash"></span></a>
											<a class="btn btn-sm btn-success "><span class="glyphicon glyphicon-pencil"></span></a>
										</td>
									</cfif>
								</tr>
							</cfoutput>
						</tbody>
						<tfoot class="thead-dark">
								<tr class="table-info info">
								<th>Id</th>
								<th>Name</th>
								<th>Gender</th>
								<th>DOB</th>
								<th>JobTitle</th>
								<th>Dept.</th>
								<th>Email</th>
								<th>Username</th>
								<th>Type</th>
								<th>status</th>
								<th>action</th>
							</tr>
						</tfoot>
				  </table>
  				</div>
  				
  				 <cfset projectDetails=application.projectDao.getAllProject()>
  				
  				<div class="table-responsive item-2 content-item" id="projectTableDiv" style="display: none;">
			  	 	<table class=" table stripe hover nowrap tableWidth compact cell-border" cellspacing="0" id="projectTable">
						<caption>Project Datails</caption>
			  	 		<thead class="thead-dark">
							<tr class="table-info info">
								
								
								<th>Project Id</th>
								<th>Title</th>
								<th>Descreption</th>
								<th>TeamLeader</th>
								<th>ActiveStatus</th>
								<th>
									<a class="btn btn-sm btn-info" ><span class="glyphicon glyphicon-trash">Deactive</span></a>
									<a class="btn btn-sm btn-info "><span class="glyphicon glyphicon-pencil">Edit</span></a>
								</th>
							</tr>
						</thead>

						<tbody>
							<cfoutput query="projectDetails">

							<cfif ActiveStatus EQ 1>
								<tr class="success">
							<cfelse>
								<tr class="danger">
							</cfif>
									
									
									<td>#ProjectID#</td>
									<td>#Title#</td>
									<td>#Descreption#</td>
									<td>#TeamLeader#</td>
									<cfif ActiveStatus EQ 1>
										<td><p class="">Yes</p></td>
										<td><a class="btn btn-sm btn-danger" onClick="deactivateProject(#ProjectID#);"><span class="glyphicon glyphicon-trash">Deactive</span></a>
											<a class="btn btn-sm btn-warning" onClick="editProject(#ProjectID#);" ><span class="glyphicon glyphicon-pencil">Edit</span></a>
										</td>
									<cfelse>
										<td><p class="">No</p></td>
										<td>
											<a class="btn btn-sm btn-success" ><span class="glyphicon glyphicon-trash"></span></a>
											<a class="btn btn-sm btn-success "><span class="glyphicon glyphicon-pencil"></span></a>
										</td>
									</cfif>
								</tr>
							</cfoutput>
						</tbody>
						<tfoot class="thead-dark">
								<tr class="table-info info">
								<th>Id</th>
								<th>Title</th>
								<th>Descreption</th>
								<th>TeamLeader</th>
								<th>Status</th>
								<th>action</th>
							</tr>
						</tfoot>
				  </table>
  				</div>
  				 


				<!---Include Employee Registration Modal  --->
				<cfinclude template="registrationModal.cfm">

				<!---Include Employee registrationSuccessModal Modal  --->
				<cfif
					isDefined("url.registration")>
					<cfif #url.registration# EQ 'success'>
						<cfinclude template="registrationSuccessModal.cfm">
					</cfif>
				</cfif>
				
				<!---Include Employee changePasswordSuccessful Modal  --->
				<cfif
					isDefined("url.changePassword")>
					<cfif #url.changePassword# EQ 'success'>
						<cfinclude template="changePasswordSuccessModal.cfm">
					</cfif>
				</cfif>

				<!---Include Employee updateEmployeeModal Modal  --->
				<cfif isDefined("url.edit")>
					<cfif #url.edit# EQ 'success'>
						<cfinclude template="updateEmployeeModal.cfm">
					</cfif>
				</cfif>


				<cfinclude template="deactivateEmployeeModal.cfm">
				<cfinclude template="deactivateProjectModal.cfm">
				<cfinclude template="confirmModal.cfm">
				<cfinclude template="confirmProjectModal.cfm">
				<cfinclude template="editEmployeeModal.cfm">
				<cfinclude template="editProjectModal.cfm">
				<cfinclude template="message.cfm">
				<cfinclude template="changePasswordModal.cfm">
				<cfinclude template="changePhotoModal.cfm">
				<cfinclude template="addProjectModal.cfm">
				
				

			</div>
			<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
			<script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
			<script src="../js/adminDashboard.js"></script>
			<script src="../js/registrationModal.js"></script>
			<script src="../js/editEmployeeModal.js"></script>
			<script src="../js/changePassword.js"></script>
			<script src="../js/addProject.js"></script>
			<script src="../js/editProject.js"></script>
			<script
			src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
			<script
			src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js"></script>
			<script
			src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
			<script
			src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
			<script
			src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
			<script
			src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
			<script
			src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js"></script>
		</body>
		
	</html>
<cfelseif  structKeyExists(session,'stLoggedInUser') and session.stLoggedInUser.role EQ "Employee">
	<cflocation url="/Demo/view/invalidtemplate.cfm"  addtoken="false">
<cfelse>
	<cflocation url="/Demo/view/login.cfm"  addtoken="false">
</cfif>