<cfscript>

	param name="form.id" type="string";

	counter = application.counters.incrementCounter( form.id );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// Turbo Drive adds a special "Accept" header value for FORM actions.
	isTurboStreamAllowed = getHttpRequestData( false )
		.headers
		.accept
		.findNoCase( "text/vnd.turbo-stream.html" )
	;

	// We're going to treat the Turbo Drive interactions as a PROGRESSIVE ENHANCEMENT;
	// which means that, without Turbo Drive, this page request will be made as a normal,
	// top-level request. In that case, we just want to redirect the user back to the home
	// page, where the entire list of counters will be re-rendered.
	if ( ! isTurboStreamAllowed ) {

		location( url = "index.htm", addToken = false );

	}

</cfscript>

<!---
	If we made it this far, we know that the request is being executed by the Turbo Drive
	API client, which means we can render a list of Turbo Stream elements. In this case,
	now that we've incremented the counter, we need to REPLACE the old DOM rendering with
	a new DOM rendering (of the counter).
--->
<cfcontent type="text/vnd.turbo-stream.html; charset=utf-8" />
<cfoutput>

	<turbo-stream action="replace" target="#encodeForHtmlAttribute( counter.id )#">
		<template>

			<cfmodule
				template="counter.cfm"
				counter="#counter#">
			</cfmodule>

		</template>
	</turbo-stream>

</cfoutput>
