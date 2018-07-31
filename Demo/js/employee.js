//employee java script

var errors = {
		error_firstname : "Fill the first name field",
		error_firstname_length : "length between 3 to 20 character",
		error_lastname : "Fill the last name field",
		error_lastname_length : "length between 3 to 20 character",
		error_gender : "Select gender field",
		error_date_of_birth : "Enter date of birth",
		error_email : "Fill the email id field",
		error_email_validation : "correct email id ex:abc@gmail.com",
		error_country:"Select the country field",
		error_state:"Select the state field",
		error_city:"Select the city field",
		error_password:"Fill the password  field",
		error_password_length:"length between 8 to 16 character",
		error_password_validation:"password must contain a lowercase letter, a uppercase letter, a numeric number and a special character",
		error_confirm_password:"Fill the confirm password  field",
		error_password_mismatch:"password mismatch",
		error_photo:"Upload a photo"
};

var check_first_blank_field = true;

$(document).ready(function() {
	
setMaxDate();	
	
	// Hide all the error message initially
	$(".message_first_name").hide();
	$(".message_middle_name").hide();
	$(".message_last_name").hide();
	$(".message_gender").hide();
	$(".message_date_of_birth").hide();
	$(".message_email").hide();
	$(".message_country").hide();
	$(".message_state").hide();
	$(".message_city").hide();
	
	
	$("#first_name").focusout(function(){
  		check_first_name();
  	});

	$("#last_name").focusout(function(){
  		check_last_name();
  	});
	
	$(".gender").focusout(function(){
  		check_gender();
  	});
	
	$("#date_of_birth").focusout(function(){
  		check_date_of_birth();
  	});
	
	$("#email").focusout(function(){
  		check_email();
  	});
	
	$("#country").focusout(function(){
  		check_country();
  	});
	
	$("#state").focusout(function(){
  		check_state();
  	});
  	
  	$("#city").focusout(function(){
  		check_city();
  	});
  	
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
  	
  	$("#employeeEditForm").submit(function(e){
  		 e.preventDefault();
  		 var form = validateForm();
  		 if (form) {
  			 saveEmployeeData();
  			
  		}else{
  			return form;
  		}
  		 
  	});
  	
  	
	
	$(".lettersOnly").keyup(function() {
		lettersOnly(this)
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
	
	$("#changePasswordSuccessModal").modal('show');

	$("#passwordChange").click(function() {
		$("#changePassword").modal('show');
	});

});


function saveEmployeeData(){

	var firstName = $('#first_name').val();
	var middleName = $('#middle_name').val();
	var lastName = $("input:radio[name='gender']").val();
	var dateOfBirth = $('#date_of_birth').val();
	var gender = $('#username').val();
	var email = $('#email').val();
	var country = $('#country').val();
	var state = $('#state').val();
	var city = $('#city').val();
	$.ajax({
			 url:"/Demo/components/dao/employeeDao.cfc",
			 data: {
					method : "saveEmployeeData",
					 firstName : firstName ,
					 middleName : middleName ,
					 lastName : lastName ,
					 dateOfBirth : dateOfBirth,
					 gender : gender ,
					 email : email ,
					 country : country ,
					 state : state,
					 city : city,
					 },
				 dataType: "json", 
				 type:"POST",
				success: function(response){
					console.log(response);
					if (response) {
						$("#updateEmployeeModal").modal('show');
					}else{
						$("#invalidLoginModal").modal('show');
					}
				}
		});  
}


function validateForm(){

		this.check_first_blank_field = true;
		
		var first_name_flag = check_first_name();
		var last_name_flag = check_last_name();
		var gender_flag = check_gender();
		var date_of_birth_flag = check_date_of_birth();
		var email_flag = check_email();
		var country_flag = check_country();
		var state_flag = check_state();
		var city_flag = check_city();
		
		return first_name_flag && last_name_flag && gender_flag && date_of_birth_flag && email_flag && 
		country_flag && state_flag && city_flag ;
	           
	}
	
	function check_first_name(){
	 var first_name =  $("#first_name").val();

	 var flag = true;

	 if (first_name=="") {
		printError("#message_first_name","error_firstname","#first_name",this.check_first_blank_field);
		flag = false;
	}
	else if (!(first_name.length<=20 && first_name.length>=3)) {
		printError("#message_first_name","error_firstname_length","#first_name",this.check_first_blank_field);
		flag = false;
	}else{
		hideError("#message_first_name","#first_name");
	}

	return flag;

}

// validate function for LastName
function check_last_name(){
	 var last_name =  $("#last_name").val();
	 var flag = true;

	if (last_name=="") {
		printError("#message_last_name","error_lastname","#last_name",this.check_first_blank_field);
		flag = false;
		
	}else if (!(last_name.length<=20 && last_name.length>=3)) {
		printError("#message_last_name","error_lastname_length","#last_name",this.check_first_blank_field);
		flag = false;
	}else{
		hideError("#message_last_name","#last_name");
	}

	return flag;

}

// validate function for Gender
function check_gender(){
		var gender = $('input[name="gender"]:checked');
		var flag = true;

		if (!gender.length) {
	        printError("#message_gender","error_gender","#male",this.check_first_blank_field);
			flag =  false;
		}else{
			hideError("#message_gender","#male");
		}

		return flag;
}

// validate function for DateOfBirth
function check_date_of_birth(){
	var date_of_birth = $("#date_of_birth").val();
	var flag = true;

	if (date_of_birth=="") {
        printError("#message_date_of_birth","error_date_of_birth","#date_of_birth",this.check_first_blank_field);
		flag =  false;
	}else{
		hideError("#message_date_of_birth","#date_of_birth");
	}

	return flag;
}

// validate function for Email
function check_email(){
	var email = $("#email").val();
	var email_regx = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/g;
	var flag = true;

	if (email=="") {
		printError("#message_email","error_email","#email",this.check_first_blank_field);
		flag =  false;
		
	}else if (email_regx.test(email) == false){
        printError("#message_email","error_email_validation","#email",this.check_first_blank_field);
		flag =  false;    
	}else{
		hideError("#message_email","#email");

	}

	return flag;
}

function check_country(){
	var country = $("#country").val();
	var flag = true;

	if (country=="blank") {
		printError("#message_country","error_country","#country",this.check_first_blank_field);
		flag =  false;
		
	}else{
		hideError("#message_country","#country");
	}

	return flag;
}

function check_state(){
	var state = $("#state").val();
	var flag = true;

	if (state=="blank") {
		printError("#message_state","error_state","#state",this.check_first_blank_field);
		flag =  false;
	}else{
		hideError("#message_state","#state");
	}

	return flag;
}

function check_city(){
	var city = $("#city").val();
	var flag = true;

	if (city=="blank") {
		printError("#message_city","error_city","#city",this.check_first_blank_field);
		flag =  false;
		
	}else{
		hideError("#message_city","#city");
	}

	return flag;
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
	$("#date_of_birth").attr("max", today);
}

	
	
