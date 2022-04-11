/*
	Sample data for testing purposes
	Import this after generating Database schema
	Notice: Since the IDs can vary, I didn't put any INSERT statement for the `movie_contact_jobs` table 
	which is the association table that links both of the four tables
*/

/*
	Using IGNORE to prevent duplicate key errors
*/
INSERT IGNORE INTO `job` (`title`, `title_en`) VALUES
	("Réalisateur","Director"),
	("Société de production", "Production Co."),
	("Société de distribution", "Distribution Co."),
	("Casting", "Cast"),
	("Scénariste", "Writer"),
	("Acheteur", "Buyer"),
	("Exportateur", "Sales agent"),
	("Financier", "Financer"),
	("Producteur", "Producer"),
	("Distributeur", "Distributor"),
	("Société de ventes", "Sales Co.");

INSERT INTO `contact` (`firstname`, `lastname`, `gender`) VALUES
	("Makoto", "Shinkai", "M"),
	("Nortaka", "Kawaguchi", "M"),
	("Genki", "Kawamura", "M"),
	("Ryunosuke", "Kamiki", "M"),
	("Mone", "Kamishiraishi", "F"),
	("Masami", "Nagasawa", "F"),
	('Cédric', 'Gimenez', 'M'),
	('Audrey', 'Diwan', "F"),
	('Gilles', 'Lellouche', "M"),
	('Karim', 'Leklou', "M"),
	("François", "Civil", "M"),
	("Adèle", "Exarchopoulos", "F");

INSERT INTO `movie` (`title`, `release_date`) VALUES
	("Your Name", "2016-12-28"),
	("Bac Nord"),
	("Emily In Paris", "2020-10-20");

