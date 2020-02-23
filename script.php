<?php
error_reporting(-1); // reports all errors
ini_set("display_errors", "1"); // shows all errors
ini_set("log_errors", 1);
ini_set("error_log", "/tmp/php-error.log");

if(isset($_POST["submit"])) {
    if($_POST['WHY'] != "")
    {  
      $entry = $_POST['WHAT'];
      $entry2 = $_POST['WHY'];

#	Input sanitation
    
	$caps = strtoupper($entry);
	$capsx = preg_replace('/[^a-z\d \'-.]/i', '', $caps);
    $newcaps = sprintf('"%s"',  $capsx);
    $caps2 = strtoupper($entry2);
    $caps2x = preg_replace('/[^a-z\d \'-.]/i', '', $caps2);
    $newcaps2 = sprintf('"%s"',  $caps2x);
    
#	use random number instead of epochtime
    
	$epochtime = mt_rand(0,1000000);
	
#	Post output to shell script
	
	$output = shell_exec("/var/www/ilovecitr.us/bloomberg/script.sh $newcaps $newcaps2 $epochtime 2>&1");
	$file = "$epochtime" . ".jpg";
	
#return result to browser

	exit(header("Location: https://ilovecitr.us/bloomberg/$file"));

    }
}
?>
