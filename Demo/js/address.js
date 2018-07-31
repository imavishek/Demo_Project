
$(function(){
var countryOptions;
var stateOptions;
var cityOptions;

	$.getJSON('../json/countries.json',function(result){
		countryOptions+="<option value='blank'>------------Select Country------------</option>";
		$.each(result, function(key, value){

			countryOptions+="<option value='"+value.id+"'>"+value.name+"</option>";
		});
		$('#country').html(countryOptions);
		$('#permanent_address_country').html(countryOptions);
	});

	$("#country").change(function(){
		stateOptions = null;
		var x = $(this).val();
		console.log(x);
		$.getJSON('../json/states.json',function(result){
			stateOptions+="<option value='blank'>------------Select State------------</option>";
			$.each(result, function(key,value) {
				if(x==value.country_id){
					stateOptions+="<option value='"+value.id+"'>"+value.name+"</option>";
				}
			});
			$('#state').html(stateOptions);
		});
	});

	$("#permanent_address_country").change(function(){
		stateOptions = null;
		var x = $(this).val();
		$.getJSON('../json/states.json',function(result){
			stateOptions+="<option value='blank'>------------Select State------------</option>";
			$.each(result, function(key,value) {
				if(x==value.country_id){
					stateOptions+="<option value='"+value.id+"'>"+value.name+"</option>";
				}
			});
			$('#permanent_address_state').html(stateOptions);
		});
	});
	
	$("#state").change(function(){
		var x = $(this).val();
		cityOptions = null;
		$.getJSON('../json/cities.json',function(result){
			cityOptions+="<option value='blank'>------------Select City------------</option>";
			$.each(result, function(key,value) {
				if(x==value.state_id){
					cityOptions+="<option value='"+value.id+"'>"+value.name+"</option>";
				}
			});
			$('#city').html(cityOptions);
		});
	});

	$("#permanent_address_state").change(function(){
		var x = $(this).val();
		cityOptions = null;
		$.getJSON('../json/cities.json',function(result){
			cityOptions+="<option value='blank'>------------Select City------------</option>";
			$.each(result, function(key,value) {
				if(x==value.state_id){
					cityOptions+="<option value='"+value.id+"'>"+value.name+"</option>";
				}
			});
			$('#permanent_address_city').html(cityOptions);
		});
	});
});

