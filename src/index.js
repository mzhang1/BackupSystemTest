

//When DOM is ready, Immediately perform AJAX request to fetch movies from DB
$.when( $.ready ).then(function(){
	//Callback function that will be called only if the AJAX query below succeeds

	//AJAX query to the server
	$.ajax({
		url: window.location.origin+"/app/requests.php",
		beforeSend: function(request){
			request.setRequestHeader("content-type", "text/plain");
		},
		dataType: "json",
		data: {
			"request": "getMovies"
		},
		success: (data) => {
			if(data.status === "ok" && Object.keys(data.data).length > 0){
				/**
				 * Notice : since I chose to return movie data as an hashtable, array functions won't work as an hashtable in PHP
				 * As PHP hashtable will be returned as an object in JS
				 */
				const renderTable = (data, jobs) => {
					/**
					 * Processes job list and returns job headers for the table
					 * @param array(strint) jobs the job list from the DB
					 * @returns string HTML representation of the job headers
					 */
					const renderJobHeaders = function(jobs){
						let result = "";
						for(let i = 0; i < jobs.length; i++){
							result += "<th>"+ jobs[i] +"</th>"
						}
						return result;
					};

					/**
					 * Takes an object with movie data and job list and returns a string that corresponds to the rows in HTML
					 * @param Object data All movie data retrived from the DB, keys of the objects are the ID of their respective movie in the DB
					 * @param Array jobs A simple array containing the title of the jobs (only in French)
					 * @returns string The HTML representation of the rows with the data of the movie
					 */
					const renderRows = function(data, jobs){
						const renderJobTiles = function(data, jobs){

							//Rendering contacts for each job found
							//Each contact will have a single row
							const renderContacts = function(contacts){
								if(!contacts)
									return "";

								let result = "";
								for(let i = 0; i < contacts.length; i++){
									result += "<div class='contactRow'>" + contacts[i].contactFirstname + " " + contacts[i].contactLastname + "</div>";
								}
								return result;
							};

							let result = "";
							for(let i = 0; i < jobs.length; i++){
								result += "<td>"+ (data.roles ? renderContacts(data.roles[jobs[i]]) : "") +"</td>"
							}
							return result;
						};

						let result = "";
						//Each ID represents a movie and therefore a row
						for(let id in data){
							result += "<tr>"
							+"<td class='cellTitle'>"+ data[id]["title"] +"</td>"
							+"<td>"+ data[id]["releaseYear"] +"</td>"
							+ renderJobTiles(data[id], jobs)
							+"</tr>";
						}
						return result;
					};

					//Rendering table
					return "<table>"
					+"<thead>"
						+"<tr>"
							+"<th class='cellTitle'>Titre</th>"
							+"<th>Année de sortie</th>"
							+ renderJobHeaders(jobs)
						+"</tr>"
					+"</thead>"
					+"<tbody>"
					+ renderRows(data, jobs)
					+"</tbody>"
					+"</table>";
				}

				$("#mainContent").html(renderTable(data.data, data.jobs));
			}
			else
				$("#mainContent").html("<span>No movie available</span>");
		},
		error: () => {
			$("#mainContent").html("<span>Error on Movie database load</span>");
		}
	});
});