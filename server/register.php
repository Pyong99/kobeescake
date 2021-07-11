<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/pyongcom/public_html/s271147/kobeescake/PHPMailer/Exception.php';
require '/home8/pyongcom/public_html/s271147/kobeescake/PHPMailer/PHPMailer.php';
require '/home8/pyongcom/public_html/s271147/kobeescake/PHPMailer/SMTP.php';

include_once("dbconnect.php");

$name = $_POST['name'];
$email = $_POST['email'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(1000,9999);
$quantity = "0";
$rating = "0";
$credit = "0";
$status = "active";

$sqlregister = "INSERT INTO tbl_users(name,email,password,otp,quantity,rating,credit,status) VALUES('$name','$email','$passha1','$otp','$quantity','$rating','$credit','$status')";
if ($conn->query($sqlregister) === TRUE){
    echo "success";
    sendEmail($otp,$email);
}else{
    echo "failed";
}
function sendEmail($otp,$email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                           //Disable verbose debug output
    $mail->isSMTP();                                //Send using SMTP
    $mail->Host       = 'mail.pyong27.com';                         //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                       //Enable SMTP authentication
    $mail->Username   = 'noreply@pyong27.com';                         //SMTP username
    $mail->Password   = 'Na+R7rh_Aj}p';                         //SMTP password
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    
    $from = "noreply@pyong27.com";
    $to = $email;
    $subject = "Account Verification for Kobees Cake";
    $message = "<p>Hi!<br><br>Welcome to Kobees Cake. Your account is successfully created!<a href='https://pyong27.com/s271147/kobeescake/php/verify.php?email=".$email."&key=".$otp."'>Click Here</a> to verify your account";
    $header = "From:".$from;
    mail($email,$subject,$message,$header);
  
    $mail->setFrom($from,"KobeesCake");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}
?>