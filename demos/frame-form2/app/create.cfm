<cfscript>

	param name="form.text" type="string" default="";

	errorMessage = "";

	if ( request.isPost ) {

		try {

			application.noteService.createNote( form.text.trim() );

			// If we're in Turbo Frame and can support a Turbo Stream response, then we
			// will execute the success "redirect" using our custom Turbo Stream "visit"
			// action. This will essentially reload the two frames on the main page.
			if ( request.turbo.isFrame && request.turbo.isStream ) {

				include "./create.success-stream.cfm";
				exit;

			// If this is a normal top-level page action, then let's redirect back to the
			// main page as per usual ColdFusion control flow.
			} else {

				location( url = "index.htm", addToken = false );

			}

		} catch ( any error ) {

			errorResponse = application.errorService.getResponse( error );

			request.template.statusCode = errorResponse.statusCode;
			request.template.statusText = errorResponse.statusText;
			errorMessage = errorResponse.message;

		}

	}

	// If this request supports a Turbo Stream, then it means we've POST'ed the form and
	// need to render an error. In that case, we're going to use a stream operation to
	// swap-out the form with a fresh rendering.
	if ( request.turbo.isStream ) {

		include "create.view.stream.cfm";

	} else {

		include "create.view.cfm";

	}

</cfscript>
