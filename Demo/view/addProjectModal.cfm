<head>
	<link rel="stylesheet" href="../css/messageModal.css">

</head>
	<!---Add Project Modal  --->
	<div class="modal fade" id="addProjectModal" role="dialog">
	          <div class="modal-dialog" >
	              <div class="modal-content">

	                  <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal">&times;</button>
	                        <h4 class="form-title">Add  Project</h4>
	                  </div>

	                  <div class="modal-body" id="scrollabel" style="height:500px;">
	                    <span class="message_error">*</span>
	                    <span class="message_error">marked fields are mandatory</span><br><br>
	                        <form role="form" method="POST"  action="" name="project_form" id="project_form">
	                              <div class="form-group">
	                                  <label for="project_title">Project Title</label>
	                                  <span class="message_error">*</span>
	                                  <input type="text" id="project_title" class="form-control  project_title" name="project_title" maxlength="30"placeholder="Enter Project Title.." >
	                                  <span id="message_project_title" class="message_error"></span>
	                               </div>


	                              <div class="form-group">
	                                <label for="project_descreption">Project Descreption</label>
	                                 <span class="message_error">*</span>
	                                <textarea rows="4" cols="50" id="project_descreption" class="form-control "  name="project_descreption"></textarea>
	                                <span id="message_project_descreption" class="message_error"></span>
	                              </div>

	                              <input type="hidden" id="team_leader_hidden" name="team_leader_hidden">

	                              <div class="form-group">
	                                <label for="team_leader">Team Leader</label>
	                                 <span class="message_error">*</span>
	                                <input type="text" id="team_leader" class="form-control  " name="team_leader" maxlength="20"placeholder="Enter employee username.." >
	                                <span id="message_team_leader" class="message_error"></span>
								   </div>

								   <div class="">
								  		<ul class="list-group" id="empResult"></ul>
								   </div>


								   <input type="reset" class="btn btn-warning pull-left" name="addProjectReset" id="addProjectReset" value="Reset"/>
	                              <input type="submit" class="btn btn-success pull-right" name="addProject" id="addProject" value="Add Project"/>
	                        </form>
	                  </div>
	                  <div class="modal-footer">
	                    <button type="submit" class="btn btn-default btn-danger pull-right" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
	                  </div>
	              </div>

	          </div>
	      </div>

