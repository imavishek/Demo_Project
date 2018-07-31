//changePassword java script

var check_first_blank_field = true;

$(document).ready(function() {

	// Hide all the error message initially
	$(".message_new_password").hide();
	$(".message_confirm_password").hide();
	
	$(".lettersOnly").keyup(function() {
		lettersOnly(this)
	});

	
	$("#newpassword").focusout(function() {
		check_newpassword();
	});

	$("#confirmpassword").focusout(function() {
		check_confirmpassword();
	});
	
	
	$("#change_passwordForm").submit(function(e) {
		var form = validateChangePasswordForm();
		return form;
	});
	
	
});




function validateChangePasswordForm() {

	this.check_first_blank_field = true;

	var newpassword_flag = check_newpassword();
	var confirmpassword_flag = check_confirmpassword();
	

	return newpassword_flag && confirmpassword_flag;
}



function check_newpassword(){
	var password = $("#newpassword").val();
	var password_regx = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,16})/g;
	var flag = true;

	if (password=="") {
		printError("#message_new_password","error_password","#newpassword",this.check_first_blank_field);
		flag =  false;
		
	}else if (!(password.length>=8 && password.length<=16)){
        printError("#message_new_password","error_password_length","#newpassword",this.check_first_blank_field);
		flag =  false;    
	}else if (password_regx.test(password) == false){
        printError("#message_new_password","error_password_validation","#newpassword",this.check_first_blank_field);
		flag =  false;      
	}else{
		hideError("#message_new_password","#newpassword");
	}

	return flag;
}

function check_confirmpassword(){
	var password = $("#newpassword").val();
	var confirm_password = $("#confirmpassword").val();
	var flag = true;

	if (confirm_password=="") {
		printError("#message_confirm_password","error_confirm_password","#confirmpassword",this.check_first_blank_field);
		flag =  false;
		
	}else if (password!=confirm_password){
        printError("#message_confirm_password","error_password_mismatch","#confirmpassword",this.check_first_blank_field);
		flag =  false;     
	}else{
		hideError("#message_confirm_password","#confirmpassword");
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
