component
	output = false
	hint = "I define the application settings and event handlers."
	{

	// Define the application settings.
	this.name = "ToastMessagesDemo";
	this.applicationTimeout = createTimeSpan( 0, 1, 0, 0 );
	this.sessionManagement = false;
	this.setClientCookies = false;

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I run once to initialize the application.
	*/
	public void function onApplicationStart() {

		application.notes = [];

	}


	/**
	* I run once to initialize the request.
	*/
	public void function onRequestStart() {

		if ( url.keyExists( "init" ) ) {

			onApplicationStart();

		}

		request.newToasts = [];

	}


	/**
	* I process the requested script.
	*/
	public void function onRequest( required string scriptName ) {

		// The root-absolute path to this demo app (used in the page module).
		request.appPath = "/toast-messages/app";

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
