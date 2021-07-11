<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/pyongcom/public_html/s271147/kobeescake/PHPMailer/Exception.php';
require '/home8/pyongcom/public_html/s271147/kobeescake/PHPMailer/PHPMailer.php';
require '/home8/pyongcom/public_html/s271147/kobeescake/PHPMailer/SMTP.php';


include_once("dbconnect.php");

$email = $_POST['email'];
$newotp = rand(1000,9999);
$newpassword = random_password(10);
$passha = sha1($newpassword);

$sql = "SELECT * FROM tbl_users WHERE email = '$email'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE tbl_users SET otp = '$newotp', password = '$passha' WHERE email = '$email'";
        if ($conn->query($sqlupdate) === TRUE){
                sendEmail($newotp,$newpassword,$email);
                echo 'success';
        }else{
                echo 'failed';
        }
    }else{
        echo "failed";
    }

function sendEmail($otp,$newpassword,$email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                                               //Disable verbose debug output
    $mail->isSMTP();                                                    //Send using SMTP
    $mail->Host       = 'mail.pyong27.com';                         //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                           //Enable SMTP authentication
    $mail->Username   = 'noreply@pyong27.com';                    //SMTP username
    $mail->Password   = 'Na+R7rh_Aj}p';                                 //SMTP password
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    
    
    $from = "noreply@pyong27.com";
    $to = $email;
    $subject = "Reset Password for Kobees Cake";
    $message = "<p>Hi!<br><br>Your account password has been reset.<br>
    <a href='https://pyong27.com/s271147/kobeescake/php/verify.php?email=".$email."&key=".$otp."'>Click Here to reactivate your account</a>
    <br><br>Please use the password below to login.</p><br><br><h3>Password:".$newpassword."</h3>";
    
    $mail->setFrom($from,"KobeesCake");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}

function random_password($length){
    //A list of characters that can be used in our random password
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    //Create blank string
    $password = '';
    //Get the index of the last character in our $characters string
    $characterListLength = mb_strlen($characters, '8bit') - 1;
    //Loop from 1 to the length that was specified
    foreach(range(1,$length) as $i){
        $password .=$characters[rand(0,$characterListLength)];
    }
    return $password;
}
?>