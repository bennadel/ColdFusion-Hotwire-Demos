<cfscript>

	param name="request.context.text" type="string" default="";

	errorMessage = "";

	// Processing the note form submission.
	if ( request.isPost ) {

		try {

			application.noteService.createNote( request.context.text.trim() );
			// NOTE: Since our Turbo Frame has [target="_top"], Turbo Drive is going to
			// apply any response - including a Location header - to the top-level page,
			// not to the Turbo Frame. That means that upon success, we can simply
			// redirect the user back to the main page in order to render the newly-
			// created note.
			location( url = "../index.htm", addToken = false );

		} catch ( any error ) {

			errorResponse = application.errorService.getResponse( error );

			request.template.statusCode = errorResponse.statusCode;
			request.template.statusText = errorResponse.statusText;
			errorMessage = errorResponse.message;

		}

		// We only make it this far if there are errors in the form validation (and we
		// didn't redirect the user back to the main page). If the request can support
		// consuming a Turbo Stream (ie, it's been enhanced by Hotwire), then we need to
		// update the UI using stream directives, otherwise Turbo Drive will overwrite the
		// entire page (remember, [target="_top"]) without response.
		if ( request.turbo.isStream ) {

			include "_error.stream.cfm";
			exit;

		}

	}

	include "_create.cfm";

</cfscript>
