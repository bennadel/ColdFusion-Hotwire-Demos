<cfscript>

	// If the UNAUTHORIZED request is being made OUTSIDE OF ANY TURBO FRAME, then we can
	// simply redirect the user back to the login page, the same way that we might for any
	// other ColdFusion application using an authentication / authorization wall.
	if ( ! request.turbo.isFrame ) {

		location( url = "./index.htm", addToken = false );

	}

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// If the UNAUTHORIZED request is being made INSIDE A TURBO FRAME context, then
	// returning a redirect gets a bit tricky. The redirect will apply to the Turbo Frame
	// itself, not to the entire page. I'm not sure that there is a "right way" to do
	// this. For this demo, I'm going to return a static value (indicating the logged-out
	// state) with the option to also render a custom Turbo Stream element that performs
	// an automatic redirect.
	param name="url.useStream" type="boolean" default=false;

	header
		statusCode = 401
		statusText = "Unauthorized"
	;

</cfscript>
<cfoutput>
	<!--- Make sure to echo the correct frame ID. --->
	<turbo-frame id="#encodeForHtmlAttribute( request.turbo.frame )#">

		<p>
			You've been logged-out.
			<a href="./index.htm" data-turbo="false">Please login</a>
			to continue using the app.
		</p>

		<!---
			If the stream flag is enabled, this custom action will perform an automatic
			redirect of the top-level page.
		--->
		<cfif url.useStream>
			<turbo-stream
				action="visit"
				data-url="./index.htm">
			</turbo-stream>
		</cfif>

	</turbo-frame>
</cfoutput>
