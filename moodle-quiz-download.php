<?php

http://moodle.org/mod/forum/discuss.php?d=153580

/*
1. Create temporary file to remember cookies between curl calls.
2. Go to Moodle login page to get initial cookie.
3. Log in using your credentials.
4. Extract the session key assigned from the response (you need this only if you are submitting a form).
5. Go to the page you want to view/download.
6. Save the page, or submit a form, and save the result.
*/

// Define a temporary file for holding cookies
$cookiefile = tempnam($working_folder, "cookies"); 

// get session cookies to set up the Moodle interaction
$ch = curl_init(); 
curl_setopt($ch, CURLOPT_USERAGENT, $agent);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
curl_setopt($ch, CURLOPT_COOKIEFILE, $cookiefile);
curl_setopt($ch, CURLOPT_COOKIEJAR, $cookiefile);
curl_setopt($ch, CURLOPT_VERBOSE, $debug);
if ($debug) curl_setopt($ch, CURLOPT_STDERR, $debughandle);

curl_setopt($ch, CURLOPT_URL, $urlbase . "/login/index.php"); 
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
$result = curl_exec ($ch);
curl_close ($ch);

// login to Moodle

$postfields = array(
'username' => $username,
'password' => $password,
'testcookies' => '1'
);

$ch = curl_init(); 
curl_setopt($ch, CURLOPT_USERAGENT, $agent);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
curl_setopt($ch, CURLOPT_COOKIEFILE, $cookiefile);
curl_setopt($ch, CURLOPT_COOKIEJAR, $cookiefile);
curl_setopt($ch, CURLOPT_VERBOSE, $debug);
if ($debug) curl_setopt($ch, CURLOPT_STDERR, $debughandle);

curl_setopt($ch, CURLOPT_URL, $urlbase . '/login/index.php');
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postfields)); 
curl_setopt($ch, CURLOPT_POST, 1); 
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 0);
curl_setopt($ch, CURLOPT_HEADER, 1);
$result = curl_exec ($ch);
curl_close ($ch); 

if (!$result || !preg_match("/HTTP\/1.1 303 See Other/", $result))
{
unlink($cookiefile);
header("HTTP/1.0 403 Forbidden");
die("Username/password incorrect.\n");
}

// get session key

$ch = curl_init(); 
curl_setopt($ch, CURLOPT_USERAGENT, $agent);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
curl_setopt($ch, CURLOPT_COOKIEFILE, $cookiefile);
curl_setopt($ch, CURLOPT_COOKIEJAR, $cookiefile);
curl_setopt($ch, CURLOPT_VERBOSE, $debug);
if ($debug) curl_setopt($ch, CURLOPT_STDERR, $debughandle);

curl_setopt($ch, CURLOPT_URL, $urlbase . "/question/import.php?courseid=" . $courseid); 
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
$result = curl_exec ($ch);
curl_close ($ch);

if (!preg_match("/sesskey=(\w*)/", $result, $matches))
{
unlink($cookiefile);
header("HTTP/1.0 500 Internal Server Error");
die("Could not determine sesskey.\n");
}

$sesskey = $matches[1];

// Etc. ...