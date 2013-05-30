$(function(){
	
	$("#form").validate({
		rules: {
			fname: {
				required: true,
				minlength: 3
			},
			lname: {
				required: true,
				minlength: 3
			},
			dob: { 
				required: true,
				date: true
			},
			telephone: {
				required: true,
				digits: true,
				minlength: 6
			},
			email: {
				required: true,
				email: true
			},
			sector_ids: {
				required: true
			}
		},
		messages: {
			name: {
				required: 'This field is required',
				minlength: 'Minimum length: 3'
			},
			dob: {
				required: 'This field is required'
			},
			telephone: {
				required: 'This field is required',
				digits: 'Invalid phone number',
				minlength: 'Minimum length: 6'
			},
			email: 'Invalid e-mail address',
			message: {
				required: 'This field is required'
			},
			sector_ids: {
				required: 'This field is required. Please pick a max of 3.'
			}
		},
		success: function(label) {
			label.html('OK').removeClass('error').addClass('ok');
			setTimeout(function(){
				label.fadeOut(500);
			}, 2000)
		}
	});
	
});
