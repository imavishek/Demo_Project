<!--change password Modal  -->
<head>
	<link rel="stylesheet" href="../css/messageModal.css">

</head>
<div class="modal fade" id="changePassword" role="dialog">
	<div class="modal-dialog modal-sm " >
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					&times;
				</button>
				<h4 class="form-title" id="employeeId">
					EmployeeId:
					<cfoutput>
						#session.stLoggedInUser.employeeId#
					</cfoutput>
				</h4>
			</div>
			<div class="modal-body" id="scrollabel" style="height:300px;">
				<form role="form"  action="../controller/changePassword.cfm" method="POST"  name="change_passwordForm" id="change_passwordForm">
					<input type="hidden" id="change_password_employeeId" name="change_password_employeeId" value=
					<cfoutput>
						#session.stLoggedInUser.employeeId#
					</cfoutput>
					/>
					<div class="form-group">
						<label for="newpassword" class="heading">
							<span class="glyphicon glyphicon-lock">
							</span>
							New Password
						</label>
						<input type="password" id="newpassword" maxlength="16" class="float_right form-control" name="newpassword" placeholder="Enter new Password.." >

						<span id="message_new_password" class="message_error float_right">
						</span>
					</div>
					<div class="form-group">
						<label for="confirmpassword" class="heading">
							<span class="glyphicon glyphicon-lock">
							</span>
							Confirm Password
						</label>
						<input type="password" id="confirmpassword" maxlength="16" class="float_right form-control" name="confirmpassword" placeholder="Enter confirm Password.." >

						<span id="message_confirm_password" class="message_error float_right">
						</span>
					</div>
					<input type="reset" class="btn btn-warning pull-left" name="changePasswordReset" id="changePasswordReset" value="Reset"/>
					<input type="submit" class="btn btn-success pull-right" name="changePassword" id="changePassword" value="Change Password"/>
				</form>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-default btn-danger pull-right" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove">
					</span>
					Cancel
				</button>
			</div>
		</div>
	</div>
</div>
</div>

