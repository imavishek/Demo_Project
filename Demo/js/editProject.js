//java script file addProjectModal


var check_first_blank_field = true;


$(document).ready(function(){
	
	
	//Hide all the error message initially
	 
	$("#edit_message_project_title").hide();
	$("#edit_message_project_descreption").hide();
	$("#edit_message_team_leader").hide();
	
	
	
	
	$("#edit_project_title").focusout(function(){
  		check_edit_project_title();
  	});

	$("#edit_project_descreption").focusout(function(){
  		check_edit_project_descreption();
  	});
	
	
	$("#edit_team_leader").focusout(function(){
  		check_edit_team_leader();
  	});
	
	$("#edit_project_form").submit(function(){
	 	var formEditSubmit = validateEditProjectForm();
	 	if (formEditSubmit) {
			var formEditData = new FormData($("#edit_project_form")[0]);
			$.ajax({
				url : "/Demo/components/dao/projectDao.cfc?method=editProject",
				type : 'POST',
				data: formEditData,
				enctype:"multipart/form-data",
				processData:false,
				contentType:false,
	        success : function(response){
	        	console.log(response);
	        	if (response) {
	        		alert("Project updated Successfully!");
				} else {
					alert("Error In Project updating");
				}
	        	
	        },
	        error : function(e){
	        	alert("Error In Project updating");
	        }
	    });
		} else {
			return false;
		}
	 	
	});
	
	 	
	
	
		
	 
	 $("#edit_team_leader").keyup(function(){
		 $("#edit_empResult").html("");
		 var edit_searchValue = $("#edit_team_leader").val();
		 $.ajax({
 			 url:"/Demo/components/dao/employeeDao.cfc?method=getEmployeeByUsername&queryformat=column&username="+edit_searchValue,
 				 
 				 dataType: "json", 
 				 type:"POST",
 				success: function(response){
 					if (response) {
 						for(i=0 ; i < response.DATA.EMPLOYEEID.length ; i++){
 							var edit_name=response.DATA.USERNAME[i];
 							$("#edit_empResult").append('<li class="list-group-item" onClick=fillEditSearch("'+edit_name+'",'+response.DATA.EMPLOYEEID[i]+');>'+response.DATA.USERNAME[i]+'</li>');
 						}
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
	function fillEditSearch(username,id){	
		$("#edit_team_leader").val(username);
		$("#edit_team_leader_hidden").val(id); 
		$("#edit_empResult").html("");
	}
	  	
	  	
	  	
	  	function validateEditProjectForm(){

	  		this.check_first_blank_field = true;
	  		
	  		var edit_project_title_flag = check_edit_project_title();
	  		var edit_project_descreption_flag = check_edit_project_descreption();
	  		var edit_team_leader_flag = check_edit_team_leader();
	  		
	  		
	  		return edit_project_title_flag && edit_project_descreption_flag && edit_team_leader_flag ;
	  	           
	  	}
	  	
	  	function check_edit_project_title(){
			 var edit_project_title =  $("#edit_project_title").val();

			 var flag = true;

			 if (edit_project_title=="") {
				printError("#edit_message_project_title","error_project_title","#edit_project_title",this.check_first_blank_field);
				flag = false;
			}else{
				hideError("#edit_message_project_title","#edit_project_title");
			}

			return flag;

	}


	function check_edit_project_descreption(){
			 var edit_project_descreption =  $("#edit_project_descreption").val();
			 var flag = true;

			if (edit_project_descreption=="") {
				printError("#edit_message_project_descreption","error_project_descreption","#edit_project_descreption",this.check_first_blank_field);
				flag = false;
				
			}else{
				hideError("#edit_message_project_descreption","#edit_project_descreption");
			}

			return flag;

	}
		

	 function check_edit_team_leader(){
	  		var edit_team_leader = $("#edit_team_leader").val();
	  		var flag = true;

	  		if (!edit_team_leader.length) {
	  	        printError("#edit_message_team_leader","error_team_leader","#edit_team_leader",this.check_first_blank_field);
	  			flag =  false;
	  		}else{
	  			hideError("#edit_message_team_leader","#edit_team_leader");
	  		}

	  		return flag;
	 }
	 
	
		
		
		
