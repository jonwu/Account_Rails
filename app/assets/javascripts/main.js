
jQuery(document).ready(function($) {
	listeners()
});


function listeners (argument) {
	var username_field = $(".user input")
	var password_field = $(".password input")
	var message_field = $(".message")
	var endpoint = "/users/success?"
	var user_endpoint = "user="
	var password_endpoint = "password="

	$(".add").click(function(event) {
		var user_val = username_field.val()
		var password_val = password_field.val()
		$.ajax({
			url: '/users/add',
			type: 'post',
			dataType: 'json',
			data: {'user': user_val, 'password': password_val},
		})
		.done(function(data) {
			console.log("success");
			var errCode = data['errCode']
			var message = data['message']

			if(errCode == 1){
				console.log("hi")
				window.location.replace(endpoint+user_endpoint+user_val+"&"+password_endpoint+password_val);
			}else{
				message_field.text(data['message'])
			}
		})
		.fail(function() {
			console.log("error");
		})
		.always(function() {
			console.log("complete");
		});
			
	});

	$(".login").click(function(event) {
		var user_val = username_field.val()
		var password_val = password_field.val()
		$.ajax({
			url: '/users/login',
			type: 'post',
			dataType: 'json',
			data: {'user': user_val, 'password': password_val},
		})
		.done(function(data) {
			console.log("success");
			var errCode = data['errCode']
			var message = data['message']

			if(errCode == 1){
				console.log("hi")
				window.location.replace(endpoint+user_endpoint+user_val+"&"+password_endpoint+password_val);
			}else{
				message_field.text(data['message'])
			}
		})
		.fail(function() {
			console.log("error");
		})
		.always(function() {
			console.log("complete");
		});
			
	});
}