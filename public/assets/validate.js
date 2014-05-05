/* <![CDATA[ */

/// Jquery validate newsletter
jQuery(document).ready(function(){

	$('#newsletter').submit(function(){

		var action = $(this).attr('action');

		$("#message-newsletter").slideUp(750,function() {
		$('#message-newsletter').hide();
		
		$('#submit-newsletter')
			.after('<i class="icon-spin4 animate-spin loader"></i>')
			.attr('disabled','disabled');

		$.post(action, {
			email_newsletter: $('#email_newsletter').val()
		},
			function(data){
				document.getElementById('message-newsletter').innerHTML = data;
				$('#message-newsletter').slideDown('slow');
				$('#newsletter .loader').fadeOut('slow',function(){$(this).remove()});
				$('#submit-newsletter').removeAttr('disabled');
				if(data.match('success') != null) $('#newsletter').slideUp('slow');

			}
		);

		});

		return false;

	});

});
// Jquery validate form contact
jQuery(document).ready(function(){

	$('#contactform').submit(function(){

		var action = $(this).attr('action');

		$("#message-contact").slideUp(750,function() {
		$('#message-contact').hide();

 		$('#submit-contact')
			.after('<i class="icon-spin4 animate-spin loader"></i>')
			.attr('disabled','disabled');
			
		$.post(action, {
			name_contact: $('#name_contact').val(),
			lastname_contact: $('#lastname_contact').val(),
			email_contact: $('#email_contact').val(),
			phone_contact: $('#phone_contact').val(),
			message_contact: $('#message_contact').val(),
			verify_contact: $('#verify_contact').val()
		},
			function(data){
				document.getElementById('message-contact').innerHTML = data;
				$('#message-contact').slideDown('slow');
				$('#contactform .loader').fadeOut('slow',function(){$(this).remove()});
				$('#submit-contact').removeAttr('disabled');
				if(data.match('success') != null) $('#contactform').slideUp('slow');

			}
		);

		});

		return false;

	});
		});
		
// Jquery validate form contact
jQuery(document).ready(function(){

	$('#contactform_home').submit(function(){

		var action = $(this).attr('action');

		$("#message-contact-home").slideUp(750,function() {
		$('#message-contact-home').hide();

 		$('#submit-contact-home')
			.after('<i class="icon-spin4 animate-spin loader"></i>')
			.attr('disabled','disabled');
			
		$.post(action, {
			name_contact_home: $('#name_contact_home').val(),
			lastname_contact_home: $('#lastname_contact_home').val(),
			email_contact_home: $('#email_contact_home').val(),
			phone_contact_home: $('#phone_contact_home').val(),
			course_home: $('#course_home').val(),
			verify_contact_home: $('#verify_contact_home').val()
		},
			function(data){
				document.getElementById('message-contact-home').innerHTML = data;
				$('#message-contact-home').slideDown('slow');
				$('#contactform_home .loader').fadeOut('slow',function(){$(this).remove()});
				$('#submit-contact-home').removeAttr('disabled');
				if(data.match('success') != null) $('#contactform_home').slideUp('slow');

			}
		);

		});

		return false;

	});
		});
		
// Jquery validate form contact
jQuery(document).ready(function(){

	$('#contactform_apply').submit(function(){

		var action = $(this).attr('action');

		$("#message-apply").slideUp(750,function() {
		$('#message-apply').hide();

 		$('#submit-apply')
			.after('<i class="icon-spin4 animate-spin loader"></i>')
			.attr('disabled','disabled');
			
		$.post(action, {
			name_apply: $('#name_apply').val(),
			lastname_apply: $('#lastname_apply').val(),
			email_apply: $('#email_apply').val(),
			phone_apply: $('#phone_apply').val(),
			country_apply: $('#country_apply').val(),
			gender_apply: $('#gender_apply').val(),
			age_apply: $('#age_apply').val(),
			education_apply: $('#education_apply').val(),
			course_apply: $('#course_apply').val(),
			message_apply_2: $('#message_apply_2').val(),
			verify_apply: $('#verify_apply').val()
		},
			function(data){
				document.getElementById('message-apply').innerHTML = data;
				$('#message-apply').slideDown('slow');
				$('#contactform_apply .loader').fadeOut('slow',function(){$(this).remove()});
				$('#submit-apply').removeAttr('disabled');
				if(data.match('success') != null) $('#contactform_apply').slideUp('slow');

			}
		);

		});

		return false;

	});
		});

  /* ]]> */