//adminDashboard java script

//Array of errors with key
var errors = {
	error_firstname : "Fill the first name field",
	error_firstname_length : "First name length between 3 to 20 character",
	error_middlename_length : "Middle name length not exceed  20 character",
	error_lastname : "Fill the last name field",
	error_lastname_length : "Last name length between 3 to 20 character",
	error_gender : "Select gender field",
	error_date_of_birth : "Enter date of birth",
	error_email : "Fill the email id field",
	error_email_validation : "Enter correct email id ex:abc@gmail.com",
	error_department : "Select the department field",
	error_job_title : "Select the job title field",
	error_userType : "Select UserType",
	error_username : "Fill the Username field",
	error_username_length : "Username length between 3 to 30 character",
	error_username_invalid : "Username exists",
	error_password:"Fill the password  field",
	error_password_length:"length between 8 to 16 character",
	error_password_validation:"password must contain a lowercase letter, a uppercase letter, a numeric number and a special character",
	error_confirm_password:"Fill the confirm password  field",
	error_password_mismatch:"password mismatch",
	error_photo:"Upload a photo",
	error_project_title: "Fill the title field",
	error_project_descreption:"Fill the descreption field",
	error_team_leader:"Fill the teamleader field"
};

$(document).ready(function() {
	
			$(".lettersOnly").keyup(function() {
				lettersOnly(this)
			});

			$("#regdBtn").click(function() {
				$("#registrationModal").modal('show');

			});
			
			$("#projBtn").click(function() {
				
				$("#addProjectModal").modal('show');
			});
			
			$('.change-item').click(function(){
			    var this_item = $(this).attr("data-item");
			    $('.content-item').hide();
			    $('.item-' + this_item).fadeIn();
			});

			$("#confirmYes").click(function() {
				console.log(id);
				$.ajax({
					url : "/Demo/components/dao/employeeDao.cfc",
					data : {
						method : "deactiveEmployee",
						employeeId : id,
					},
					dataType : "json",
					type : "POST",
					success : function(response) {
						if (response) {
							$("#deactivateEmployeeModal").modal('show');
						} else {
							$("#messageModal").modal('show');
						}
					}
				});
			});
			
			$("#confirmProjectYes").click(function() {
				$.ajax({
					url : "/Demo/components/dao/projectDao.cfc",
					data : {
						method : "deactiveProject",
						projectId : projid,
					},
					dataType : "json",
					type : "POST",
					success : function(response) {
						
						if (response) {
							$("#deactivateProjectModal").modal('show');
						} else {
							$("#messageModal").modal('show');
						}
					}
				});
			});

			$("#registrationSuccessModal").modal('show');
			$("#updateEmployeeModal").modal('show');
			$("#changePasswordSuccessModal").modal('show');
			
			
			
			$("#photoChange").click(function() {
				$("#changePhotoModal").modal('show');
			});
			
			
			
			$("#change_photo").submit(function() {
				var photo = $("#photo").val();
				if (photo=="") {
					printError("#message_photo", "error_photo",
							"#photo", this.check_first_blank_field);
					return false;
				}
				else {
					return true;
				}
			});
			
			
			
			$("#successModal").click(function() {
				window.location = "/Demo/view/adminDashboard.cfm";
			});
			
			$("#successProjectModal").click(function() {
				window.location = "/Demo/view/adminDashboard.cfm";
			});
			

			$("#logout").click(function() {

				$.ajax({
					url : "/Demo/components/dao/loginDao.cfc",
					data : {
						method : "userLogout",
					},
					dataType : "json",
					type : "POST",
					success : function(response) {

						if (response) {
							window.location = "/Demo/view/login.cfm";
						} else {
							$("#messageModal").modal('show');
						}
					}

				});

			});
			
			$("#passwordChange").click(function() {
				$("#changePassword").modal('show');
			});
			
			
			

			$('#employeeTable tfoot th').each(
					function() {
						var title = $(this).text();
						$(this).html(
								'<input type="text" placeholder="Search '
										+ title + '" />');
					});

			var empTable = $('#employeeTable').DataTable({
				"columnDefs": [ {
					"targets": 1,
					"orderable": false
					} ],
				dom: 'Bfrtip',
			        buttons: [
			            'copy', 'csv', 'excel', 'pdf', 'print'
			        ],
			        
			
					"order" : [ [ 0, "desc" ] ]
			});

			empTable.columns().every(function() {
				var that = this;

				$('input', this.footer()).on('keyup change', function() {
					if (that.search() !== this.value) {
						that.search(this.value).draw();
					}
				});
			});
			$('#employeeTable tbody').on('mouseenter', 'td', function() {
				var colIdx = empTable.cell(this).index().column;

				$(empTable.cells().nodes()).removeClass('highlight');
				$(empTable.column(colIdx).nodes()).addClass('highlight');
			});
			
			
			$('#projectTable tfoot th').each(
					function() {
						var title = $(this).text();
						$(this).html(
								'<input type="text" placeholder="Search '
										+ title + '" />');
					});

			var projTable = $('#projectTable').DataTable({
				"columnDefs": [ {
					"targets": 1,
					"orderable": false
					} ],
				dom: 'Bfrtip',
			        buttons: [
			            'copy', 'csv', 'excel', 'pdf', 'print'
			        ],
			        
			
					"order" : [ [ 0, "desc" ] ]
			});

			projTable.columns().every(function() {
				var that = this;

				$('input', this.footer()).on('keyup change', function() {
					if (that.search() !== this.value) {
						that.search(this.value).draw();
					}
				});
			});
			$('#projectTable tbody').on('mouseenter', 'td', function() {
				var colIdx = projTable.cell(this).index().column;

				$(projTable.cells().nodes()).removeClass('highlight');
				$(projTable.column(colIdx).nodes()).addClass('highlight');
			});

		});

function editEmployee(employeeId) {
	$.ajax({
		url : "/Demo/components/dao/employeeDao.cfc",
		data : {
			method : "getEmployeeById",
			employeeId : employeeId,
		},
		dataType : "json",
		type : "POST",
		success : function(response) {

			if (response) {
				$("#employeeId")
						.html("<span>EmployeeID:  </span>" + employeeId);
				$("#edit_employeeId").val(employeeId);
				$("#edit_first_name").val(response[0]);
				$("#edit_middle_name").val(response[1]);
				$("#edit_last_name").val(response[2]);
				if (response[3] == "Male") {
					$("#edit_male").prop("checked", true);
				} else {
					$("#edit_female").prop("checked", true);
				}
				var date = new Date(response[4]);
				var dd = date.getDate();
				var mm = date.getMonth() + 1;
				var yyyy = date.getFullYear();
				if (dd < 10) {
					dd = '0' + dd
				}
				if (mm < 10) {
					mm = '0' + mm
				}

				resDate = yyyy + '-' + mm + '-' + dd;
				$("#edit_date_of_birth").val(resDate);
				$("#edit_email").val(response[7]);
				$("#edit_department").val(response[6]);
				$("#edit_job_title").val(response[5]);
				$("#edit_userType").val(response[8]);

				$("#editEmployeeModal").modal('show');

			} else {
				$("#messageModal").modal('show');
			}
		}
	});

}

function editProject(projectId) {
	$.ajax({
		url : "/Demo/components/dao/projectDao.cfc?method=getProjectById&queryformat=column&projectId="+projectId,
		dataType : "json",
		type : "POST",
		success : function(response) {

			if (response) {
				$("#projectId")
						.html("<span>ProjectID:  </span>" + projectId);
				$("#edit_projectId").val(projectId);
				$("#edit_project_title").val(response.DATA.TITLE[0]);
				$("#edit_project_descreption").val(response.DATA.DESCREPTION[0]);
				$("#edit_team_leader_hidden").val(response.DATA.TEAMLEADER[0]);
				$("#edit_team_leader").val(response.DATA.TEAMLEADERNAME[0]);
				

				$("#editProjectModal").modal('show');

			} else {
				$("#messageModal").modal('show');
			}
		}
	});

}

function deactivateProject(projectId) {
	console.log("dd");
	projid = projectId;
	$("#confirmProjectModal").modal('show');
}

function deactivateEmployee(employeeId) {
	id = employeeId;
	$("#confirmModal").modal('show');
}

// function to set max date of dateofbirth to today
function setMaxDate() {
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1;
	var yyyy = today.getFullYear();
	if (dd < 10) {
		dd = '0' + dd
	}
	if (mm < 10) {
		mm = '0' + mm
	}

	today = yyyy + '-' + mm + '-' + dd;
	$(".date_of_birth").attr("max", today);
}

function printError(id, msgid, fieldid, check_first_blank_field) {
	$(id).html(errors[msgid]);
	$(id).show();
	$(fieldid).css("border-bottom", "2px solid #F90A0A");

	if (check_first_blank_field) {
		$(fieldid).focus();
		this.check_first_blank_field = false;
	}

}

function hideError(msgid, fieldid) {
	$(msgid).hide();
	$(fieldid).css("border-bottom", "2px solid #34F458");

}

// function to allow only letters to a field
function lettersOnly(input) {

	var name_regex = /[^a-z]/gi;
	input.value = input.value.replace(name_regex, "");
}
function onlyNumberAndLetter(input) {

	var name_regex = /[^0-9a-z]/gi;
	input.value = input.value.replace(name_regex, "");

}
