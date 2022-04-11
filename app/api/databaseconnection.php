<?php
/**
 * This class generates an unique instance of database connection
 * Enables PDO functions use
 */

namespace App\Api;

use PDO;

class DatabaseConnection{

	private static $_instance = null;

	/**
	 * Called only if no database connection is open
	 * Opens a new database connection
	 * @return PDO A new PDO instance
	 * @throws Exception Failure 
	 */
	private static function generateConnection(){
		return new PDO(
			"mysql:dbname=backuptest; host=127.0.0.1", 
			"root",
			""
		);
	}

	/**
	 * Checks if a database connection is open
	 * @return DatabaseConnection An unique PDO instance
	 */
	public static function get(){
		if(is_null(self::$_instance))
			self::$_instance = self::generateConnection();
		return self::$_instance;
	}
}