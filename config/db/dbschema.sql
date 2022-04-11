/*
	Welcome to the SQL file
	This file's intent is to answer the questions for Exercise 1 of the test
	To begin : make sure you have the database set up(I chose backuptest as the name of the DB)

	I have written only 4 tables in order to match the form that is visible in the PDF
	To answer the question of how many tables will be needed, I think more than the 4 I have written would be better
	Why ? because the associative table `movie_contact_jobs` who acts as way to say who did which job in the movie will be huge
	This would make the database less and less readable as much as the job list enlarges

	I think the jobs which are most likely to have more than 5 contacts per movie like "cast" should be in a separate table.

	Another thing that would be good is to assign jobs for a contact for faster movie cast edit via an associative table
	it's name would be contact_jobs
*/

/*
	Table for people working into movies
*/
CREATE TABLE `contact` (
	`id` BIGINT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`firstname` VARCHAR(128) NOT NULL,
	`lastname` VARCHAR(128) NOT NULL,
	`gender` VARCHAR(15)
);

CREATE TABLE `job` (
	`id` INT(5) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`title` VARCHAR(256) NOT NULL,
	`title_en` VARCHAR(256) NOT NULL,
	CONSTRAINT `UNIQ_job_title` UNIQUE KEY(`title`)
);

/*
	I chose to put release_date in DATETIME format instead of INT 
	although INT would be simpler, its faster to extract the year from a DATETIME format as MySQL provides functions to do that
*/
CREATE TABLE `movie` (
	`id` BIGINT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`title` VARCHAR(256) NOT NULL,
	`release_date` DATETIME
);

/*
	This is an association table where contacts have their roles assigned to their respective movie
*/
CREATE TABLE `movie_contact_jobs` (
	`movie_id` BIGINT(10) NOT NULL ,
	`job_id` INT(5) NOT NULL,
	`contact_id` BIGINT(10) NOT NULL,
	CONSTRAINT `FK_movie_contact_jobs_movie_id_movie` FOREIGN KEY(`movie_id`) REFERENCES `movie`(`id`) ON DELETE CASCADE,
	CONSTRAINT `FK_movie_contact_jobs_contact_id_contact` FOREIGN KEY(`contact_id`) REFERENCES `contact`(`id`) ON DELETE CASCADE,
	CONSTRAINT `FK_movie_contact_jobs_job_id_job` FOREIGN KEY(`job_id`) REFERENCES `job`(`id`) ON DELETE CASCADE
);