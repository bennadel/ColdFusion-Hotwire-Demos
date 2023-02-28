<cfscript>

	param name="form.text" type="string" default="";

	errorMessage = "";

	if ( request.isPost ) {

		try {

			application.noteService.createNote( form.text.trim() );

			// If we are in Turbo Frame and can support a Turbo Stream response, then we
			// will execute the REDIRECT using our custom Turbo Stream "visit" action.
			if ( request.turbo.isFrame && request.turbo.isStream ) {

				include "./create_stream.cfm";
				exit;

			// If this is a normal top-level page action, then let's redirect back to the
			// main page as per usual.
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

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Add Note
		</h2>

		<!---
			In order for this note creation form to be transcluded (in to the main page)
			by Turbo Drive, we have to wrap it in a Turbo Frame that corresponds to the
			lazy-loaded frame in the main page. For that, we'll use the frame ID that was
			reported in the HTTP headers (to reduce duplication).
			--
			NOTE: We are using target="_top" in this context so that if this page were
			loaded directly (via the URL), it would operate as if it weren't in a frame.
		--->
		<turbo-frame
			id="#encodeForHtmlAttribute( request.turbo.frame )#"
			target="_top">

			<cfif errorMessage.len()>
				<p class="error-message">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form method="post" action="create.htm">
				<p>
					<input type="text" name="text" size="40" autofocus />
				</p>
				<p>
					<button type="submit">
						Add Note
					</button>

					<!---
						This cancel button will be hidden (via the CSS class) when it is
						transcluded into the main page.
					--->
					<a href="index.htm" class="hide-if-transcluded">
						Cancel
					</a>

					<!---
						If this form is being transcluded into the main page, and it has
						an error message, let's show a button to clear / reset the form
						(to remove the error message). Depending on the type of form you
						have, this may not be necessary.
					--->
					<cfif ( request.turbo.isFrame && errorMessage.len() )>

						<a href="create.htm" data-turbo-frame="_self">
							Reset
						</a>

					</cfif>
				</p>
			</form>

		</turbo-frame>

	</cfoutput>
</cfmodule>
