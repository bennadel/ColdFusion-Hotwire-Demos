component
	output = false
	hint = "I help translate application errors into appropriate response codes and user-friendly messages."
	{

	/**
	* I generate a 400 response object for the given error attributes.
	*/
	public struct function as400( struct errorAttributes = {} ) {

		return( getGeneric400Response().append( errorAttributes ) );

	}


	/**
	* I generate a 403 response object for the given error attributes.
	*/
	public struct function as403( struct errorAttributes = {} ) {

		return( getGeneric403Response().append( errorAttributes ) );

	}


	/**
	* I generate a 404 response object for the given error attributes.
	*/
	public struct function as404( struct errorAttributes = {} ) {

		return( getGeneric404Response().append( errorAttributes ) );

	}


	/**
	* I generate a 422 response object for the given error attributes.
	*/
	public struct function as422( struct errorAttributes = {} ) {

		return( getGeneric422Response().append( errorAttributes ) );

	}


	/**
	* I generate a 500 response object for the given error attributes.
	*/
	public struct function as500( struct errorAttributes = {} ) {

		return( getGeneric500Response().append( errorAttributes ) );

	}


	/**
	* I return a generic 400 Bad Request response.
	*/
	public struct function getGeneric400Response() {

		return({
			statusCode: 400,
			statusText: "Bad Request",
			type: "BadRequest",
			title: "Bad Request",
			message: "Please validate the information in your request and try submitting it again."
		});

	}


	/**
	* I return a generic 403 Forbidden response.
	*/
	public struct function getGeneric403Response() {

		return({
			statusCode: 403,
			statusText: "Forbidden",
			type: "Forbidden",
			title: "Forbidden",
			message: "Sorry, the request you made is not permitted at this time."
		});

	}


	/**
	* I return a generic 404 Not Found response.
	*/
	public struct function getGeneric404Response() {

		return({
			statusCode: 404,
			statusText: "Not Found",
			type: "NotFound",
			title: "Page Not Found",
			message: "Sorry, it seems that the page you requested either doesn't exist or has been moved to a new location."
		});

	}


	/**
	* I return a generic 422 Unprocessable Entity response.
	*/
	public struct function getGeneric422Response() {

		return({
			statusCode: 422,
			statusText: "Unprocessable Entity",
			type: "UnprocessableEntity",
			title: "Unprocessable Entity",
			message: "Please validate the information in your request and try submitting it again."
		});

	}


	/**
	* I return a generic 500 Server Error response.
	*/
	public struct function getGeneric500Response() {

		return({
			statusCode: 500,
			statusText: "Server Error",
			type: "ServerError",
			title: "Something Went Wrong",
			message: "Sorry, an unexpected error occurred while processing your request."
		});

	}


	/**
	* I return the error RESPONSE for the given error object. This response information is
	* safe to show to the user.
	*/
	public struct function getResponse( required any error ) {

		switch ( error.type ) {
			case "App.Model.Note.Text.Empty":
				return(
					as422({
						type: error.type,
						message: "Please provide content for your note."
					})
				);
			break;
			case "App.Model.Note.Text.SuspiciousWhiteSpace":
				return(
					as422({
						type: error.type,
						message: "It looks like your note might contain leading or trailing white-space."
					})
				);
			break;
			// Anything not handled by an explicit case becomes a generic 500 response.
			default:
				return( as500() );
			break;
		}

	}


	/**
	* I return the error MESSAGE for the given error object. This message is safe to show
	* to the user.
	*/
	public string function getResponseMessage( required any error ) {

		return( getResponse( error ).message );

	}

}
