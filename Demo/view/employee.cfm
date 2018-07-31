<!-- Employee Home Page -->
<cfif structKeyExists(session,'stLoggedInUser') and session.stLoggedInUser.role EQ "Employee">
	<html>
		<head>
			<title>
				Mindfire
			</title>
			<link rel="icon" href="../images/tittleicon.jpg">
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<link rel="stylesheet" href="../css/employee.css">
			<link
				href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
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
						<li>
							<a class="dropdown-toggle" data-toggle="dropdown" style="cursor: pointer;">
								<cfset fileName = application.employeeDao.getPhoto()>
								<cfif fileName EQ "">
									<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" style="max-width:40px; margin-top: -7px;" class=" avatar img-circle img-thumbnail" alt="noPic">
								<cfelse>
									<img src="../profilePhoto/<cfoutput>#fileName#</cfoutput>.jpg"
										style="max-width:40px; margin-top: -7px;" class=" avatar img-circle img-thumbnail" alt="<cfoutput>#session.stLoggedInUser.userName#</cfoutput>">
								</cfif>
								<cfoutput>
									#session.stLoggedInUser.userName#
								</cfoutput>
								<span class="caret">
								</span>
							</a>
							<ul class="dropdown-menu">
								<li>
									<a id="photoChange" style="cursor: pointer;">
										Change Photo
									</a>
								</li>
								<li>
									<a id="passwordChange" style="cursor: pointer;">
										Change password
									</a>
								</li>
								<li>
									<a id="logout" style="cursor: pointer;">
										Logout
									</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</nav>
			<div class="container bootstrap snippet">
			<div class="row">
				<div class="col-sm-3">
					<!--left col-->
					<div class="text-center">
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							Activity
						</div>
						<div class="panel-body">
							<ul class="list-group">
								<li class="active">
									<a data-toggle="tab" href="#profile">
										My Profile
									</a>
								</li>
								<li>
									<a data-toggle="tab" href="#Project">
										Project
									</a>
								</li>

							</ul>
						</div>
					</div>
				</div>
				<!--/col-3-->
				<div class="col-sm-9">
					<div class="tab-content">
						<div class="tab-pane active" id="profile">
							<!--- <div class="col-sm-2 pull-right">
								<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" class="avatar img-circle img-thumbnail" alt="avatar">
								<input type="file"  class="text-center center-block file-upload">
								</div> --->

							<form class="form" action="##" method="post" id="employeeEditForm">
								<!---  <div class="form-group">
									<input type="file"  class="text-center  center-block file-upload">
									</div> --->
								<div class="form-group">
									<div class="col-xs-4">
										<label for="first_name">
											<span class="glyphicon glyphicon-user">
											</span>
											First Name
										</label>
										<span class="message_error">
											*
										</span>
										<input type="text" id="first_name" class="form-control lettersOnly first_name" name="first_name" maxlength="20"placeholder="Enter Your First Name.." >
										<span id="message_first_name" class="message_error message_first_name">
										</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-4">
										<label for="mobile">
											<h4>
												Gender
											</h4>
										</label>
										<span class="message_error">
											*
										</span>
										<label for="male" class="radio-inline">
											<input type="radio" id="male"  name="gender" class="gender" value="Male">
											Male
										</label>
										<label for="female" class="radio-inline" >
											<input type="radio" id="female" name="gender"  class="gender" value="Female">
											Female
										</label>
										<br>
										<span id="message_gender" class="message_error message_gender">
										</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-4">
										<label for="country" class="heading">
											Country
										</label>
										<span class="message_error">
											*
										</span>
										<select id="country" class=" form-control float_right" name="country">
										</select>
										<span id="message_country" class="message_error float_right">
										</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-4">
										<label for="middle_name">
											<span class="glyphicon glyphicon-user">
											</span>
											Middle Name
										</label>
										<input type="text" id="middle_name" class="form-control lettersOnly middle_name"  name="middle_name" maxlength="20" placeholder="Enter Your Middle Name..">
										<span id="message_middle_name" class="message_error message_middle_name">
										</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-4 ">
										<label for="date_of_birth">
											<span class="glyphicon glyphicon-calendar">
											</span>
											Date Of Birth
										</label>
										<span class="message_error">
											*
										</span>
										<input type="date" id="date_of_birth" class="form-control date_of_birth" name="date_of_birth" min="1900-01-01">
										<span id="message_date_of_birth" class="message_error message_date_of_birth">
										</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-4">
										<label for="state" class="heading">
											State
										</label>
										<span class="message_error">
											*
										</span>
										<select id="state" class="form-control float_right" name="state" >
											<option value="blank">
												------------Select State------------
											</option>
										</select>
										<span id="message_state" class="message_error float_right">
										</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-4">
										<label for="last_name">
											<span class="glyphicon glyphicon-user">
											</span>
											Last Name
										</label>
										<span class="message_error">
											*
										</span>
										<input type="text" id="last_name" class="form-control lettersOnly last_name"  name="last_name" maxlength="20" placeholder="Enter Your Last Name..">
										<span id="message_last_name" class="message_error message_last_name">
										</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-4">
										<label for="email">
											<span class="glyphicon glyphicon-envelope">
											</span>
											Email Id
										</label>
										<span class="message_error">
											*
										</span>
										<input type="text" id="email" maxlength="40" class="form-control email" name="email" placeholder="Enter Your Email.." >
										<span id="message_email" class="message_error message_email">
										</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-4">
										<label for="city" class="heading">
											City
										</label>
										<span class="message_error">
											*
										</span>
										<select id="city" class="form-control float_right" name="city" >
											<option value="blank">
												------------Select City------------
											</option>
										</select>
										<span id="message_city" class="message_error float_right">
										</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-12">
										<br>
										<input type="reset" name="reset" value="Reset" class="btn  btn-warning">
										<input type="submit" name="save" id="save" value="Save" class="btn  btn-success">
									</div>
								</div>
							</form>
							<hr>
						</div>
						<!--/tab-pane-->
					<div class="tab-pane" id="Project">
							<h2>Works with: <strong><span></span></strong>
							</h2>
							<hr>

							<h4>Project Name:
							</h4>

							<h5><strong>Project Descreption:</strong>
							</h5>

							<h4><strong>Team Members:</strong>
							</h4>






							</div>
							<!--/tab-pane-->

					</div>
					<!--/tab-content-->
				</div>
				<!--/col-9-->
			</div>
			<!--Include Employee changePasswordSuccessful Modal  -->
			<cfif
				isDefined("url.changePassword")>
				<cfif #url.changePassword# EQ 'success'>
					<cfinclude template="changePasswordSuccessModal.cfm">
				</cfif>
			</cfif>
			<cfinclude template="changePasswordModal.cfm">
			<cfinclude template="changePhotoModal.cfm">
		</body>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.js"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.js"></script>
		<script src="../js/employee.js"></script>
		<script src="../js/address.js"></script>
		<script src="../js/changePassword.js"></script>
	</html>
<cfelseif  structKeyExists(session,'stLoggedInUser') and session.stLoggedInUser.role EQ "Admin">
	<cflocation url="/Demo/view/invalidtemplate.cfm"  addtoken="false">
<cfelse>
	<cflocation url="/Demo/view/login.cfm"  addtoken="false">
</cfif>
