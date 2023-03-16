<cfscript>

	// Since we're wrapping the generated content, we only care about the end-mode tag
	// execution. If we're in the start mode, just exit.
	if ( thistag.executionMode == "start" ) {

		exit method = "exitTemplate";

	}

	param name="attributes.section" type="string" default="";

	header
		statusCode = request.template.statusCode
		statusText = request.template.statusText
	;

</cfscript>

<!--- In end-mode tag execution, wrap (and override) the generated content. --->
<cfsavecontent variable="thistag.generatedContent">
	<cfoutput>

		<!doctype html>
		<html lang="en">
		<head>
			<meta charset="utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1" />
			<!---
				The "no-preview" directive tells Turbo Drive to not show a cached version
				during an "application visit" (ie, clicking a link, submitting a form);
				but, that caching can still be used for "restore visits" (ie, hitting the
				browser's back button).
			--->
			<!--- <meta name="turbo-cache-control" content="no-preview" /> --->
			<title>
				ColdFusion + Hotwire Demo
			</title>

			<!---
				CAUTION: Since Hotwire Turbo Drive needs to work with ".htm" files, I'm
				configuring the base HREF to apply relative paths as the PATH_INFO after
				the "hotwire.cfm" file (which doesn't exist). The onRequest() event
				handler (in Application.cfc) will then dynamically execute the
				corresponding ".cfm" file by swapping the ".htm" file-extension with a
				".cfm" file-extension.
				--
				NOTE: This is just for a local demo - I would not use this approach in a
				production setting (I'd use more robust URL rewriting).
			--->
			<base href="#request.appPath#/hotwire.cfm/" />

			<!---
				CAUTION: Since I'm setting the base-href to route through a ColdFusion
				file, our static assets have to use root-absolute paths so that they
				bypass the base tag settings.
			--->
			<script src="#request.appPath#/dist/main.js" defer async></script>
			<link rel="stylesheet" type="text/css" href="#request.appPath#/dist/main.css"></link>
		</head>
		<body data-controller="app">

			<h1>
				ColdFusion + Hotwire Incremental Application Demo
			</h1>

			<!---
				As various pages are updated to be Hotwire / Turbo Drive compatible, we
				can add the "data-turbo" attribute to their nav links. This way, even if
				most of the app is still powered by "old school" full page-refresh
				navigation, Turbo Drive can still kick-in where it will be a value-add.
				--
				Note that only the ABOUT page here is Turbo-enabled.
			--->
			<p>
				<a href="index.htm" <cfif ( attributes.section == "home" )>style="font-weight: bold ;"</cfif>>Home</a> -
				<a href="about.htm" data-turbo="true" <cfif ( attributes.section == "about" )>style="font-weight: bold ;"</cfif>>About</a> -
				<a href="contact.htm" <cfif ( attributes.section == "contact" )>style="font-weight: bold ;"</cfif>>Contact</a>
			</p>

			<hr />

			#thistag.generatedContent#

			<hr />

			<p>
				Page loaded at #timeFormat( now(), "HH:mm:ss.l" )#
			</p>

		</body>
		</html>

	</cfoutput>
</cfsavecontent>
