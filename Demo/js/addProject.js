//java script file addProjectModal


var check_first_blank_field = true;


$(document).ready(function(){
	
	
	//Hide all the error message initially
	 
	$("#message_project_title").hide();
	$("#message_project_descreption").hide();
	$("#message_team_leader").hide();
	
	
	
	
	$("#project_title").focusout(function(){
  		check_project_title();
  	});

	$("#project_descreption").focusout(function(){
  		check_project_descreption();
  	});
	
	
	$("#team_leader").focusout(function(){
  		check_team_leader();
  	});
	
	$("#project_form").submit(function(){
	 	var formSubmit = validateProjectForm();
	 	if (formSubmit) {
			var formData = new FormData($("#project_form")[0]);
			$.ajax({
				url : "/Demo/components/dao/projectDao.cfc?method=addProject",
				type : 'POST',
				data: formData,
				enctype:"multipart/form-data",
				processData:false,
				contentType:false,
	        success : function(response){
	        	console.log(response);
	        	if (response) {
	        		alert("Project Added Successfully!");
				} else {
					alert("Error In Project Adding");
				}
	        	
	        },
	        error : function(e){
	        	alert("Error In Project Adding");
	        }
	    });
		} else {
			return false;
		}
	 	
	});
	 	
	
	
		
	 
	 $("#team_leader").keyup(function(){
		 $("#empResult").html("");
		 var searchValue = $("#team_leader").val();
		 $.ajax({
 			 url:"/Demo/components/dao/employeeDao.cfc?method=getEmployeeByUsername&queryformat=column&username="+searchValue,
 				 
 				 dataType: "json", 
 				 type:"POST",
 				success: function(response){
 					if (response) {
 						
 						for(i=0 ; i < response.DATA.EMPLOYEEID.length ; i++){
 							var name=response.DATA.USERNAME[i];
 							$("#empResult").append('<li class="list-group-item" onClick=fillSearch("'+name+'",'+response.DATA.EMPLOYEEID[i]+');>'+response.DATA.USERNAME[i]+'</li>');
 						}
 						 $("#listGroup").attr("display","display");
 					} else {
 						
 					}
 					
 				}
 		});
	 });
	 	
	 	
 	
});	  

	function fillSearch(username,id){	
		$("#team_leader").val(username);
		$("#team_leader_hidden").val(id); 
		$("#empResult").html("");
	}
	  	
	  	
	  	
	  	function validateProjectForm(){

	  		this.check_first_blank_field = true;
	  		
	  		var project_title_flag = check_project_title();
	  		var project_descreption_flag = check_project_descreption();
	  		var team_leader_flag = check_team_leader();
	  		
	  		
	  		return project_title_flag && project_descreption_flag && team_leader_flag ;
	  	           
	  	}
	  	
	  	function check_project_title(){
			 var project_title =  $("#project_title").val();

			 var flag = true;

			 if (project_title=="") {
				printError("#message_project_title","error_project_title","#project_title",this.check_first_blank_field);
				flag = false;
			}else{
				hideError("#message_project_title","#project_title");
			}

			return flag;

	}


	function check_project_descreption(){
			 var project_descreption =  $("#project_descreption").val();
			 var flag = true;

			if (project_descreption=="") {
				printError("#message_project_descreption","error_project_descreption","#project_descreption",this.check_first_blank_field);
				flag = false;
				
			}else{
				hideError("#message_project_descreption","#project_descreption");
			}

			return flag;

	}
		

	 function check_team_leader(){
	  		var team_leader = $("#team_leader").val();
	  		var flag = true;

	  		if (!team_leader.length) {
	  	        printError("#message_team_leader","error_team_leader","#team_leader",this.check_first_blank_field);
	  			flag =  false;
	  		}else{
	  			hideError("#message_team_leader","#team_leader");
	  		}

	  		return flag;
	 }
	 
	
		
		
		
