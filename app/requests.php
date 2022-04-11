<?php

/**
 * This file will receive data from AJAX queries and will perform tasks depending on the "request" parameter received
 */

namespace App;

require_once("headers.php");

use App\Api\MovieRequests;

$query = $_REQUEST['request'];
switch($query)
{
	case "getMovies":
		require_once("api/movierequests.php");
		echo json_encode(MovieRequests::getMovies());
		break;
}