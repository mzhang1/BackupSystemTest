<?php

/**
 * This file will receive queries from the requests.php file and will do DB queries related to movies
 */

namespace App\Api;

require_once("databaseconnection.php");

use PDO;
use App\Api\DatabaseConnection;

class MovieRequests{
	public static function getMovies(){
		//Using DatabaseConnection singleton to get a PDO object, allowing access to the DB
		//You will see a LEFT JOIN instead of INNER JOIN, this is because if there in no data from either the contact tile regarding a movie, INNER JOIN would omit it
		$pdo = DatabaseConnection::get();
		$stmt = $pdo->prepare("SELECT * FROM `movie` m
			LEFT JOIN (
				SELECT mcj.movie_id, j.id AS `job_id`,j.title AS `job_title`, c.id AS `contact_id`,
						c.firstname AS `contact_firstname`, c.lastname AS `contact_lastname`, c.gender AS `contact_gender`
				FROM `movie_contact_jobs` mcj
				INNER JOIN `contact` c ON mcj.contact_id = c.id
				INNER JOIN `job` j ON mcj.job_id = j.id
			) cr ON m.id = cr.movie_id
		");

		//If any error has occured, the AJAX query will receive a fail message, although the query will still result in a success
		if($stmt->execute() === false){
			return array("status" => "error", "message" => "Failed to fetch movie data");
		}

		//Fetching and parsing data received from query
		$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
		$result = array();
		foreach($data as $movieData){
			//If no data from the movie in the result array, insert movie data
			if(!array_key_exists($movieData['id'],$result)){
				$result[$movieData['id']] = array(
					"title" => $movieData['title'],
					"releaseYear" => date("Y", strtotime($movieData['release_date'])),	
				);
			}

			//Inserting contacts with their role
			if(!empty($movieData['job_id'])){
				$result[$movieData['id']]['roles'][$movieData['job_title']][] = array(
					"contactId" => $movieData['contact_id'],
					"contactFirstname" => $movieData['contact_firstname'],
					"contactLastname" => $movieData['contact_lastname']
				);
			}
		}

		//Fetching job list
		$stmt = $pdo->prepare("SELECT title FROM job");
		if($stmt->execute() === false){
			return array("status" => "error", "message" => "Failed to fetch job list");
		}
		$jobs = $stmt->fetchAll(PDO::FETCH_COLUMN, 0);
		return array("status" => "ok", "data" => $result, "jobs" => $jobs);
	}
}