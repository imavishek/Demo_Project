<head>
	<link rel="stylesheet" href="../css/messageModal.css">

</head>
<!---project edit Modal  --->
	<div class="modal fade" id="editProjectModal" role="dialog">
	          <div class="modal-dialog">
	              <div class="modal-content">

	                  <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal">&times;</button>
	                        <h4 class="form-title" id="projectId"></h4>
	                  </div>

	                  <div class="modal-body" id="scrollabel">
	                    <span class="message_error">*</span>
	                    <span class="message_error">marked fields are mandatory</span><br><br>
	                        <form role="form" method="POST"   name="edit_project_form" id="edit_project_form">

								  <input type="hidden" id="edit_projectId" name="edit_projectId" />
	                              <div class="form-group">
	                                  <label for="edit_project_title">Project Title</label>
	                                  <span class="message_error">*</span>
	                                  <input type="text" id="edit_project_title" class="form-control  " name="edit_project_title" maxlength="30" >
	                                  <span id="edit_message_project_title" class="message_error"></span>
	                               </div>


	                              <div class="form-group">
	                                <label for="edit_project_descreption">Project Descreption</label>
	                                 <span class="message_error">*</span>
	                                <textarea rows="4" cols="50" id="edit_project_descreption" class="form-control "  name="edit_project_descreption"></textarea>
	                                <span id="edit_message_project_descreption" class="message_error"></span>
	                              </div>

	                              <input type="hidden" id="edit_team_leader_hidden" name="edit_team_leader_hidden">

	                              <div class="form-group">
	                                <label for="edit_team_leader">Team Leader</label>
	                                 <span class="message_error">*</span>
	                                <input type="text" id="edit_team_leader" class="form-control  " name="edit_team_leader" maxlength="20" >
	                                <span id="edit_message_team_leader" class="message_error"></span>
								   </div>

								   <div class="">
								  		<ul class="list-group" id="edit_empResult"></ul>
								   </div>


								   <input type="reset" class="btn btn-warning pull-left" name="edit_addProjectReset" id="edit_addProjectReset" value="Reset"/>
	                              <input type="submit" class="btn btn-success pull-right" name="edit_addProject" id="edit_addProject" value="Update"/>
	                        </form>
	                  </div>

	                  <div class="modal-footer">
	                    <button type="submit" class="btn btn-default btn-danger pull-right" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
	                  </div>
	              </div>

	          </div>
	      </div>
	  </div>
