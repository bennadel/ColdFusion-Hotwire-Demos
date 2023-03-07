component
	output = false
	hint = "I define the application settings and event handlers."
	{

	// Define the application settings.
	this.name = "SubmitButtonDemo";
	this.applicationTimeout = createTimeSpan( 0, 1, 0, 0 );
	this.sessionManagement = false;
	this.setClientCookies = false;

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once to initialize the request.
	*/
	public void function onRequestStart() {

		if ( url.keyExists( "init" ) ) {

			onApplicationStart();

		}

		request.context = structNew()
			.append( url )
			.append( form )
		;
		request.isGet = ( cgi.request_method == "get" );
		request.isPost = ! request.isGet;

		request.template = {
			statusCode: 200,
			statusText: "OK"
		};

		// When Turbo Drive makes requests to the ColdFusion server, it will modify the
		// HTTP request headers in two ways:
		// 
		// 1. If the request is made in the context of a Turbo Frame, the ID of the frame
		//    will be included as the header, "Turbo-Frame".
		// 
		// 2. If the request is a FORM submission, which can accept a Turbo Stream style
		//    response, a new type will be appended to the "Accept" header.
		var headers = getHttpRequestData( false ).headers;
		var turboFrame = ( headers[ "Turbo-Frame" ] ?: "" );

		request.turbo = {
			isFrame: turboFrame.len(),
			frame: turboFrame,
			isStream: ( headers[ "Accept" ] ?: "" ).findNoCase( "text/vnd.turbo-stream.html" )
		};

	}


	/**
	* I process the requested script.
	*/
	public void function onRequest( required string scriptName ) {

		// The root-absolute path to this demo app (used in the page module).
		request.appPath = "/submit-button/app";

		// Basecamp's Hotwire Turbo Drive will only work with static ".htm" or ".html"
		// file extensions (at the time of this writing). As such, in order to get Turbo
		// Drive to play nicely with ColdFusion's ".cfm" file extensions, we're going to
		// route all requests through the index file and then dynamically execute the
		// corresponding ColdFusion template.
		// --
		// CAUTION: In a production application, blindly invoking a CFML file based on a
		// user-provided value (path-info) can be dangerous. I'm only doing this as part
		// of a simplified demo.
		if ( cgi.path_info.len() ) {

			var turboScriptName = cgi.path_info
				// Replace the ".htm" file-extension with ".cfm".
				.reReplaceNoCase( "\.html?$", ".cfm" )
				// Strip off the leading slash.
				.right( -1 )
			;

			include "./#turboScriptName#";

		} else {

			include scriptName;

		}

	}

}
