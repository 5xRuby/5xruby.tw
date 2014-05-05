<?php

if(!$_POST) exit;

// Email verification, do not edit.
function isEmail($email_contact_home ) {
	return(preg_match("/^[-_.[:alnum:]]+@((([[:alnum:]]|[[:alnum:]][[:alnum:]-]*[[:alnum:]])\.)+(ad|ae|aero|af|ag|ai|al|am|an|ao|aq|ar|arpa|as|at|au|aw|az|ba|bb|bd|be|bf|bg|bh|bi|biz|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|com|coop|cr|cs|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|eh|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|in|info|int|io|iq|ir|is|it|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mo|mp|mq|mr|ms|mt|mu|museum|mv|mw|mx|my|mz|na|name|nc|ne|net|nf|ng|ni|nl|no|np|nr|nt|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|pro|ps|pt|pw|py|qa|re|ro|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tf|tg|th|tj|tk|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zw)$|(([0-9][0-9]?|[0-1][0-9][0-9]|[2][0-4][0-9]|[2][5][0-5])\.){3}([0-9][0-9]?|[0-1][0-9][0-9]|[2][0-4][0-9]|[2][5][0-5]))$/i",$email_contact_home ));
}

if (!defined("PHP_EOL")) define("PHP_EOL", "\r\n");

$name_contact_home     = $_POST['name_contact_home'];
$lastname_contact_home    = $_POST['lastname_contact_home'];
$email_contact_home    = $_POST['email_contact_home'];
$phone_contact_home   = $_POST['phone_contact_home'];
$course_home= $_POST['course_home'];
$verify_contact_home   = $_POST['verify_contact_home'];

if(trim($name_contact_home) == '') {
	echo '<div class="error_message" style="color:#ffd200">You must enter your Name.</div>';
	exit();
} else if(trim($lastname_contact_home) == '') {
	echo '<div class="error_message" style="color:#ffd200">You must enter your Last name.</div>';
	exit();
} else if(trim($email_contact_home) == '') {
	echo '<div class="error_message" style="color:#ffd200">Please enter a valid email address.</div>';
	exit();
} else if(!isEmail($email_contact_home)) {
	echo '<div class="error_message" style="color:#ffd200">You have enter an invalid e-mail address, try again.</div>';
	exit();
	} else if(trim($phone_contact_home) == '') {
	echo '<div class="error_message" style="color:#ffd200">Please enter a valid phone number.</div>';
	exit();
} else if(!is_numeric($phone_contact_home)) {
	echo '<div class="error_message" style="color:#ffd200">Phone number can only contain numbers.</div>';
	exit();
} else if(trim($course_home) == '') {
	echo '<div class="error_message" style="color:#ffd200">Please select a course.</div>';
	exit();
} else if(!isset($verify_contact_home) || trim($verify_contact_home) == '') {
	echo '<div class="error_message" style="color:#ffd200"> Please enter the verification number.</div>';
	exit();
} else if(trim($verify_contact_home) != '4') {
	echo '<div class="error_message" style="color:#ffd200">The verification number you entered is incorrect.</div>';
	exit();
}

if(get_magic_quotes_gpc()) {
	$message_contact_home = stripslashes($message_contact_home);
}


//$address = "HERE your email address";
$address = "test@ansonika.com";


// Below the subject of the email
$e_subject = 'You\'ve been contacted by ' . $name_contact_home . '.';

// You can change this if you feel that you need to.
$e_body = "You have been contacted by $name_contact_home $lastname_contact_home with attention to this course:" . PHP_EOL . PHP_EOL;
$e_content = "\"$course_home\"" . PHP_EOL . PHP_EOL;
$e_reply = "You can contact $lastname_contact_home via email $email_contact_home or via phone $phone_contact_home";

$msg = wordwrap( $e_body . $e_content . $e_reply, 70 );

$headers = "From: $email_contact_home" . PHP_EOL;
$headers .= "Reply-To: $email_contact_home" . PHP_EOL;
$headers .= "MIME-Version: 1.0" . PHP_EOL;
$headers .= "Content-type: text/plain; charset=utf-8" . PHP_EOL;
$headers .= "Content-Transfer-Encoding: quoted-printable" . PHP_EOL;

$user = "$email_contact_home";
$usersubject = "Thank You";
$userheaders = "From: info@learn.com\n";
$usermessage = "Thank you for contact LEARN. We will reply shortly with more details on the course: $course_home";
mail($user,$usersubject,$usermessage,$userheaders);

if(mail($address, $e_subject, $msg, $headers)) {

	// Success message
	echo "<div id='success_page' style='padding:20px 20px 50px 20px'>";
	echo "<strong >Email Sent.</strong>";
	echo "Thank you <strong>$name_contact_home</strong>,<br> your message has been submitted. We will contact you shortly.";
	echo "</div>";

} else {

	echo 'ERROR!';

}
