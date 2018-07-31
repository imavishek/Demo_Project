<!--forgot password Modal  -->
<head>
	<link rel="stylesheet" href="../css/messageModal.css">
</head>
<div class="modal fade" id="forgotPasswordModal" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					&times;
				</button>
				<h4 class="form-title">
					Forgot Password
				</h4>
			</div>
			<div class="modal-body" id="scrollabel" style="height:150px;">
				<form role="form" method="POST"   name="forgot_form" id="forgot_form">
					<div class="form-group">
						<label for="username_forgot_password">
							<span class="glyphicon glyphicon-user">
							</span>
							UserName
						</label>
						<input type="text"  id="username_forgot_password" class="form-control"   name="username_forgot_password" maxlength="30" placeholder="Enter Your User Name.." />
						<span id="message_username_forgot_password" class="message_error">

						</span>
					</div>
					 <input type="reset" class="btn btn-warning pull-left" name="forgotPasswordReset" id="forgotPasswordReset" value="Reset"/>
					<input type="submit" class="btn btn-success pull-right" name="forgotPassword" id="forgotPassword" value="Forgot"/>
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
